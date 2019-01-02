//
//  NSMutableArray+PYAegis.m
//  PYAegis
//
//  Created by Pluto-Y on 2018/11/23.
//  Copyright © 2018 pluto-y. All rights reserved.
//

#import "NSMutableArray+PYAegis.h"
#import "NSObject+MethodSwizzling.h"

@implementation NSMutableArray (PYAegis)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class __NSArrayM = NSClassFromString(@"__NSArrayM");
        if (@available(iOS 10.0, *)) {
            // Nothing to do
        } else {
            [__NSArrayM methodSwizzleForInstanceFrom:@selector(removeObjectAtIndex:) to:@selector(pya_removeObjectAtIndex:)];
        }
        [__NSArrayM methodSwizzleForInstanceFrom:@selector(insertObject:atIndex:) to:@selector(pya_insertObject:atIndex:)];
        [__NSArrayM methodSwizzleForInstanceFrom:@selector(replaceObjectAtIndex:withObject:) to:@selector(pya_replaceObjectAtIndex:withObject:)];
        [__NSArrayM methodSwizzleForInstanceFrom:@selector(exchangeObjectAtIndex:withObjectAtIndex:) to:@selector(pya_exchangeObjectAtIndex:withObjectAtIndex:)];
        [__NSArrayM methodSwizzleForInstanceFrom:@selector(removeObjectsInRange:) to:@selector(pya_removeObjectsInRange:)];
        [__NSArrayM methodSwizzleForInstanceFrom:@selector(removeObject:inRange:) to:@selector(pya_removeObject:inRange:)];
        [__NSArrayM methodSwizzleForInstanceFrom:@selector(removeObjectIdenticalTo:inRange:) to:@selector(pya_removeObjectIdenticalTo:inRange:)];
        [__NSArrayM methodSwizzleForInstanceFrom:@selector(replaceObjectsInRange:withObjectsFromArray:) to:@selector(pya_replaceObjectsInRange:withObjectsFromArray:)];
        [__NSArrayM methodSwizzleForInstanceFrom:@selector(replaceObjectsInRange:withObjectsFromArray:range:) to:@selector(pya_replaceObjectsInRange:withObjectsFromArray:range:)];
        [__NSArrayM methodSwizzleForInstanceFrom:@selector(insertObjects:atIndexes:) to:@selector(pya_insertObjects:atIndexes:)];
        [__NSArrayM methodSwizzleForInstanceFrom:@selector(removeObjectsAtIndexes:) to:@selector(pya_removeObjectsAtIndexes:)];
    });
}

- (void)pya_insertObject:(id)anObject atIndex:(NSUInteger)index {
    if (index > self.count) {
        if (self.count == 0) {
            PYACrashLog(PYACrashTypeContainer, @"-[__NSArrayM insertObject：atIndex:]: index 1 beyond bounds for empty array");
        } else {
            PYACrashLog(PYACrashTypeContainer, @"-[__NSArrayM insertObject：atIndex:]: index %lu beyond bounds [0 .. %lu]", index, self.count - 1);
        }
        return;
    } else if (!anObject) {
        PYACrashLog(PYACrashTypeContainer, @"-[__NSArrayM insertObject：atIndex:]: object cannot be nil");
        return;
    }
    [self pya_insertObject:anObject atIndex:index];
}

- (void)pya_replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject {
    if (!anObject) {
        PYACrashLog(PYACrashTypeContainer, @"-[__NSArrayM replaceObjectAtIndex:withObject:]: object cannot be nil");
        return;
    } else if (index >= self.count) {
        if (self.count == 0) {
            PYACrashLog(PYACrashTypeContainer, @"-[__NSArrayM replaceObjectAtIndex:withObject:]: index %lu beyond bounds for empty array", index);
        } else {
            PYACrashLog(PYACrashTypeContainer, @"-[__NSArrayM replaceObjectAtIndex:withObject:]: index %lu beyond bounds [0 .. %lu]", index, self.count - 1);
        }
        return;
    }
    [self pya_replaceObjectAtIndex:index withObject:anObject];
}

