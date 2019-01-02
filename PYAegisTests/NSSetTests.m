//
//  NSSetTests.m
//  PYCrashGuardTests
//
//  Created by Pluto-Y on 2018/12/6.
//  Copyright © 2018 pluto-y. All rights reserved.
//

#import "Kiwi.h"

SPEC_BEGIN(NSSetTests)

context(@"NSSet", ^{
    NSObject *nilObj = nil;
    NSSet *zeroElementSet = [NSSet set];
    NSSet *oneElementSet = [NSSet setWithObject:@1];
    NSSet *twoElementsSet = [NSSet setWithArray:@[@1, @2]];
    
    describe(@"when get count of set which is uninitialized object", ^{
        it(@"should not crash and return zero", ^{
            [[theBlock(^{
                [[theValue([[NSSet alloc] count]) should] beZero];
            }) shouldNot] raiseWithName:NSInvalidArgumentException];
        });
    });
    
    describe(@"when get set by 'setByAddingObject'", ^{
        describe(@"and the parameters are invalidate", ^{
            it(@"should not crash and return itself", ^{
                [[theBlock(^{
                    [[[zeroElementSet setByAddingObject:nilObj] should] beNil];
                    [[[oneElementSet setByAddingObject:nilObj] should] beNil];
                    [[[twoElementsSet setByAddingObject:nilObj] should] beNil];
                }) shouldNot] raiseWithName:NSInvalidArgumentException];
            });
        });
        
        describe(@"and the parameters are valid", ^{
            it(@"should have same behavior as old", ^{
                [[[zeroElementSet setByAddingObject:@1] should] equal:oneElementSet];
                [[[oneElementSet setByAddingObject:@2] should] equal:twoElementsSet];
                [[[twoElementsSet setByAddingObject:@3] should] equal:[NSSet setWithArray:@[@1, @2, @3]]];
            });
        });
    });
    
    void (^nilBlock)(id _Nonnull, BOOL * _Nonnull) = nil;
    describe(@"when perform enumerateObjectsUsingBlock", ^{
        describe(@"and the block is nil", ^{
            it(@"should not crash", ^{
                [[theBlock(^{
                    [zeroElementSet enumerateObjectsUsingBlock:nilBlock];
                    [oneElementSet enumerateObjectsUsingBlock:nilBlock];
                    [twoElementsSet enumerateObjectsUsingBlock:nilBlock];
                }) shouldNot] raiseWithName:NSInvalidArgumentException];
            });
        });
        
        describe(@"and the block is not nil", ^{
            it(@"should have same behavior as old", ^{
                [[theBlock(^{
                    [zeroElementSet enumerateObjectsUsingBlock:^(id  _Nonnull obj, BOOL * _Nonnull stop) {
                        
                    }];
                    [oneElementSet enumerateObjectsUsingBlock:^(id  _Nonnull obj, BOOL * _Nonnull stop) {
                        
                    }];
                    [twoElementsSet enumerateObjectsUsingBlock:^(id  _Nonnull obj, BOOL * _Nonnull stop) {
                        
                    }];
                }) shouldNot] raiseWithName:NSInvalidArgumentException];
            });
        });
    });
    
    describe(@"when perform enumerateObjectsUsingBlock with option", ^{
        describe(@"and the block is nil", ^{
            it(@"should not crash", ^{
                [[theBlock(^{
                    [zeroElementSet enumerateObjectsWithOptions:0 usingBlock:nilBlock];
                    [oneElementSet enumerateObjectsWithOptions:NSEnumerationConcurrent usingBlock:nilBlock];
                    [twoElementsSet enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:nilBlock];
                }) shouldNot] raiseWithName:NSInvalidArgumentException];
            });
        });
        
        describe(@"and the block is not nil", ^{
            it(@"should have same behavior as old", ^{
                [zeroElementSet enumerateObjectsWithOptions:0 usingBlock:^(id  _Nonnull obj, BOOL * _Nonnull stop) {
                    
                }];
                [oneElementSet enumerateObjectsWithOptions:NSEnumerationConcurrent usingBlock:^(id  _Nonnull obj, BOOL * _Nonnull stop) {
                    
                }];
                [twoElementsSet enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id  _Nonnull obj, BOOL * _Nonnull stop) {
                    
                }];
            });
        });
    });

    describe(@"when create it by 'setWithObject'", ^{
        describe(@"and object is nil", ^{
            it(@"should not crash and return itself", ^{
                [[theBlock(^{
                    [[[NSSet setWithObject:nilObj] should] beNil];
                }) shouldNot] raiseWithName:NSInvalidArgumentException];
            });
        });
        
        describe(@"and object is not nil", ^{
            it(@"should have same behavior as old", ^{
                [[[NSSet setWithObject:@1] should] equal:[NSSet setWithArray:@[@1]]];
            });
        });
    });
});

SPEC_END;

// TODO: consider how to write this test cases
//- (void)test_makeObjectsPerformSelector {
//    SEL nilSEL = nil;
//    XCTAssertNoThrowSpecificNamed([[NSSet set] makeObjectsPerformSelector:nilSEL], NSException, NSInvalidArgumentException);
//    XCTAssertNoThrowSpecificNamed([[NSSet setWithObject:@1] makeObjectsPerformSelector:nilSEL], NSException, NSInvalidArgumentException);
//}
