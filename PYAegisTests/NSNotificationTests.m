//
//  NotificationTests.m
//  PYAegisTests
//
//  Created by Pluto-Y on 2018/10/1.
//  Copyright © 2018 pluto-y. All rights reserved.
//

#import "Kiwi.h"

@interface PYATestObserver : NSObject

- (void)eventHandle:(NSNotification *)notification;

@end

@implementation PYATestObserver

- (void)eventHandle:(NSNotification *)notification {
    NSLog(@"%s", __func__);
}

- (void)dealloc {
    NSLog(@"%s", __func__);
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end

SPEC_BEGIN(NSNotificationTests)

context(@"NSNotification", ^{
    describe(@"when the observer forgot removeObserver", ^{
        it(@"should not crash", ^{
            if (@available(macOS 10.11, iOS 9.0, *)) {
                NSLog(@"It's above iOS 9, so it will not crash");
            } else {
#warning "consider complicate test cases"
                // It will crash, when the system version is below 9.0
                // And when the user forget to call [[NSNotificationCenter defaultCenter] removeObserver:self] before object released
                [[theBlock(^{
                    NSNotificationName PYATestNotificationName = @"pya_notification_name";
                    
                    dispatch_block_t block = ^{
                        PYATestObserver *observer = [[PYATestObserver alloc] init];
                        [[NSNotificationCenter defaultCenter] addObserver:observer selector:@selector(eventHandle:) name:PYATestNotificationName object:nil];
                        observer = nil;
                    };
                    
                    block();
                    
                    // Make the memory address of observer can be full of other object
                    NSMutableArray *arr = [NSMutableArray new];
                    for (int i = 0 ; i < 100 ; i ++) {
                        UIView *view = [[UIView alloc] init];
                        [arr addObject:view];
                    }
                    
                    [[NSNotificationCenter defaultCenter] postNotificationName:PYATestNotificationName object:nil];
                }) shouldNot] raise];
            }
        });
    });
});

SPEC_END
