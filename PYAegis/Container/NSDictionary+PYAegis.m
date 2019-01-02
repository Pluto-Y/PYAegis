//
//  NSDictionary+PYAegis.m
//  PYAegis
//
//  Created by linhuijie on 2018/12/10.
//  Copyright © 2018年 pluto-y. All rights reserved.
//

#import "NSDictionary+PYAegis.h"
#import "NSObject+MethodSwizzling.h"

@implementation NSDictionary (PYAegis)
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (@available(iOS 10.0, *)) {
            Class __NSSingleEntryDictionaryI = NSClassFromString(@"__NSSingleEntryDictionaryI");
            [__NSSingleEntryDictionaryI methodSwizzleForInstanceFrom:@selector(enumerateKeysAndObjectsWithOptions:usingBlock:) to:@selector(pya__NSSingleEntryDictionaryI_enumerateKeysAndObjectsWithOptions:usingBlock:)];
        }
        
        Class __NSDictionaryI = NSClassFromString(@"__NSDictionaryI");
        [__NSDictionaryI methodSwizzleForInstanceFrom:@selector(enumerateKeysAndObjectsWithOptions:usingBlock:) to:@selector(pya__NSDictionaryI_enumerateKeysAndObjectsWithOptions:usingBlock:)];
        
        Class __NSPlaceholderDictionary = NSClassFromString(@"__NSPlaceholderDictionary");
        [__NSPlaceholderDictionary methodSwizzleForInstanceFrom:@selector(initWithObjects:forKeys:count:) to:@selector(pya_initWithObjects:forKeys:count:)];
        
        Class NSDictionaryCls = [NSDictionary class];
        [NSDictionaryCls methodSwizzleForInstanceFrom:@selector(initWithDictionary:copyItems:) to:@selector(pya_initWithDictionary:copyItems:)];
        [NSDictionaryCls methodSwizzleForInstanceFrom:@selector(enumerateKeysAndObjectsUsingBlock:) to:@selector(pya_enumerateKeysAndObjectsUsingBlock:)];
        [NSDictionaryCls methodSwizzleForInstanceFrom:@selector(enumerateKeysAndObjectsWithOptions:usingBlock:) to:@selector(pya_enumerateKeysAndObjectsWithOptions:usingBlock:)];
        [NSDictionaryCls methodSwizzleForInstanceFrom:@selector(objectsForKeys:notFoundMarker:) to:@selector(pya_objectsForKeys:notFoundMarker:)];
        
    });
}

- (void)pya__NSSingleEntryDictionaryI_enumerateKeysAndObjectsWithOptions:(NSEnumerationOptions)opts usingBlock:(void (^)(id _Nonnull, id _Nonnull, BOOL * _Nonnull))block {
    
    if (!block) {
        PYACrashLog(PYACrashTypeContainer, @"-[NSDictionary enumerateKeysAndObjectsWithOptions:usingBlock:]: block cannot be nil");
        return;
    }
    
    [self pya__NSSingleEntryDictionaryI_enumerateKeysAndObjectsWithOptions:opts usingBlock:block];
}

- (void)pya__NSDictionaryI_enumerateKeysAndObjectsWithOptions:(NSEnumerationOptions)opts usingBlock:(void (^)(id _Nonnull, id _Nonnull, BOOL * _Nonnull))block {
    
    if (!block) {
        PYACrashLog(PYACrashTypeContainer, @"-[NSDictionary enumerateKeysAndObjectsWithOptions:usingBlock:]: block cannot be nil");
        return;
    }
    
    [self pya__NSDictionaryI_enumerateKeysAndObjectsWithOptions:opts usingBlock:block];
}

- (instancetype)pya_initWithObjects:(id  _Nonnull const [])objects forKeys:(id<NSCopying>  _Nonnull const [])keys count:(NSUInteger)cnt {
    
    for (int i = 0 ; i < cnt ; i ++) {
        if (keys[i] == nil) {
            PYACrashLog(PYACrashTypeContainer, @"-[__NSPlaceholderDictionary initWithObjects:forKeys:count:]: attempt to insert nil object from objects[%d]", i);
            return nil;
        }
    }
    
    for (int i = 0 ; i < cnt ; i ++) {
        if (objects[i] == nil) {
            PYACrashLog(PYACrashTypeContainer, @"-[__NSPlaceholderDictionary initWithObjects:forKeys:count:]: attempt to insert nil object from objects[%d]", i);
            return nil;
        }
    }
    
    return [self pya_initWithObjects:objects forKeys:keys count:cnt];
}

- (instancetype)pya_initWithDictionary:(NSDictionary *)otherDictionary copyItems:(BOOL)flag {
    if (![otherDictionary isKindOfClass:[NSDictionary class]]) {
        PYACrashLog(PYACrashTypeContainer, @"-[NSDictionary initWithDictionary:copyItems:]: dictionary argument is not an NSDictionary");
        return nil;
    }
    
    return [self pya_initWithDictionary:otherDictionary copyItems:flag];
}

- (void)pya_enumerateKeysAndObjectsUsingBlock:(void (^)(id _Nonnull, id _Nonnull, BOOL * _Nonnull))block {
    
    if (!block) {
        PYACrashLog(PYACrashTypeContainer, @"-[NSDictionary enumerateKeysAndObjectsUsingBlock:]: block cannot be nil");
        return;
    }
    
    [self pya_enumerateKeysAndObjectsUsingBlock:block];
}

- (void)pya_enumerateKeysAndObjectsWithOptions:(NSEnumerationOptions)opts usingBlock:(void (^)(id _Nonnull, id _Nonnull, BOOL * _Nonnull))block {
    
    if (!block) {
        PYACrashLog(PYACrashTypeContainer, @"-[NSDictionary enumerateKeysAndObjectsWithOptions:usingBlock:]: block cannot be nil");
        return; 
    }
    
    [self pya_enumerateKeysAndObjectsWithOptions:opts usingBlock:block];
}

- (NSArray *)pya_objectsForKeys:(NSArray *)keys notFoundMarker:(id)marker {
    
    if (!marker) {
        PYACrashLog(PYACrashTypeContainer, @"-[NSDictionary objectsForKeys:notFoundMarker:]: marker cannot be nil");
        return nil;
    }
    
    return [self pya_objectsForKeys:keys notFoundMarker:marker];
}

@end
