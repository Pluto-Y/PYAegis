//
//  NSMutableString+PYAegis.m
//  PYAegis
//
//  Created by linhuijie on 2018/12/24.
//  Copyright © 2018年 pluto-y. All rights reserved.
//

#import "NSMutableString+PYAegis.h"
#import "NSObject+MethodSwizzling.m"

@implementation NSMutableString (PYAegis)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class NSPlaceholderMutableString = NSClassFromString(@"NSPlaceholderMutableString");
        [NSPlaceholderMutableString methodSwizzleForInstanceFrom:@selector(length) to:@selector(pya_NSPlaceholderMutableString_length)];
        
        Class __NSCFString = NSClassFromString(@"__NSCFString");
        [__NSCFString methodSwizzleForInstanceFrom:@selector(appendString:) to:@selector(pya__NSCFString_appendString:)];
        [__NSCFString methodSwizzleForInstanceFrom:@selector(insertString:atIndex:) to:@selector(pya__NSCFString_insertString:atIndex:)];
        [__NSCFString methodSwizzleForInstanceFrom:@selector(deleteCharactersInRange:) to:@selector(pya__NSCFString_deleteCharactersInRange:)];
        [__NSCFString methodSwizzleForInstanceFrom:@selector(setString:) to:@selector(pya__NSCFString_setString:)];
        [__NSCFString methodSwizzleForInstanceFrom:@selector(replaceCharactersInRange:withString:) to:@selector(pya__NSCFString_replaceCharactersInRange:withString:)];
        [__NSCFString methodSwizzleForInstanceFrom:@selector(replaceOccurrencesOfString:withString:options:range:) to:@selector(pya__NSCFString_replaceOccurrencesOfString:withString:options:range:)];
        
        Class NSMutableString = NSClassFromString(@"NSMutableString");
        [NSMutableString methodSwizzleForInstanceFrom:@selector(initWithCapacity:) to:@selector(pya_NSMutableString_initWithCapacity:)];
    });
}

#pragma mark - NSPlaceholderMutableString
- (NSUInteger)pya_NSPlaceholderMutableString_length {
    PYACrashLog(PYACrashTypeString, @"-length only defined for abstract class.  Define -[NSPlaceholderMutableString length]!");
    return 0;
}

#pragma mark - __NSCFString
- (void)pya__NSCFString_appendString:(NSString *)aString {
    if (!aString) {
        PYACrashLog(PYACrashTypeString, @"-[__NSCFString appendString:]: nil argument'");
        return;
    }
    
    [self pya__NSCFString_appendString:aString];
}

- (void)pya__NSCFString_insertString:(NSString *)aString atIndex:(NSUInteger)loc {
    
    if (!aString) {
        PYACrashLog(PYACrashTypeString, @"-[__NSCFString appendString:]: nil argument'");
        return;
    }
    
    if (loc < 0 || loc > self.length) {
        PYACrashLog(PYACrashTypeString, @"-[__NSCFString insertString:atIndex:]: Range or index out of bounds");
        return;
    }
    
    [self pya__NSCFString_insertString:aString atIndex:loc];
}

- (void)pya__NSCFString_deleteCharactersInRange:(NSRange)range {
    if (range.location + range.length > self.length) {
        PYACrashLog(PYACrashTypeString, @"-[__NSCFString deleteCharactersInRange:]: Range or index out of bounds");
        return;
    }
    
    [self pya__NSCFString_deleteCharactersInRange:range];
}

- (void)pya__NSCFString_setString:(NSString *)aString {
    if (!aString) {
        PYACrashLog(PYACrashTypeString, @"-[__NSCFString setString:]: nil argument");
        return;
    }
    
    [self pya__NSCFString_setString:aString];
}

- (void)pya__NSCFString_replaceCharactersInRange:(NSRange)range withString:(NSString *)aString {
    
    if (range.location + range.length > self.length) {
        PYACrashLog(PYACrashTypeString, @"-[__NSCFString replaceCharactersInRange:withString:]: Range or index out of bounds");
        return;
    }
    
    if (!aString) {
        PYACrashLog(PYACrashTypeString, @"-[__NSCFString replaceCharactersInRange:withString:]: nil argument");
        return;
    }
    
    [self pya__NSCFString_replaceCharactersInRange:range withString:aString];
    
}

- (NSUInteger)pya__NSCFString_replaceOccurrencesOfString:(NSString *)target withString:(NSString *)replacement options:(NSStringCompareOptions)options range:(NSRange)searchRange {
    
    if (!target) {
        PYACrashLog(PYACrashTypeString, @"-[__NSCFString replaceOccurrencesOfString:withString:options:range:]: nil argument");
        return 0;
    }
    
    if (!replacement) {
        PYACrashLog(PYACrashTypeString, @"-[__NSCFString replaceOccurrencesOfString:withString:options:range:]: nil argument");
        return 0;
    }
    
    if (searchRange.location + searchRange.length > self.length) {
        PYACrashLog(PYACrashTypeString, @"-[__NSCFString replaceOccurrencesOfString:withString:options:range:]: Range %@ out of bounds; string length %lu", NSStringFromRange(searchRange), self.length);
        return 0;
    }
    
    return [self pya__NSCFString_replaceOccurrencesOfString:target withString:replacement options:options range:searchRange];
}

#pragma mark - NSMutableString
- (NSMutableString *)pya_NSMutableString_initWithCapacity:(NSUInteger)capacity {
    PYACrashLog(PYACrashTypeString, @"*** initialization method -initWithCapacity: cannot be sent to an abstract object of class %@: Create a concrete instance!", [self class]);
    
    return nil;
}

@end
