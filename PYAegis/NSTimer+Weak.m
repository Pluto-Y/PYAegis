//
//  NSTimer+Weak.m
//  PYAegis
//
//  Created by Pluto-Y on 2018/9/3.
//  Copyright © 2018 pluto-y. All rights reserved.
//

#import "NSTimer+Weak.h"
#import "NSObject+MethodSwizzling.h"

@interface PYATimerProxy : NSObject

@property (nonatomic, weak) NSTimer *timer;
@property (nonatomic, weak) id target;
@property (nonatomic, assign) SEL selector;

- (void)fireProxyTimer:(NSTimer *)timer;

@end

@implementation PYATimerProxy

- (void)fireProxyTimer:(NSTimer *)timer {
    NSLog(@"fire proxy timer");
    if (!_target) {
        NSLog(@">>>>>>>>>> The timer did not be invlidated. <<<<<<<<<<");
        [_timer invalidate];
        _timer = nil;
        return;
    }
    if ([_target respondsToSelector:_selector]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [_target performSelector:_selector withObject:timer];
#pragma clang diagnostic pop
    }
}

@end

@implementation NSTimer (Weak)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [NSTimer methodSwizzleForClassFrom:@selector(scheduledTimerWithTimeInterval:target:selector:userInfo:repeats:) to:@selector(pya_scheduledTimerWithTimeInterval:target:selector:userInfo:repeats:)];
    });
}

+ (NSTimer *)pya_scheduledTimerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(id)userInfo repeats:(BOOL)yesOrNo {
    NSLog(@"pya_scheduledTimerWithTimeInterval:target:selector:userInfo:repeats:");
    if (yesOrNo) {
        PYATimerProxy *proxy = [[PYATimerProxy alloc] init];
        proxy.target = aTarget;
        proxy.selector = aSelector;
        NSTimer *timer = [NSTimer pya_scheduledTimerWithTimeInterval:ti target:proxy selector:@selector(fireProxyTimer:) userInfo:userInfo repeats:yesOrNo];
        proxy.timer = timer;
        return timer;
    }
    return [NSTimer pya_scheduledTimerWithTimeInterval:ti target:aTarget selector:aSelector userInfo:userInfo repeats:yesOrNo];
}

@end