- (void)pya_exchangeObjectAtIndex:(NSUInteger)idx1 withObjectAtIndex:(NSUInteger)idx2 {
    NSUInteger biggerIndex = MAX(idx1, idx2);
    if (biggerIndex >= self.count) {
        if (self.count == 0) {
            PYACrashLog(PYACrashTypeContainer, @"-[__NSArrayM exchangeObjectAtIndex：withObjectAtIndex:]: index %lu beyond bounds for empty array", biggerIndex);
        } else {
            PYACrashLog(PYACrashTypeContainer, @"-[__NSArrayM exchangeObjectAtIndex:withObjectAtIndex:]: index %lu beyond bounds [0 .. %lu]", biggerIndex, self.count - 1);
        }
        return;
    }
    [self pya_exchangeObjectAtIndex:idx1 withObjectAtIndex:idx2];
}

- (void)pya_removeObject:(id)anObject inRange:(NSRange)range {
    if (range.location + range.length > self.count) {
        if (self.count == 0) {
            PYACrashLog(PYACrashTypeContainer, @"-[NSMutableArray removeObject:inRange:]: range %@ extends beyond bounds for empty array", NSStringFromRange(range));
        } else {
            PYACrashLog(PYACrashTypeContainer, @"-[NSMutableArray removeObject:inRange:]: range %@ extends beyond bounds [0 .. %lu]", NSStringFromRange(range), self.count -1);
        }
        return;
    }
    [self pya_removeObject:anObject inRange:range];
}

- (void)pya_removeObjectIdenticalTo:(id)anObject inRange:(NSRange)range {
    if (range.location + range.length > self.count) {
        if (self.count == 0) {
            PYACrashLog(PYACrashTypeContainer, @"-[NSMutableArray removeObjectIdenticalTo:inRange:]: range %@ extends beyond bounds for empty array", NSStringFromRange(range));
        } else {
            PYACrashLog(PYACrashTypeContainer, @"-[NSMutableArray removeObjectIdenticalTo:inRange:]: range %@ extends beyond bounds [0 .. %lu]", NSStringFromRange(range), self.count - 1);
        }
        return;
    }
    [self pya_removeObjectIdenticalTo:anObject inRange:range];
}

- (void)pya_removeObjectsInRange:(NSRange)range {
    if (range.location + range.length > self.count) {
        if (self.count == 0) {
            PYACrashLog(PYACrashTypeContainer, @"-[NSMutableArray removeObjectsInRange:]: range %@ extends beyond bounds for empty array", NSStringFromRange(range));
        } else {
            PYACrashLog(PYACrashTypeContainer, @"-[NSMutableArray removeObjectsInRange:]: range %@ extends beyond bounds [0 .. %lu]", NSStringFromRange(range), self.count - 1);
        }
        return;
    }
    [self pya_removeObjectsInRange:range];
}

- (void)pya_replaceObjectsInRange:(NSRange)range withObjectsFromArray:(NSArray *)otherArray {
    if (range.location + range.length > self.count) {
        if (self.count == 0) {
            PYACrashLog(PYACrashTypeContainer, @"-[NSMutableArray replaceObjectsInRange:withObjectsFromArray:]: range %@ extends beyond bounds for empty array", NSStringFromRange(range));
        } else {
            PYACrashLog(PYACrashTypeContainer, @"-[NSMutableArray replaceObjectsInRange:withObjectsFromArray:]: range %@ extends beyond bounds [0 .. %lu]", NSStringFromRange(range), self.count - 1);
        }
        return;
    }
    [self pya_replaceObjectsInRange:range withObjectsFromArray:otherArray];
}

