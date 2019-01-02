//
//  NSMutableDictionary+PYAegis.m
//  PYAegis
//
//  Created by linhuijie on 2018/12/3.
//  Copyright © 2018年 pluto-y. All rights reserved.
//

#import "NSMutableDictionary+PYAegis.h"
#import "NSObject+MethodSwizzling.h"

@implementation NSMutableDictionary (PYAegis)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class __NSDictionaryM = NSClassFromString(@"__NSDictionaryM");
        
        [__NSDictionaryM methodSwizzleForInstanceFrom:@selector(setObject:forKey:) to:@selector(pya_setObject:forKey:)];
        [__NSDictionaryM methodSwizzleForInstanceFrom:@selector(setValue:forKey:) to:@selector(pya_setValue:forKey:)];
        [__NSDictionaryM methodSwizzleForInstanceFrom:@selector(setValue:forKeyPath:) to:@selector(pya_setValue:forKeyPath:)];
        [__NSDictionaryM methodSwizzleForInstanceFrom:@selector(removeObjectForKey:) to:@selector(pya_removeObjectForKey:)];
        [__NSDictionaryM methodSwizzleForInstanceFrom:@selector(removeObjectsForKeys:) to:@selector(pya_removeObjectsForKeys:)];
    });
}

- (void)pya_setObject:(id)anObject forKey:(id<NSCopying>)aKey {
    if (!aKey) {
        PYACrashLog(PYACrashTypeContainer, @"-[__NSDictionaryM setObject:forKey:]: key cannot be nil");
        return;
        
    } else if (!anObject) {
        PYACrashLog(PYACrashTypeContainer, @"-[__NSDictionaryM setObject:forKey:]: object cannot be nil (key: )");
        return;
    }
    
    [self pya_setObject:anObject forKey:aKey];
}

- (void)pya_setValue:(id)value forKey:(NSString *)key {
    if (!key) {
        PYACrashLog(PYACrashTypeContainer, @"-[__NSDictionaryM setObject:forKey:]: key cannot be nil");
        return;
    }
    
    [self pya_setValue:value forKey:key];
}

- (void)pya_setValue:(id)value forKeyPath:(NSString *)keyPath {
    if (!keyPath) {
        PYACrashLog(PYACrashTypeContainer, @"-[__NSDictionaryM setObject:forKey:]: key cannot be nil");
        return;
    }
    
    [self pya_setValue:value forKeyPath:keyPath];
}

- (void)pya_removeObjectForKey:(id)aKey {
    if (!aKey) {
        PYACrashLog(PYACrashTypeContainer, @"-[__NSDictionaryM removeObjectForKey:]: key cannot be nil");
        return;
    }
    
    [self pya_removeObjectForKey:aKey];
}

- (void)pya_removeObjectsForKeys:(NSArray *)keyArray {
    if (![keyArray isKindOfClass:[NSArray class]]) {
        PYACrashLog(PYACrashTypeContainer, @"-[NSMutableDictionary removeObjectsForKeys:]: array argument is not an NSArray");
        return;
    }
    
    [self pya_removeObjectsForKeys:keyArray];
}

@end
