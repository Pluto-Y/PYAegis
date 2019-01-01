//
//  MethodSwizzlingTests.m
//  PYAegisTests
//
//  Created by Pluto-Y on 23/08/2018.
//  Copyright © 2018 pluto-y. All rights reserved.
//

#import "Kiwi.h"
#import "NSObject+MethodSwizzling.h"

@interface PYATestMethodSwizzling : NSObject

- (int32_t)add:(int32_t)i1 i2:(int32_t)i2;
+ (int32_t)minus:(int32_t)i1 i2:(int32_t)i2;

@end

@implementation PYATestMethodSwizzling

- (int32_t)add:(int32_t)i1 i2:(int32_t)i2 {
    return i1 + i2;
}

+ (int32_t)minus:(int32_t)i1 i2:(int32_t)i2 {
    return i1 - i2;
}

- (int32_t)multiply:(int32_t)i1 i2:(int32_t)i2 {
    return i1 * i2;
}

+ (int32_t)divide:(int32_t)i1 i2:(int32_t)i2 {
    return i1 / i2;
}

@end

SPEC_BEGIN(MethodSwizzlingTests)

context(@"MethodSwizzling", ^{
    
    PYATestMethodSwizzling *obj = [[PYATestMethodSwizzling alloc] init];
    int32_t i1 = arc4random_uniform(UINT8_MAX);
    int32_t i2 = arc4random_uniform(UINT8_MAX);
    NSLog(@"%s, The test paramerts is i1: %d, i2: %d", __func__, i1, i2);
    
    describe(@"before swizzle the instance method", ^{
        it(@"should work as usual", ^{
            [[theValue([obj add:i1 i2:i1]) shouldNot] equal:theValue(i1 * i2)];
            [[theValue([obj add:i1 i2:i2]) should] equal:theValue(i1 + i2)];
            [[theValue([obj multiply:i1 i2:i1]) shouldNot] equal:theValue(i1 + i2)];
            [[theValue([obj multiply:i1 i2:i2]) should] equal:theValue(i1 * i2)];
        });
    });
    
    describe(@"when swizzle the instance method", ^{
        it(@"should swizzle success", ^{
            [PYATestMethodSwizzling methodSwizzleForInstanceFrom:@selector(add:i2:) to:@selector(multiply:i2:)];
            [[theValue([obj add:i1 i2:i2]) should] equal:theValue(i1 * i2)];
            [[theValue([obj add:i1 i2:i2]) shouldNot] equal:theValue(i1 + i2)];
            [[theValue([obj multiply:i1 i2:i2]) should] equal:theValue(i1 + i2)];
            [[theValue([obj multiply:i1 i2:i2]) shouldNot] equal:theValue(i1 * i2)];
        });
    });
    
    describe(@"before swizzle the class method", ^{
        it(@"should work as usual", ^{
            [[theValue([PYATestMethodSwizzling minus:i1 i2:i2]) shouldNot] equal:theValue(i1 / i2)];
            [[theValue([PYATestMethodSwizzling minus:i1 i2:i2]) should] equal:theValue(i1 - i2)];
            [[theValue([PYATestMethodSwizzling divide:i1 i2:i2]) shouldNot] equal:theValue(i1 - i2)];
            [[theValue([PYATestMethodSwizzling divide:i1 i2:i2]) should] equal:theValue(i1 / i2)];
        });
    });
    
    describe(@"when swizzle the class method", ^{
        it(@"should swizzle success", ^{
            [PYATestMethodSwizzling methodSwizzleForClassFrom:@selector(minus:i2:) to:@selector(divide:i2:)];
            [[theValue([PYATestMethodSwizzling minus:i1 i2:i2]) should] equal:theValue(i1 / i2)];
            [[theValue([PYATestMethodSwizzling minus:i1 i2:i2]) shouldNot] equal:theValue(i1 - i2)];
            [[theValue([PYATestMethodSwizzling divide:i1 i2:i2]) should] equal:theValue(i1 - i2)];
            [[theValue([PYATestMethodSwizzling divide:i1 i2:i2]) shouldNot] equal:theValue(i1 / i2)];
        });
    });
});

SPEC_END;
