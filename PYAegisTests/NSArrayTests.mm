//
//  NSArrayTests.m
//  PYCrashGuardTests
//
//  Created by Pluto-Y on 2018/12/3.
//  Copyright © 2018 pluto-y. All rights reserved.
//

#import "Kiwi.h"

SPEC_BEGIN(NSArrayTests)

context(@"NSArray", ^{
    NSObject *nilObj = nil;
    NSArray *nsarray0 = @[];
    NSArray *nssingleObjectArray = @[@1];
    NSArray *nsarrayI = @[@1, @2];
    
    describe(@"when get count of the instance __NSPlaceholderArray", ^{
        it(@"should not crash and return zero", ^{
            [[theBlock(^{
                [[theValue([NSArray alloc].count) should] beZero];
            }) shouldNot] raiseWithName:NSInvalidArgumentException];
        });
    });
    
    describe(@"when get element at index", ^{
        it(@"should not crash and return nil", ^{
            [[theBlock(^{
                [[[nsarray0 objectAtIndex:0] should] beNil];
                [[[nssingleObjectArray objectAtIndex:1] should] beNil];
                [[[nsarrayI objectAtIndex:2] should] beNil];
            }) shouldNot] raiseWithName:NSRangeException];
        });
    });
    
    describe(@"when get array by adding object", ^{
        describe(@"and the object is nil", ^{
            it(@"should not crash and return itself", ^{
                [[theBlock(^{
                    [[[nsarray0 arrayByAddingObject:nilObj] should] beNil];
                    [[[nssingleObjectArray arrayByAddingObject:nilObj] should] beNil];
                    [[[nsarrayI arrayByAddingObject:nilObj] should] beNil];
                }) shouldNot] raiseWithName:NSInvalidArgumentException];
            });
        });
        
        describe(@"and the object is not nil", ^{
            it(@"should the same behavior with old", ^{
                [[theBlock(^{
                    [[[nsarray0 arrayByAddingObject:@1] should] equal:nssingleObjectArray];
                    [[[nssingleObjectArray arrayByAddingObject:@2] should] equal:nsarrayI];
                    [[[nsarrayI arrayByAddingObject:@3] should] equal:@[@1, @2, @3]];
                }) shouldNot] raise];
            });
        });
    });
    
    describe(@"when get objects in range", ^{
        it(@"should not crash and return itself", ^{
            // TODO: add tests
        });
    });
    
    describe(@"when create array by 'initWithObjects:count:'", ^{
        it(@"should not crash and return nil", ^{
            [[theBlock(^{
                [[[NSArray arrayWithObject:nilObj] should] beNil];
                [[@[nilObj] should] beNil];
            }) shouldNot] raiseWithName:NSInvalidArgumentException];
        });
    });
    
    describe(@"when get indexOfObject inRange", ^{
        describe(@"and the range is out of the range of array", ^{
            it(@"should not crash and return NSNotFound", ^{
                [[theBlock(^{
                    [[theValue([nsarray0 indexOfObject:[NSObject new] inRange:NSMakeRange(0, 1)]) should] equal:theValue(NSNotFound)];
                    [[theValue([nssingleObjectArray indexOfObject:[NSObject new] inRange:NSMakeRange(0, 2)]) should] equal:theValue((NSNotFound))];
                    [[theValue([nsarrayI indexOfObject:[NSObject new] inRange:NSMakeRange(0, 3)]) should] equal:theValue(NSNotFound)];
                }) shouldNot] raiseWithName:NSRangeException];
            });
        });
        
        describe(@"and the range is valid", ^{
            it(@"should have same behavior as old", ^{
                [[theValue([nsarray0 indexOfObject:@0 inRange:NSMakeRange(0, 0)]) should] equal:theValue(NSNotFound)];
                [[theValue([nssingleObjectArray indexOfObject:@1 inRange:NSMakeRange(0, 1)]) should] equal:theValue(0)];
                [[theValue([nsarrayI indexOfObject:@2 inRange:NSMakeRange(0, nsarrayI.count)]) should] equal:theValue(1)];
                [[theValue([nsarrayI indexOfObject:@2 inRange:NSMakeRange(0, 1)]) should] equal:theValue(NSNotFound)];
            });
        });
    });
    
    describe(@"when get indexOfObjectIdenticalTo inRange", ^{
        describe(@"and the range is out of the range of array", ^{
            it(@"should not crash and return NSNotFound", ^{
                [[theBlock(^{
                    [[theValue([nsarray0 indexOfObjectIdenticalTo:[NSObject new] inRange:NSMakeRange(0, 1)]) should] equal:theValue(NSNotFound)];
                    [[theValue([nssingleObjectArray indexOfObjectIdenticalTo:[NSObject new] inRange:NSMakeRange(0, 2)]) should] equal:theValue((NSNotFound))];
                    [[theValue([nsarrayI indexOfObjectIdenticalTo:[NSObject new] inRange:NSMakeRange(0, 3)]) should] equal:theValue(NSNotFound)];
                }) shouldNot] raiseWithName:NSRangeException];
            });
        });
        
        describe(@"and the range is valid", ^{
            it(@"should have same behavior as old", ^{
                [[theValue([nsarray0 indexOfObjectIdenticalTo:@0 inRange:NSMakeRange(0, 0)]) should] equal:theValue(NSNotFound)];
                [[theValue([nssingleObjectArray indexOfObjectIdenticalTo:@1 inRange:NSMakeRange(0, 1)]) should] equal:theValue(0)];
                [[theValue([nsarrayI indexOfObjectIdenticalTo:@2 inRange:NSMakeRange(0, nsarrayI.count)]) should] equal:theValue(1)];
                [[theValue([nsarrayI indexOfObjectIdenticalTo:@2 inRange:NSMakeRange(0, 1)]) should] equal:theValue(NSNotFound)];
            });
        });
    });
    
    describe(@"when get subarray in range", ^{
        it(@"should not crash and return adapted subarray", ^{
            [[theBlock(^{
                [[[nsarray0 subarrayWithRange:NSMakeRange(0, 1)] should] beNil];
                [[[nssingleObjectArray subarrayWithRange:NSMakeRange(0, 2)] should] beNil];
                [[[nsarrayI subarrayWithRange:NSMakeRange(0, 3)] should] beNil];
            }) shouldNot] raiseWithName:NSRangeException];
            
            [[theBlock(^{
                NSArray *array = @[@1, @2, @3];
                NSArray *subArray1 = @[@1, @2];
                NSArray *subArray2 = @[@2, @3];
                [[[array subarrayWithRange:NSMakeRange(0, 3)] should] equal:array];
                [[[array subarrayWithRange:NSMakeRange(0, 2)] should] equal:subArray1];
                [[[array subarrayWithRange:NSMakeRange(0, 4)] should] beNil];
                [[[array subarrayWithRange:NSMakeRange(1, 2)] should] equal:subArray2];
                [[[array subarrayWithRange:NSMakeRange(1, 5)] should] beNil];
            }) shouldNot] raiseWithName:NSRangeException];
        });
    });
    
    describe(@"when get objects at indexes", ^{
        it(@"should not crash and return adapted result", ^{
            [[theBlock(^{
                [[[nsarray0 objectsAtIndexes:[NSIndexSet indexSetWithIndex:1]] should] beNil];
                [[[nsarray0 objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 1)]] should] beNil];
                [[[nssingleObjectArray objectsAtIndexes:[NSIndexSet indexSetWithIndex:1]] should] beNil];
                [[[nssingleObjectArray objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 2)]] should] beNil];
                
                NSMutableIndexSet *indexSet = [NSMutableIndexSet indexSetWithIndex:0];
                [indexSet addIndex:1];
                [indexSet addIndex:3];
                [indexSet addIndex:5];
                [indexSet addIndex:7];
                [[[nsarrayI objectsAtIndexes:indexSet] should] beNil];
            }) shouldNot] raiseWithName:NSRangeException];
        });
    });
    
    void (^nilBlock)(id _Nonnull, NSUInteger, BOOL * _Nonnull) = nil;
    describe(@"when perform enumerateObjectsUsingBlock", ^{
        describe(@"and block is nil", ^{
            it(@"should not crash", ^{
                [[theBlock(^{
                    [nsarray0 enumerateObjectsUsingBlock:nilBlock];
                    [nssingleObjectArray enumerateObjectsUsingBlock:nilBlock];
                    [nsarrayI enumerateObjectsUsingBlock:nilBlock];
                }) shouldNot] raiseWithName:NSInvalidArgumentException];
            });
        });
        
        describe(@"and block is not nil", ^{
            it(@"should have same behavior as old", ^{
                [nsarray0 enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    
                }];
                [nssingleObjectArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    
                }];
                [nsarrayI enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    
                }];
            });
        });
    });
    
    describe(@"when perform enumenumerateObjectsUsingBlock with option and block is nil", ^{
        it(@"should not crash", ^{
            [[theBlock(^{
                [nsarray0 enumerateObjectsWithOptions:0 usingBlock:nilBlock];
                [nssingleObjectArray enumerateObjectsWithOptions:NSEnumerationConcurrent usingBlock:nilBlock];
                [nsarrayI enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:nilBlock];
            }) shouldNot] raiseWithName:NSInvalidArgumentException];
            
        });
    });
    
    describe(@"when perform enumerateObjectsAtIndexes with option for block and block is nil", ^{
        it(@"should not crash", ^{
            [[theBlock(^{
                [nsarray0 enumerateObjectsAtIndexes:[NSIndexSet indexSetWithIndex:0] options:NSEnumerationConcurrent usingBlock:nilBlock];
                [nssingleObjectArray enumerateObjectsAtIndexes:[NSIndexSet indexSetWithIndex:0] options:NSEnumerationConcurrent usingBlock:nilBlock];
                [nsarrayI enumerateObjectsAtIndexes:[NSIndexSet indexSetWithIndex:0] options:NSEnumerationConcurrent usingBlock:nilBlock];
                
                [nsarray0 enumerateObjectsAtIndexes:[NSIndexSet indexSetWithIndex:1] options:NSEnumerationConcurrent usingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) { }];
                [nssingleObjectArray enumerateObjectsAtIndexes:[NSIndexSet indexSetWithIndex:2] options:NSEnumerationConcurrent usingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) { }];
                [nsarrayI enumerateObjectsAtIndexes:[NSIndexSet indexSetWithIndex:2] options:NSEnumerationConcurrent usingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) { }];
            }) shouldNot] raiseWithName:NSInvalidArgumentException];
        });
        
        describe(@"and object is not nil", ^{
            it(@"should have same behavior as old", ^{
                [nsarray0 enumerateObjectsAtIndexes:[NSIndexSet indexSetWithIndex:0] options:NSEnumerationConcurrent usingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) { }];
                [nssingleObjectArray enumerateObjectsAtIndexes:[NSIndexSet indexSetWithIndex:0] options:NSEnumerationConcurrent usingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) { }];
                [nsarrayI enumerateObjectsAtIndexes:[NSIndexSet indexSetWithIndex:0] options:NSEnumerationConcurrent usingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) { }];
            });
        });
    });
});

SPEC_END
