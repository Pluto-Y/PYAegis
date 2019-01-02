//
//  NSCountedSet+PYAegis.m
//  PYAegis
//
//  Created by Pluto-Y on 2018/12/7.
//  Copyright © 2018 pluto-y. All rights reserved.
//

#import "NSCountedSet+PYAegis.h"
#import "NSObject+MethodSwizzling.h"

@implementation NSCountedSet (PYAegis)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [NSCountedSet methodSwizzleForInstanceFrom:@selector(addObject:) to:@selector(pya_addObject:)];
        [NSCountedSet methodSwizzleForInstanceFrom:@selector(removeObject:) to:@selector(pya_removeObject:)];
    });
}

- (void)pya_addObject:(id)object {
    if (!object) {
        PYACrashLog(PYACrashTypeContainer, @"-[NSCountedSet addObject:]: attempt to insert nil");
        return;
    }
    [self pya_addObject:object];
}

- (void)pya_removeObject:(id)object {
    if (!object) {
        PYACrashLog(PYACrashTypeContainer, @"-[NSCountedSet removeObject:]: attempt to remove nil");
        return;
    }
    [self pya_removeObject:object];
}

@end
