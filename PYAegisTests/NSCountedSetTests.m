//
//  NSCountedSetTests.m
//  PYCrashGuardTests
//
//  Created by Pluto-Y on 2018/12/7.
//  Copyright © 2018 pluto-y. All rights reserved.
//

#import "Kiwi.h"

SPEC_BEGIN(NSCountedSetTests)

context(@"NSCountedSet", ^{
    NSObject *nilObj = nil;
    __block NSCountedSet *zeroElementSet = [NSCountedSet new];
    __block NSCountedSet *oneElementSet = [NSCountedSet setWithArray:@[@1]];
    __block NSCountedSet *twoElementsSet = [NSCountedSet setWithObjects:@1, @2, nil];
    
    beforeEach(^{
        zeroElementSet = [NSCountedSet new];
        oneElementSet = [NSCountedSet setWithArray:@[@1]];
        twoElementsSet = [NSCountedSet setWithObjects:@1, @2, nil];
    });
    
    describe(@"when add object", ^{
        describe(@"and the object is nil", ^{
            it(@"should not crash", ^{
                [[theBlock(^{
                    [zeroElementSet addObject:nilObj];
                    [[theValue(zeroElementSet.count) should] beZero];
                    [oneElementSet addObject:nilObj];
                    [[theValue(oneElementSet.count) should] equal:theValue(1)];
                    [twoElementsSet addObject:nilObj];
                    [[theValue(twoElementsSet.count) should] equal:theValue(2)];
                }) shouldNot] raiseWithName:NSInvalidArgumentException];
            });
        });
        
        describe(@"and the object is not nil", ^{
            it(@"should be the same as the old", ^{
                [[theBlock(^{
                    [zeroElementSet addObject:@1];
                    [[theValue(zeroElementSet.count) shouldNot] beZero];
                    [oneElementSet addObject:@2];
                    [[theValue(oneElementSet.count) shouldNot] equal:theValue(1)];
                    [twoElementsSet addObject:@3];
                    [[theValue(twoElementsSet.count) shouldNot] equal:theValue(2)];
                }) shouldNot] raiseWithName:NSInvalidArgumentException];
            });
        });
    });
    
    describe(@"when remove a object", ^{
        describe(@"and the object is nil", ^{
            it(@"should not crash", ^{
                [[theBlock(^{
                    [zeroElementSet removeObject:nilObj];
                    [[theValue(zeroElementSet.count) should] beZero];
                    [oneElementSet removeObject:nilObj];
                    [[theValue(oneElementSet.count) should] equal:theValue(1)];
                    [twoElementsSet removeObject:nilObj];
                    [[theValue(twoElementsSet.count) should] equal:theValue(2)];
                }) shouldNot] raiseWithName:NSInvalidArgumentException];
            });
        });
        
        describe(@"and the object is not nil", ^{
            it(@"should not crash", ^{
                [[theBlock(^{
                    [zeroElementSet removeObject:@0];
                    [[theValue(zeroElementSet.count) should] beZero];
                    [oneElementSet removeObject:@1];
                    [[theValue(oneElementSet.count) should] equal:theValue(0)];
                    [twoElementsSet removeObject:@2];
                    [[theValue(twoElementsSet.count) should] equal:theValue(1)];
                }) shouldNot] raiseWithName:NSInvalidArgumentException];
            });
        });
    });
});

SPEC_END
