//
//  PYACrashType.h
//  PYAegis
//
//  Created by Pluto-Y on 2018/12/12.
//  Copyright © 2018 pluto-y. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PYADefine.h"

typedef NS_OPTIONS(NSUInteger, PYACrashType) {
    PYACrashTypeNone                   = 0,
    PYACrashTypeUnrecognizedSelector   = 1 << 0,
    PYACrashTypeKVO                    = 1 << 1,
    PYACrashTypeTimer                  = 1 << 2,
    PYACrashTypeNotification           = 1 << 3,
    PYACrashTypeContainer              = 1 << 4,
    PYACrashTypeString                 = 1 << 5,
    PYACrashTypeAll                    = NSUIntegerMax
};

#ifdef __cplusplus
extern "C" {
#endif
    extern NSString *NSStringFromPYACrashType(PYACrashType crashType);
#ifdef __cplusplus
}
#endif
