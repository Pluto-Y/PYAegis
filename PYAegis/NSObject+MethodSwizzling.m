//
//  NSObject+MethodSwizzling.m
//  PYAegis
//
//  Created by Pluto-Y on 22/08/2018.
//  Copyright © 2018 pluto-y. All rights reserved.
//

#import "NSObject+MethodSwizzling.h"
#import <objc/runtime.h>

@implementation NSObject (MethodSwizzling)

+ (void)methodSwizzleForInstanceFrom:(SEL)origin to:(SEL)target {
    Class cls = [self class];
    Method originMethod = class_getInstanceMethod(cls, origin);
    Method targetMethod = class_getInstanceMethod(cls, target);
    
    if (class_addMethod(cls, origin, method_getImplementation(targetMethod), method_getTypeEncoding(targetMethod))) {
        class_replaceMethod(cls, target, method_getImplementation(originMethod), method_getTypeEncoding(originMethod));
    } else {
        method_exchangeImplementations(originMethod, targetMethod);
    }
}

+ (void)methodSwizzleForClassFrom:(SEL)origin to:(SEL)target {
    Class cls = object_getClass([self class]);
//    Class cls = [self class];
    Method originMethod = class_getClassMethod(cls, origin);
    Method targetMethod = class_getClassMethod(cls, target);
    
    if (class_addMethod(cls, origin, method_getImplementation(targetMethod), method_getTypeEncoding(targetMethod))) {
        class_replaceMethod(cls, target, method_getImplementation(originMethod), method_getTypeEncoding(originMethod));
    } else {
        method_exchangeImplementations(originMethod, targetMethod);
    }
}

@end
