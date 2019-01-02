//
//  NSArray+PYAegis.m
//  PYAegis
//
//  Created by Pluto-Y on 2018/11/19.
//  Copyright © 2018 pluto-y. All rights reserved.
//

#import "NSArray+PYAegis.h"
#import "NSObject+MethodSwizzling.h"

@implementation NSArray (PYAegis)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (@available(iOS 9.0, *)) {
            Class __NSArray0 = NSClassFromString(@"__NSArray0");
            [__NSArray0 methodSwizzleForInstanceFrom:@selector(objectAtIndex:) to:@selector(pya__NSArray0_objectAtIndex:)];
            Class __NSSingleObjectArrayI = NSClassFromString(@"__NSSingleObjectArrayI");
            [__NSSingleObjectArrayI methodSwizzleForInstanceFrom:@selector(objectAtIndex:) to:@selector(pya__NSSingleObjectArrayI_objectAtIndex:)];
            [__NSSingleObjectArrayI methodSwizzleForInstanceFrom:@selector(enumerateObjectsWithOptions:usingBlock:) to:@selector(pya__NSSingleObjectArrayI_enumerateObjectsWithOptions:usingBlock:)];
        }
        Class __NSArrayI = NSClassFromString(@"__NSArrayI");
        [__NSArrayI methodSwizzleForInstanceFrom:@selector(objectAtIndex:) to:@selector(pya__NSArrayI_objectAtIndex:)];
        [__NSArrayI methodSwizzleForInstanceFrom:@selector(enumerateObjectsWithOptions:usingBlock:) to:@selector(pya__NSArrayI_enumerateObjectsWithOptions:usingBlock:)];
        Class __NSPlaceholderArray = NSClassFromString(@"__NSPlaceholderArray");
        [__NSPlaceholderArray methodSwizzleForInstanceFrom:@selector(initWithObjects:count:) to:@selector(pya_initWithObjects:count:)];
        [__NSPlaceholderArray methodSwizzleForInstanceFrom:@selector(count) to:@selector(pya_count)];
        [NSArray methodSwizzleForInstanceFrom:@selector(arrayByAddingObject:) to:@selector(pya_arrayByAddingObject:)];
        [NSArray methodSwizzleForInstanceFrom:@selector(indexOfObject:inRange:) to:@selector(pya_indexOfObject:inRange:)];
        [NSArray methodSwizzleForInstanceFrom:@selector(indexOfObjectIdenticalTo:inRange:) to:@selector(pya_indexOfObjectIdenticalTo:inRange:)];
        [NSArray methodSwizzleForInstanceFrom:@selector(subarrayWithRange:) to:@selector(pya_subarrayWithRange:)];
        [NSArray methodSwizzleForInstanceFrom:@selector(objectsAtIndexes:) to:@selector(pya_objectsAtIndexes:)];
        [NSArray methodSwizzleForInstanceFrom:@selector(enumerateObjectsUsingBlock:) to:@selector(pya_enumerateObjectsUsingBlock:)];
        [NSArray methodSwizzleForInstanceFrom:@selector(enumerateObjectsWithOptions:usingBlock:) to:@selector(pya_enumerateObjectsWithOptions:usingBlock:)];
        [NSArray methodSwizzleForInstanceFrom:@selector(enumerateObjectsAtIndexes:options:usingBlock:) to:@selector(pya_enumerateObjectsAtIndexes:options:usingBlock:)];
    });
}

- (NSUInteger)pya_count {
    PYACrashLog(PYACrashTypeContainer, @"-[NSArray count]: method sent to an uninitialized immutable array object");
    return 0;
}

- (NSArray *)pya_arrayByAddingObject:(id)anObject {
    if (!anObject) {
        PYACrashLog(PYACrashTypeContainer, @"-[NSArray arrayByAddingObject:]: object cannot be nil");
        return nil;
    }
    return [self pya_arrayByAddingObject:anObject];
}

- (id)pya__NSArray0_objectAtIndex:(NSUInteger)index {
    PYACrashLog(PYACrashTypeContainer, @"-[__NSArray0  objectAtIndex:] index: %lu beyond bounds for empty NSArray", index);
    return nil;
}

- (id)pya__NSSingleObjectArrayI_objectAtIndex:(NSUInteger)index {
    if (index >= self.count) {
        PYACrashLog(PYACrashTypeContainer, @"-[__NSSingleObjectArrayI objectAtIndex:]: index %lu beyond bounds [0 .. %lu]", index, self.count - 1);
        return nil;
    }
    return [self pya__NSSingleObjectArrayI_objectAtIndex:index];
}

- (id)pya__NSArrayI_objectAtIndex:(NSUInteger)index {
    if (index >= self.count) {
        PYACrashLog(PYACrashTypeContainer, @"-[__NSArrayI objectAtIndex:]: index %lu beyond bounds [0 .. %lu]", index, self.count - 1);
        return nil;
    }
    return [self pya__NSArrayI_objectAtIndex:index];
}

- (instancetype)pya_initWithObjects:(id  _Nonnull const [])objects count:(NSUInteger)cnt {
#warning "Consider how to write the codes"
    for (int i = 0 ; i < cnt ; i ++) {
        if (objects[i] == nil) {
            return nil;
        }
    }
    return [self pya_initWithObjects:objects count:cnt];
}

