//
//  NSMutableDictionaryTests.m
//  PYCrashGuardTests
//
//  Created by linhuijie on 2018/12/3.
//  Copyright © 2018年 pluto-y. All rights reserved.
//

#import "Kiwi.h"

SPEC_BEGIN(NSMutableDictionaryTests)

context(@"NSMutableDictionary", ^{
    NSMutableDictionary *mutableDictionary = [NSMutableDictionary new];
    NSObject *nilObj                       = nil;
    _Nonnull id nilKey                     = nil;
    
    describe(@"when perform 'setObject:forKey:' with object or key is nil", ^{
        it(@"should not crash", ^{
            [[theBlock(^{
                [mutableDictionary setObject:nilObj forKey:nilKey];
                [mutableDictionary setObject:nilObj forKey:@""];
                [mutableDictionary setObject:@"" forKey:nilKey];
            }) shouldNot] raiseWithName:NSInvalidArgumentException];
        });
    });
    
    describe(@"when perform 'setValue:forKey:' with value or key is nil", ^{
        it(@"should not crash", ^{
            [[theBlock(^{
                [mutableDictionary setValue:nilObj forKey:nilKey];
                [mutableDictionary setValue:nilObj forKey:@""];
                [mutableDictionary setValue:@"" forKey:nilKey];
            }) shouldNot] raiseWithName:NSInvalidArgumentException];
        });
    });
    
    describe(@"when perform 'setValue:forKeyPath:' with value or keyPath is nil", ^{
        it(@"should not crash", ^{
            [[theBlock(^{
                [mutableDictionary setValue:nilObj forKeyPath:nilKey];
                [mutableDictionary setValue:@"" forKeyPath:nilKey];
                [mutableDictionary setValue:nilObj forKeyPath:@""];
            }) shouldNot] raiseWithName:NSInvalidArgumentException];
        });
    });
    
    describe(@"when perform 'removeObjectForKey' with key is nil", ^{
        it(@"should not crash", ^{
            [[theBlock(^{
                [mutableDictionary removeObjectForKey:nilObj];
                [mutableDictionary removeObjectForKey:@"TestKey"];
            }) shouldNot] raiseWithName:NSInvalidArgumentException];
        });
    });
    
    describe(@"when perform 'removeObjectsForKeys' with key is nil or is not NSArray type", ^{
        it(@"should not crash", ^{
            [[theBlock(^{
                [mutableDictionary removeObjectsForKeys:(NSArray *)nilObj];
                [mutableDictionary removeObjectsForKeys:(NSArray *)@(1)];
                [mutableDictionary removeObjectsForKeys:@[@"1",@"2"]];
            }) shouldNot] raiseWithName:NSInvalidArgumentException];
        });
    });
    
});

SPEC_END;
