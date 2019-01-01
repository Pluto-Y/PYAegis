//
//  NSObject+MethodSwizzling.h
//  PYAegis
//
//  Created by Pluto-Y on 22/08/2018.
//  Copyright © 2018 pluto-y. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PYADefine.h"

@interface NSObject (MethodSwizzling)

+ (void)methodSwizzleForInstanceFrom:(SEL)origin to:(SEL)target;
+ (void)methodSwizzleForClassFrom:(SEL)origin to:(SEL)target;

@end
