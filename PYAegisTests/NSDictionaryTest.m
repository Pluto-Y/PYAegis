//
//  NSDictionaryTest.m
//  PYCrashGuardTests
//
//  Created by linhuijie on 2018/12/10.
//  Copyright © 2018年 pluto-y. All rights reserved.
//

#import "Kiwi.h"

SPEC_BEGIN(NSDictionaryTest)

context(@"NSDictionary", ^{
    NSDictionary *__NSDictionary0            = [[NSDictionary alloc] init];
    NSDictionary *__NSSingleEntryDictionaryI = @{@"1":@"1"};
    NSDictionary *__NSDictionaryI            = @{@"11":@"11",@"22":@"22"};
    NSString * not_nilKey                    = @"no_nilKey";
    NSString * nilKey                        = nil;
    NSString * not_nilValue                  = @"no_nilValue";
    NSString * nilValue                      = nil;
    NSObject *nilObj                         = nil;
    void (^nilBlock)(id _Nonnull, id _Nonnull, BOOL * _Nonnull) = nil;
    
    describe(@"when create dictionary by 'initWithObjects:forKeys:count:'", ^{
        it(@"should not crash and return nil", ^{
            [[theBlock(^{
                [[[NSDictionary dictionaryWithObject:nilValue forKey:not_nilKey] should] beNil];
                [[[NSDictionary dictionaryWithObject:not_nilValue forKey:nilKey] should] beNil];
                [[[NSDictionary dictionaryWithObject:nilValue forKey:not_nilKey] should] beNil];
            }) shouldNot] raiseWithName:NSInvalidArgumentException];
        });
    });
    
    describe(@"when create dictionary by 'initWithDictionary:copyItems:'", ^{
        it(@"should not crash and return nil", ^{
            [[theBlock(^{
                [[[NSDictionary dictionaryWithDictionary:(NSDictionary *)@[]] should] beNil];
            }) shouldNot] raiseWithName:NSInvalidArgumentException];
            
            // Normal Case
            [[theBlock(^{
                [[[NSDictionary dictionaryWithDictionary:(NSDictionary *)@{}] shouldNot] beNil];
            }) shouldNot] raiseWithName:NSInvalidArgumentException];
        });
    });
    
    describe(@"when perform 'enumerateKeysAndObjectsUsingBlock' and block is nil", ^{
        it(@"should not crash", ^{
            [[theBlock(^{
                [__NSDictionary0 enumerateKeysAndObjectsUsingBlock:nilBlock];
                [__NSSingleEntryDictionaryI enumerateKeysAndObjectsUsingBlock:nilBlock];
                [__NSDictionaryI enumerateKeysAndObjectsUsingBlock:nilBlock];
            }) shouldNot] raiseWithName:NSInvalidArgumentException];
            
            // Normal Case
            [[theBlock(^{
                [__NSSingleEntryDictionaryI enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                }];
                [__NSDictionaryI enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                }];
            }) shouldNot] raiseWithName:NSInvalidArgumentException];
        });
    });
    
    describe(@"when perform 'enumerateKeysAndObjectsWithOptions:usingBlock:' and block is nil", ^{
        it(@"should not crash", ^{
            [[theBlock(^{
                [__NSDictionary0 enumerateKeysAndObjectsWithOptions:NSEnumerationConcurrent usingBlock:nilBlock];
                [__NSSingleEntryDictionaryI enumerateKeysAndObjectsWithOptions:NSEnumerationConcurrent usingBlock:nilBlock];
                [__NSDictionaryI enumerateKeysAndObjectsWithOptions:NSEnumerationConcurrent usingBlock:nilBlock];
            }) shouldNot] raiseWithName:NSInvalidArgumentException];
            
            // Normal Case
            [[theBlock(^{
                [__NSDictionary0 enumerateKeysAndObjectsWithOptions:NSEnumerationConcurrent usingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                }];
                [__NSSingleEntryDictionaryI enumerateKeysAndObjectsWithOptions:NSEnumerationConcurrent usingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                }];
                [__NSDictionaryI enumerateKeysAndObjectsWithOptions:NSEnumerationConcurrent usingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                }];
            }) shouldNot] raiseWithName:NSInvalidArgumentException];
        });
    });
    
    describe(@"when perform 'objectsForKeys:notFoundMarker:' and keys is not array ro market is nil", ^{
        it(@"should not crash and return nil", ^{
            [[theBlock(^{
                [[[__NSDictionary0 objectsForKeys:(NSArray *)@"1" notFoundMarker:nilObj] should] beNil];
                [[[__NSSingleEntryDictionaryI objectsForKeys:(NSArray *)@"1" notFoundMarker:nilObj] should] beNil];
            }) shouldNot] raiseWithName:NSInvalidArgumentException];
            
            // Normal Case
            [[theBlock(^{
                [[[__NSDictionary0 objectsForKeys:@[@"1"] notFoundMarker:@"TestValue"] shouldNot] beNil];
                [[[__NSSingleEntryDictionaryI objectsForKeys:@[@"1"] notFoundMarker:@"TestValue"] shouldNot] beNil];
                [[[__NSDictionaryI objectsForKeys:@[@"1"] notFoundMarker:@"TestValue"] shouldNot] beNil];
            }) shouldNot] raiseWithName:NSInvalidArgumentException];
        });
    });
    
});

SPEC_END;
