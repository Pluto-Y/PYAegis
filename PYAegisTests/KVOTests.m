//
//  KVOTests.m
//  PYAegisTests
//
//  Created by Pluto-Y on 2018/9/28.
//  Copyright © 2018 pluto-y. All rights reserved.
//

#import "Kiwi.h"

@interface PYAObserverObj : NSObject

@end

@implementation PYAObserverObj

@end

@interface PYAObservedObj : NSObject

@property (nonatomic, assign) NSUInteger observedInt;
@property (nonatomic, strong) NSDate *observedDate;
@property (nonatomic, copy) NSString *observedStr;

@end

@implementation PYAObservedObj

- (void)dealloc {
    NSLog(@"%s", __func__);
}

@end

SPEC_BEGIN(KVOTests)

context(@"Key-Value Observering", ^{
    describe(@"when the observed object dealloc", ^{
        it(@"should not crash", ^{
            if (@available(iOS 9, *)) {
                NSLog(@"It's above iOS 9, so it will not crash");
            } else {
                [[theBlock(^{
                    @autoreleasepool {
                        PYAObservedObj *observedObj = [[PYAObservedObj alloc] init];
                        observedObj.observedInt = 1;
                        observedObj.observedDate = [NSDate date];
                        observedObj.observedStr = @"Hello";
                        PYAObserverObj *observerObj = [[PYAObserverObj alloc] init];
                        [observedObj addObserver:observerObj forKeyPath:@"observedDate" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:NULL];
                    }
                }) shouldNot] raiseWithName:NSInternalInconsistencyException];
            }
        });
    });
    
    describe(@"when the count of add and remove is not paired", ^{
        it(@"should not crash", ^{
            [[theBlock(^{
                PYAObservedObj *observedObj = [[PYAObservedObj alloc] init];
                observedObj.observedInt = 1;
                observedObj.observedDate = [NSDate date];
                observedObj.observedStr = @"Hello";
                PYAObserverObj *observerObj1 = [[PYAObserverObj alloc] init];
                [observedObj addObserver:observerObj1 forKeyPath:@"observedDate" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:NULL];
                
                [observedObj removeObserver:observerObj1 forKeyPath:@"observedDate" context:NULL];
                [observedObj removeObserver:observerObj1 forKeyPath:@"observedDate" context:NULL];
                [observedObj removeObserver:observerObj1 forKeyPath:@"observedStr" context:NULL];
                [observedObj removeObserver:observerObj1 forKeyPath:@"observedInt"];
            }) shouldNot] raise];
            
            [[theBlock(^{
                PYAObservedObj *observedObj = [[PYAObservedObj alloc] init];
                observedObj.observedInt = 1;
                observedObj.observedDate = [NSDate date];
                observedObj.observedStr = @"Hello";
                @autoreleasepool {
                    PYAObserverObj *observerObj1 = [[PYAObserverObj alloc] init];
                    [observedObj addObserver:observerObj1 forKeyPath:@"observedDate" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:NULL];
                }
                observedObj.observedDate = [NSDate date];
                observedObj.observedStr = @"World";
            }) shouldNot] raise];
        });
    });
});

SPEC_END