- (void)pya_replaceObjectsInRange:(NSRange)range withObjectsFromArray:(NSArray *)otherArray range:(NSRange)otherRange {
    if (range.location + range.length > self.count) {
        if (self.count == 0) {
            PYACrashLog(PYACrashTypeContainer, @"-[NSMutableArray replaceObjectsInRange:withObjectsFromArray:range:]: range %@ extends beyond bounds for empty array", NSStringFromRange(range));
        } else {
            PYACrashLog(PYACrashTypeContainer, @"-[NSMutableArray replaceObjectsInRange:withObjectsFromArray:range:]: range %@ extends beyond bounds [0 .. %lu]", NSStringFromRange(range), self.count - 1);
        }
        return;
    } else if (otherRange.location + otherRange.length > otherArray.count) {
        if (otherArray.count == 0) {
            PYACrashLog(PYACrashTypeContainer, @"-[NSMutableArray replaceObjectsInRange:withObjectsFromArray:range:]: range %@ extends beyond bounds for empty array", NSStringFromRange(otherRange));
        } else {
            PYACrashLog(PYACrashTypeContainer, @"-[NSMutableArray replaceObjectsInRange:withObjectsFromArray:range:]: range %@ extends beyond bounds [0 .. %lu]", NSStringFromRange(otherRange), self.count - 1);
        }
        return;
    }
    [self pya_replaceObjectsInRange:range withObjectsFromArray:otherArray range:otherRange];
}

- (void)pya_insertObjects:(NSArray *)objects atIndexes:(NSIndexSet *)indexes {
    if (indexes == nil) {
        PYACrashLog(PYACrashTypeContainer, @"-[NSMutableArray insertObjects:atIndexes:]: index set cannot be nil");
        return;
    } else if (indexes.lastIndex >= self.count + objects.count) {
        if (self.count == 0) {
            PYACrashLog(PYACrashTypeContainer, @"-[NSMutableArray insertObjects:atIndexes:]: index %lu in index set beyond bounds for empty array", indexes.lastIndex);
        } else {
            PYACrashLog(PYACrashTypeContainer, @"-[NSMutableArray insertObjects:atIndexes:]: index %lu in index set beyond bounds [0 .. %lu]", indexes.lastIndex, self.count - 1);
        }
        return;
    } else if (indexes.count > objects.count) {
#warning "Consider how to fill the right data of the log"
//        PYACrashLog(PYACrashTypeContainer, @"-[NSMutableArray insertObjects:atIndexes:]: count of array (%lu) differs from count of index set (%lu)");
        return;
    }
    [self pya_insertObjects:objects atIndexes:indexes];

}

- (void)pya_removeObjectsAtIndexes:(NSIndexSet *)indexes {
    if (!indexes) {
        PYACrashLog(PYACrashTypeContainer, @"-[NSMutableArray removeObjectsAtIndexes:]: index set cannot be nil");
        return;
    } else if (indexes.lastIndex >= self.count) {
        if (self.count == 0) {
            PYACrashLog(PYACrashTypeContainer, @"-[NSMutableArray removeObjectsAtIndexes:]: index %lu in index set beyond bounds for empty array", indexes.lastIndex);
        } else {
            PYACrashLog(PYACrashTypeContainer, @"-[NSMutableArray removeObjectsAtIndexes:]: index %lu in index set beyond bounds [0 .. %lu]", indexes.lastIndex, self.count - 1);
        }
        return;
    }
    [self pya_removeObjectsAtIndexes:indexes];
}

- (void)pya_removeObjectAtIndex:(NSUInteger)index {
    if (index >= self.count) {
        if (self.count == 0) {
            PYACrashLog(PYACrashTypeContainer, @"-[__NSArrayM removeObjectAtIndex:]: index %lu beyond bounds for empty array", index);
        } else {
            PYACrashLog(PYACrashTypeContainer, @"-[__NSArrayM removeObjectAtIndex:]: index %lu beyond bounds [0 .. %lu]", index, self.count - 1);
        }
        return;
    }
    return [self pya_removeObjectAtIndex:index];
}

@end
