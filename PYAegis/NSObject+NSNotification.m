//
//  NSObject+Notification.m
//  PYAegis
//
//  Created by Pluto-Y on 2018/10/1.
//  Copyright © 2018 pluto-y. All rights reserved.
//

#import "NSObject+NSNotification.h"
#import "NSObject+MethodSwizzling.h"
#import <objc/runtime.h>

@interface NSObject()

@property (nonatomic, assign) BOOL hasRegisterForNotification;

@end

@implementation NSObject (NSNotification)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (@available(macOS 10.11, iOS 9.0, *)) {
            NSLog(@">>>>>>>>>> It does not swizzle dealloc for notification crash. <<<<<<<<<");
        } else {
            [self methodSwizzleForInstanceFrom:NSSelectorFromString(@"dealloc") to:@selector(pya_notification_dealloc)];
        }
    });
}

- (void)pya_notification_dealloc {
    if (self.hasRegisterForNotification) {
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }
    [self pya_notification_dealloc];
}

- (BOOL)hasRegisterForNotification {
    NSNumber *resultNum = objc_getAssociatedObject(self, @selector(hasRegisterForNotification));
    return [resultNum boolValue];
}

- (void)setHasRegisterForNotification:(BOOL)hasRegisterForNotification {
    objc_setAssociatedObject(self, @selector(hasRegisterForNotification), @(hasRegisterForNotification), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

@interface NSNotificationCenter (PYAegis)

@end

@implementation NSNotificationCenter (PYAegis)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (@available(macOS 10.11, iOS 9.0, *)) {
        } else {
            [self methodSwizzleForInstanceFrom:@selector(addObserver:selector:name:object:) to:@selector(pya_addObserver:selector:name:object:)];
        }
    });
}

- (void)pya_addObserver:(id)observer selector:(SEL)aSelector name:(NSNotificationName)aName object:(id)anObject {
    ((NSObject *)observer).hasRegisterForNotification = YES;
    [self pya_addObserver:observer selector:aSelector name:aName object:anObject];
}

@end
