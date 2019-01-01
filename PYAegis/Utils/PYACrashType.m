//
//  PYACrashType.m
//  PYAegis
//
//  Created by Pluto-Y on 2018/12/12.
//  Copyright © 2018 pluto-y. All rights reserved.
//

#import "PYACrashType.h"

NSString *NSStringFromPYACrashType(PYACrashType crashType) {
    if (crashType == PYACrashTypeNone) {
        return @"None";
    } else if ((crashType & PYACrashTypeUnrecognizedSelector) == PYACrashTypeUnrecognizedSelector) {
        return @"Unrecognized selector";
    } else if ((crashType & PYACrashTypeKVO) == PYACrashTypeKVO) {
        return @"KVO";
    } else if ((crashType & PYACrashTypeTimer) == PYACrashTypeTimer) {
        return @"Timer";
    } else if ((crashType & PYACrashTypeNotification) == PYACrashTypeNotification) {
        return @"Notification";
    } else if ((crashType & PYACrashTypeContainer) == PYACrashTypeContainer) {
        return @"Container";
    } else if ((crashType & PYACrashTypeString) == PYACrashTypeString) {
        return @"String";
    }
    return @"Unknow";
}
