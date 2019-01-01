//
//  TimerTests.m
//  PYAegisTests
//
//  Created by Pluto-Y on 2018/8/28.
//  Copyright © 2018 pluto-y. All rights reserved.
//

#import "Kiwi.h"
#import "NSTimer+Weak.h"

@interface PYATimerTarget : NSObject

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, copy) NSString *name;

- (void)fireTimer;

@end

@implementation PYATimerTarget

- (void)fireTimer {
    NSLog(@"%@ was called method named '%s'", _name, __func__);
}

- (void)dealloc {
    NSLog(@"%@ call the method named '%s'", _name, __func__);
}

@end

SPEC_BEGIN(NSTimerTests)

context(@"NSTimer", ^{
//    describe(@"before add protector", ^{
//        it(@"should not crash", ^{
//            __weak PYATimerTarget *weakTarget = nil;
//            __weak PYATimerTarget *weakRepeatTarget = nil;
//            __weak PYATimerTarget *weakNoRepeatTarget = nil;
//
//            @autoreleasepool {
//                PYATimerTarget *repeatTarget = [[PYATimerTarget alloc] init];
//                repeatTarget.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:repeatTarget selector:@selector(fireTimer) userInfo:nil repeats:YES];
//                repeatTarget.name = @"repeatTarget";
//
//                PYATimerTarget *noRepeatTarget = [[PYATimerTarget alloc] init];
//                noRepeatTarget.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:noRepeatTarget selector:@selector(fireTimer) userInfo:nil repeats:NO];
//                noRepeatTarget.name = @"noRepeatTarget";
//
//                PYATimerTarget *invalidatedTarget = [[PYATimerTarget alloc] init];
//                invalidatedTarget.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:invalidatedTarget selector:@selector(fireTimer) userInfo:nil repeats:YES];
//                invalidatedTarget.name = @"invalidateTimerTarget";
//
//                weakTarget = invalidatedTarget;
//                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                    [weakTarget.timer invalidate];
//                });
//
//                weakRepeatTarget = repeatTarget;
//                weakNoRepeatTarget = noRepeatTarget;
//            }
//
//            [[expectFutureValue(weakRepeatTarget) shouldNotEventuallyBeforeTimingOutAfter(1.0)] beNil];
//            [[expectFutureValue(weakNoRepeatTarget) shouldEventuallyBeforeTimingOutAfter(1.0)] beNil];
//            [[expectFutureValue(weakTarget) shouldEventuallyBeforeTimingOutAfter(1.0)] beNil];
//        });
//    });
    
    describe(@"after add protector", ^{
        it(@"should not crash", ^{
            __weak PYATimerTarget *weakRepeatTarget = nil;
            @autoreleasepool {
                PYATimerTarget *repeatTarget = [[PYATimerTarget alloc] init];
                repeatTarget.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:repeatTarget selector:@selector(fireTimer) userInfo:nil repeats:YES];
                repeatTarget.name = @"repeatTarget";
                
                weakRepeatTarget = repeatTarget;
                [[expectFutureValue(weakRepeatTarget) shouldNotEventuallyBeforeTimingOutAfter(0.4)] beNil];

                NSTimeInterval timeout = [[NSDate date] timeIntervalSince1970] + 0.8;
                while (timeout > [[NSDate date] timeIntervalSince1970]) {
                    [NSThread sleepForTimeInterval:0.5];
                }
            }
            
            [[expectFutureValue(weakRepeatTarget) shouldEventuallyBeforeTimingOutAfter(3.0)] beNil];
        });
    });
});

SPEC_END
