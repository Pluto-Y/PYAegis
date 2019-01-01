//
//  NSObject+UnregnizedSelector.m
//  PYAegis
//
//  Created by Pluto-Y on 24/08/2018.
//  Copyright © 2018 pluto-y. All rights reserved.
//

#import "NSObject+UnregnizedSelector.h"
#import "NSObject+MethodSwizzling.h"
#import <objc/runtime.h>

void unrecognizedSelectMethod(id self, SEL _cmd) { }

@interface PYAUnrecognizedSelectorProxy : NSObject

@end

@implementation PYAUnrecognizedSelectorProxy

@end

@implementation NSObject (UnrecognizedSelector)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [NSObject methodSwizzleForInstanceFrom:@selector(forwardingTargetForSelector:) to:@selector(pya_forwardingTargetForSelector:)];
    });
}

- (id)pya_forwardingTargetForSelector:(SEL)aSelector {
    Class cls = [self class];
    NSString *clsStr = NSStringFromClass(cls);
//    NSLog(@"%s current class is %@", __func__, clsStr);
    
    // Ignore the system class
    if ([clsStr hasPrefix:@"_DT"] || [clsStr hasPrefix:@"__NS"]) {
        return [self pya_forwardingTargetForSelector:aSelector];
    }
    
    Class objCls = [NSObject class];
    SEL forwardInvocationSEL = @selector(forwardInvocation:);
    Method clsMethod = class_getInstanceMethod(cls, forwardInvocationSEL);
    Method objClsMethod = class_getInstanceMethod(objCls, forwardInvocationSEL);
    
    // If the subclass has overrirde forwardInvocation:, just ignore it.
    if (method_getImplementation(clsMethod) != method_getImplementation(objClsMethod)) {
        NSLog(@"The class(%@) has override forwardInvocation:, so call the origin method.", clsStr);
        return [self pya_forwardingTargetForSelector:aSelector];
    } else {
        PYACrashLog(PYACrashTypeUnrecognizedSelector, @"-[%@ %@]: unrecognized selector sent to instance %p", NSStringFromClass(self.class), NSStringFromSelector(aSelector), self);
        Class proxyCls = [PYAUnrecognizedSelectorProxy class];
        class_addMethod(proxyCls, aSelector, (IMP)unrecognizedSelectMethod, "v@:");
        return [PYAUnrecognizedSelectorProxy new];
    }
}

@end
