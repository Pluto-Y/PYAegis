//
//  NSMutableSetTests.m
//  PYCrashGuardTests
//
//  Created by Pluto-Y on 2018/12/6.
//  Copyright © 2018 pluto-y. All rights reserved.
//

#import "Kiwi.h"

SPEC_BEGIN(NSMutableSetTests)

context(@"NSMutableSet", ^{
    NSObject *nilObj = nil;
    NSMutableSet *zeroElementSet = [NSMutableSet new];
    NSMutableSet *oneElementSet = [NSMutableSet setWithArray:@[@1]];
    NSMutableSet *twoElementsSet = [NSMutableSet setWithObjects:@1, @2, nil];
    
    describe(@"when add object which is nil", ^{
        it(@"should not crash", ^{
            [[theBlock(^{
                [zeroElementSet addObject:nilObj];
                [oneElementSet addObject:nilObj];
                [twoElementsSet addObject:nilObj];
            }) shouldNot] raiseWithName:NSInvalidArgumentException];
        });
    });
    
    describe(@"when remove object whici is nil", ^{
        it(@"should not crash", ^{
            [[theBlock(^{
                [zeroElementSet removeObject:nilObj];
                [oneElementSet removeObject:nilObj];
                [twoElementsSet removeObject:nilObj];
            }) shouldNot] raiseWithName:NSInvalidArgumentException];
        });
    });
});

SPEC_END;
