//
//  PYADefine.h
//  PYAegis
//
//  Created by Pluto-Y on 2018/12/12.
//  Copyright © 2018 pluto-y. All rights reserved.
//

#ifndef PYADefine_h
#define PYADefine_h

#if __OBJC__
#import <Foundation/Foundation.h>
#import "PYACrashType.h"
#endif

/**
 * Make global functions usable in C++
 */
#ifdef __cplusplus
#define PYA_EXTERN extern "C" __attribute__((visibility("default")))
#else
#define PYA_EXTERN extern __attribute__((visibility("default")))
#endif

#define PYACrashLog(type, reasonFmrt, ...) do{ \
    NSLog(@">>>>>>>>>> PYAegis capture a crash <<<<<<<<<<"); \
    NSLog(@">>>>>>>>>> Type: %@ <<<<<<<<<<",    NSStringFromPYACrashType(type)); \
    NSLog(@">>>>>>>>>> Reason: %@ <<<<<<<<<<", [NSString stringWithFormat:reasonFmrt, ##__VA_ARGS__]); \
    NSLog(@">>>>>>>>>> Call stack: <<<<<<<<<<\n%@", [NSThread callStackSymbols]); \
    } while(0)

#endif /* PYADefine_h */
