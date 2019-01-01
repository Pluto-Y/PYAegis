//
//  UnrecognizedSelectTests.m
//  PYAegisTests
//
//  Created by Pluto-Y on 24/08/2018.
//  Copyright © 2018 pluto-y. All rights reserved.
//

#import "Kiwi.h"
#import "NSObject+MethodSwizzling.h"

@interface PYATestUnrecognizedSelector : NSObject
@end

@implementation PYATestUnrecognizedSelector
@end

@interface PYATestUnrecognizedSelectorOverride : NSObject
@end

@implementation PYATestUnrecognizedSelectorOverride

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    NSMethodSignature *signature = [super methodSignatureForSelector:aSelector];
    
    if (!signature) {
        signature = [NSMethodSignature signatureWithObjCTypes:"v@:"];
    }
    
    return signature;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    [super forwardInvocation:anInvocation];
}

@end

SPEC_BEGIN(UnrecognizedSelectorTests)

context(@"UnrecognizedSelector", ^{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    SEL notExistMethodSEL = @selector(notExistMethod:);
#pragma clang diagnostic pop
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    describe(@"when perform an unrecognized selector and instance has not been override forwardInvocation", ^{
        it(@"should not crash", ^{
            [[theBlock(^{
                PYATestUnrecognizedSelector *obj = [PYATestUnrecognizedSelector new];
                [obj performSelector:notExistMethodSEL];
            }) shouldNot] raise];
        });
    });
    
    describe(@"when perform an unrecognized selector and instance has been override forwardInvocation", ^{
        it(@"should crash", ^{
            [[theBlock(^{
                PYATestUnrecognizedSelectorOverride *obj2 = [PYATestUnrecognizedSelectorOverride new];
                [obj2 performSelector:notExistMethodSEL];
            }) should] raise];
        });
    });
#pragma clang diagnostic pop
});

SPEC_END;
