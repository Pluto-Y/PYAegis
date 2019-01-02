//
//  NSSet+PYAegis.m
//  PYAegis
//
//  Created by Pluto-Y on 2018/12/6.
//  Copyright © 2018 pluto-y. All rights reserved.
//

#import "NSSet+PYAegis.h"
#import "NSObject+MethodSwizzling.h"

@implementation NSSet (PYAegis)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (@available(iOS 9.0, *)) {
            Class __NSSingleObjectSetI = NSClassFromString(@"__NSSingleObjectSetI");
            [__NSSingleObjectSetI methodSwizzleForInstanceFrom:@selector(enumerateObjectsWithOptions:usingBlock:) to:@selector(pya__NSSingleObjectSetI_enumerateObjectsWithOptions:usingBlock:)];
        }
        Class __NSPlaceholderSet = NSClassFromString(@"__NSPlaceholderSet");
        [__NSPlaceholderSet methodSwizzleForInstanceFrom:@selector(count) to:@selector(pya__NSPlaceholderSet_count)];
        [__NSPlaceholderSet methodSwizzleForInstanceFrom:@selector(initWithObjects:count:) to:@selector(pya_initWithObjects:count:)];
        Class __NSSetI = NSClassFromString(@"__NSSetI");
        [__NSSetI methodSwizzleForInstanceFrom:@selector(enumerateObjectsWithOptions:usingBlock:) to:@selector(pya__NSSetI_enumerateObjectsWithOptions:usingBlock:)];
        [NSSet methodSwizzleForInstanceFrom:@selector(setByAddingObject:) to:@selector(pya_setByAddingObject:)];
        [NSSet methodSwizzleForInstanceFrom:@selector(enumerateObjectsUsingBlock:) to:@selector(pya_enumerateObjectsUsingBlock:)];
        
    });
}

- (NSUInteger)pya__NSPlaceholderSet_count {
    PYACrashLog(PYACrashTypeContainer, @"-[NSSet count]: method sent to an uninitialized immutable set object");
    return 0;
}

- (NSSet *)pya_setByAddingObject:(id)anObject {
    if (!anObject) {
        PYACrashLog(PYACrashTypeContainer, @"-[NSSet setByAddingObject:]: object cannot be nil");
        return nil;
    }
    return [self pya_setByAddingObject:anObject];
}

- (void)pya_enumerateObjectsUsingBlock:(void (^)(id _Nonnull, BOOL * _Nonnull))block {
    if (!block) {
        PYACrashLog(PYACrashTypeContainer, @"-[NSSet enumerateObjectsUsingBlock:]: block cannot be nil");
        return;
    }
    [self pya_enumerateObjectsUsingBlock:block];
}

- (void)pya__NSSingleObjectSetI_enumerateObjectsWithOptions:(NSEnumerationOptions)opts usingBlock:(void (^)(id _Nonnull, BOOL * _Nonnull))block {
    if (!block) {
        PYACrashLog(PYACrashTypeContainer, @" -[__NSSingleObjectSetI enumerateObjectsWithOptions：usingBlock:]: block cannot be nil");
        return;
    }
    [self pya__NSSingleObjectSetI_enumerateObjectsWithOptions:opts usingBlock:block];
}

- (void)pya__NSSetI_enumerateObjectsWithOptions:(NSEnumerationOptions)opts usingBlock:(void (^)(id _Nonnull, BOOL * _Nonnull))block {
    if (!block) {
        PYACrashLog(PYACrashTypeContainer, @"-[__NSSetI enumerateObjectsWithOptions：usingBlock:]: block cannot be nil");
        return;
    }
    [self pya__NSSetI_enumerateObjectsWithOptions:opts usingBlock:block];
}

- (instancetype)pya_initWithObjects:(id  _Nonnull const [])objects count:(NSUInteger)cnt {
    for (int i = 0; i < cnt; i ++) {
        id obj = objects[i];
        if (!obj) {
#warning "Consider how to solve it"
            return nil; // "NSInvalidArgumentException", "*** -[__NSPlaceholderSet initWithObjects:count:]: attempt to insert nil object from objects[0]"
        }
    }
    return [self pya_initWithObjects:objects count:cnt];
}

// TODO: consider how to do this hook
//- (void)pya__NSSingleObjectSetI_makeObjectsPerformSelector:(SEL)aSelector {
//    if (!aSelector) {
//        return; // "NSInvalidArgumentException", "-[__NSSingleObjectSetI (null selector)]: unrecognized selector sent to instance 0x7f9b87526380"
//    }
//    [self pya__NSSingleObjectSetI_makeObjectsPerformSelector:aSelector];
//}
//
//- (void)pya__NSSetI_makeObjectsPerformSelector:(SEL)aSelector {
//    if (!aSelector) {
//        return; // "NSInvalidArgumentException", "-[__NSSetI (null selector)]: unrecognized selector sent to instance 0x7faffaa005c0"
//    }
//    [self pya__NSSetI_makeObjectsPerformSelector:aSelector];
//}

//- (void)pya_makeObjectsPerformSelector:(SEL)aSelector withObject:(id)argument {
//    if (!aSelector) {
//        return; // "NSInvalidArgumentException", "-[__NSSetI (null selector)]: unrecognized selector sent to instance 0x7fa131800760"
//    }
//    // "NSInvalidArgumentException", "-[__NSCFNumber isFileURL]: unrecognized selector sent to instance 0xaafece9bb647c9ca"
//}

@end