- (NSUInteger)pya_indexOfObject:(id)anObject inRange:(NSRange)range {
    if (range.location + range.length > self.count) {
        if (self.count == 0) {
            PYACrashLog(PYACrashTypeContainer, @"-[NSArray indexOfObject:inRange:]: range %@ extends beyond bounds for empty array", NSStringFromRange(range));
            return NSNotFound;
        } else {
            PYACrashLog(PYACrashTypeContainer, @"-[NSArray indexOfObject:inRange:]: range %@ extends beyond bounds [0 .. %lu]", NSStringFromRange(range), self.count - 1);
            return NSNotFound;
        }
    }
    return [self pya_indexOfObject:anObject inRange:range];
}

- (NSUInteger)pya_indexOfObjectIdenticalTo:(id)anObject inRange:(NSRange)range {
    if (range.location + range.length > self.count) {
        if (self.count == 0) {
            PYACrashLog(PYACrashTypeContainer, @"-[NSArray indexOfObjectIdenticalTo:inRange:]: range %@ extends beyond bounds for empty array", NSStringFromRange(range));
            return NSNotFound;
        } else {
            PYACrashLog(PYACrashTypeContainer, @"-[NSArray indexOfObjectIdenticalTo:inRange:]: range %@ extends beyond bounds [0 .. %lu]", NSStringFromRange(range), self.count - 1);
            return NSNotFound;
        }
    }
    return [self pya_indexOfObjectIdenticalTo:anObject inRange:range];
}

- (NSArray *)pya_subarrayWithRange:(NSRange)range {
    if (range.location + range.length > self.count) {
        if (self.count == 0) {
            PYACrashLog(PYACrashTypeContainer, @"-[NSArray subarrayWithRange:]: range %@ extends beyond bounds for empty array", NSStringFromRange(range));
            return nil;
        } else {
            PYACrashLog(PYACrashTypeContainer, @"-[NSArray subarrayWithRange:]: range %@ extends beyond bounds [0 .. %lu]", NSStringFromRange(range), self.count - 1);
            return nil;
        }
    }
    return [self pya_subarrayWithRange:range];
}

- (NSArray *)pya_objectsAtIndexes:(NSIndexSet *)indexes {
    if (indexes.lastIndex >= self.count) {
        if (self.count == 0) {
            PYACrashLog(PYACrashTypeContainer, @"-[NSArray objectsAtIndexes:]: index %lu in index set beyond bounds for empty array", indexes.lastIndex);
            return nil;
        } else {
            PYACrashLog(PYACrashTypeContainer, @"-[NSArray objectsAtIndexes:]: index %lu in index set beyond bounds [0 .. %lu]", indexes.lastIndex, self.count - 1);
            return nil;
        }
    }
    NSMutableArray *result = [NSMutableArray new];
    [indexes enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx >= self.count) {
            *stop = YES;
        }
        [result addObject:[self objectAtIndex:idx]];
    }];
    return [result copy];
}

- (void)pya_enumerateObjectsUsingBlock:(void (^)(id _Nonnull, NSUInteger, BOOL * _Nonnull))block {
    if (!block) {
        PYACrashLog(PYACrashTypeContainer, @"-[NSArray enumerateObjectsUsingBlock:]: block cannot be nil");
        return;
    }
    [self pya_enumerateObjectsUsingBlock:block];
}

- (void)pya__NSSingleObjectArrayI_enumerateObjectsWithOptions:(NSEnumerationOptions)opts usingBlock:(void (^)(id _Nonnull, NSUInteger, BOOL * _Nonnull))block {
    if (!block) {
        PYACrashLog(PYACrashTypeContainer, @"-[__NSSingleObjectArrayI enumerateObjectsWithOptions:usingBlock:]: block cannot be nil");
        return;
    }
    [self pya__NSSingleObjectArrayI_enumerateObjectsWithOptions:opts usingBlock:block];
}

- (void)pya__NSArrayI_enumerateObjectsWithOptions:(NSEnumerationOptions)opts usingBlock:(void (^)(id _Nonnull, NSUInteger, BOOL * _Nonnull))block {
    if (!block) {
        PYACrashLog(PYACrashTypeContainer, @"-[__NSArrayI enumerateObjectsWithOptions:usingBlock:]: block cannot be nil");
        return;
    }
    [self pya__NSArrayI_enumerateObjectsWithOptions:opts usingBlock:block];
}

- (void)pya_enumerateObjectsWithOptions:(NSEnumerationOptions)opts usingBlock:(void (^)(id _Nonnull, NSUInteger, BOOL * _Nonnull))block {
    if (!block) {
        PYACrashLog(PYACrashTypeContainer, @"-[__NSSingleObjectArrayI enumerateObjectsWithOptions:usingBlock:]: block cannot be nil");
        return;
    }
    [self pya_enumerateObjectsWithOptions:opts usingBlock:block];
}

- (void)pya_enumerateObjectsAtIndexes:(NSIndexSet *)s options:(NSEnumerationOptions)opts usingBlock:(void (^)(id _Nonnull, NSUInteger, BOOL * _Nonnull))block {
    if (!block) {
        PYACrashLog(PYACrashTypeContainer, @"-[NSArray enumerateObjectsAtIndexes:options:usingBlock:]: block cannot be nil");
        return;
    }
    if (s.lastIndex >= self.count) {
        if (self.count == 0) {
            PYACrashLog(PYACrashTypeContainer, @"-[NSArray enumerateObjectsAtIndexes:options:usingBlock:]: index %lu beyond bounds for empty array", s.lastIndex);
            return;
        } else {
            PYACrashLog(PYACrashTypeContainer, @"-[NSArray enumerateObjectsAtIndexes:options:usingBlock:]: index %lu beyond bounds [0 .. %lu]", s.lastIndex, self.count - 1);
            return;
        }
    }
    [self pya_enumerateObjectsAtIndexes:s options:opts usingBlock:block];
}

@end
