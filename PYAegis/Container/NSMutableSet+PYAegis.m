//
//  NSMutableSet+PYAegis.m
//  PYAegis
//
//  Created by Pluto-Y on 2018/12/6.
//  Copyright © 2018 pluto-y. All rights reserved.
//

#import "NSMutableSet+PYAegis.h"
#import "NSObject+MethodSwizzling.h"

@implementation NSMutableSet (PYAegis)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class __NSSetM = NSClassFromString(@"__NSSetM");
        [__NSSetM methodSwizzleForInstanceFrom:@selector(addObject:) to:@selector(pya_addObject:)];
        [__NSSetM methodSwizzleForInstanceFrom:@selector(removeObject:) to:@selector(pya_removeObject:)];
    });
}

- (void)pya_addObject:(id)object {
    if (!object) {
        PYACrashLog(PYACrashTypeContainer, @"-[__NSSetM addObject:]: object cannot be nil");
        return;
    }
    [self pya_addObject:object];
}

- (void)pya_removeObject:(id)object {
    if (!object) {
        PYACrashLog(PYACrashTypeContainer, @"-[__NSSetM removeObject:]: object cannot be nil");
        return;
    }
    [self pya_removeObject:object];
}

@end
