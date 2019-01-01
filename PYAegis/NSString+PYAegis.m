//
//  NSString+PYAegis.m
//  PYAegis
//
//  Created by Pluto-Y on 2018/12/19.
//  Copyright © 2018 pluto-y. All rights reserved.
//

#import "NSString+PYAegis.h"
#import "NSObject+MethodSwizzling.m"

@implementation NSString (PYAegis)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class NSPlaceholderString = NSClassFromString(@"NSPlaceholderString");
        [NSPlaceholderString methodSwizzleForInstanceFrom:@selector(length) to:@selector(pya_length)];
//        [NSPlaceholderString methodSwizzleForInstanceFrom:@selector(initWithFormat:locale:arguments:) to:@selector(pya_initWithFormat:locale:arguments:)];
        
        Class __NSCFConstantString = NSClassFromString(@"__NSCFConstantString");
        [__NSCFConstantString methodSwizzleForInstanceFrom:@selector(characterAtIndex:) to:@selector(pya__NSCFConstantString_characterAtIndex:)];
        [__NSCFConstantString methodSwizzleForInstanceFrom:@selector(substringFromIndex:) to:@selector(pya__NSCFConstantString_substringFromIndex:)];
        [__NSCFConstantString methodSwizzleForInstanceFrom:@selector(substringToIndex:) to:@selector(pya__NSCFConstantString_substringToIndex:)];
        [__NSCFConstantString methodSwizzleForInstanceFrom:@selector(substringWithRange:) to:@selector(pya__NSCFConstantString_substringWithRange:)];
        [__NSCFConstantString methodSwizzleForInstanceFrom:@selector(stringByReplacingOccurrencesOfString:withString:options:range:) to:@selector(pya__NSCFConstantString_stringByReplacingOccurrencesOfString:withString:options:range:)];
        [__NSCFConstantString methodSwizzleForInstanceFrom:@selector(stringByReplacingCharactersInRange:withString:) to:@selector(pya__NSCFConstantString_stringByReplacingCharactersInRange:withString:)];
        [__NSCFConstantString methodSwizzleForInstanceFrom:@selector(hasPrefix:) to:@selector(pya__NSCFConstantString_hasPrefix:)];
        [__NSCFConstantString methodSwizzleForInstanceFrom:@selector(hasSuffix:) to:@selector(pya__NSCFConstantString_hasSuffix:)];
        [__NSCFConstantString methodSwizzleForInstanceFrom:@selector(rangeOfString:options:range:locale:) to:@selector(pya__NSCFConstantString_rangeOfString:options:range:locale:)];
        [__NSCFConstantString methodSwizzleForInstanceFrom:@selector(rangeOfCharacterFromSet:options:range:) to:@selector(pya__NSCFConstantString_rangeOfCharacterFromSet:options:range:)];
        [__NSCFConstantString methodSwizzleForInstanceFrom:@selector(stringByAppendingString:) to:@selector(pya__NSCFConstantString_stringByAppendingString:)];
//        [__NSCFConstantString methodSwizzleForInstanceFrom:@selector(stringByAppendingFormat:) to:@selector(pya__NSCFConstantString_stringByAppendingFormat:)];
        
        Class __NSCFString = NSClassFromString(@"__NSCFString");
        [__NSCFString methodSwizzleForInstanceFrom:@selector(characterAtIndex:) to:@selector(pya__NSCFString_characterAtIndex:)];
        [__NSCFString methodSwizzleForInstanceFrom:@selector(substringFromIndex:) to:@selector(pya__NSCFString_substringFromIndex:)];
        [__NSCFString methodSwizzleForInstanceFrom:@selector(substringToIndex:) to:@selector(pya__NSCFString_substringToIndex:)];
        [__NSCFString methodSwizzleForInstanceFrom:@selector(substringWithRange:) to:@selector(pya__NSCFString_substringWithRange:)];
        [__NSCFString methodSwizzleForInstanceFrom:@selector(stringByReplacingOccurrencesOfString:withString:options:range:) to:@selector(pya__NSCFString_stringByReplacingOccurrencesOfString:withString:options:range:)];
        [__NSCFString methodSwizzleForInstanceFrom:@selector(stringByReplacingCharactersInRange:withString:) to:@selector(pya__NSCFString_stringByReplacingCharactersInRange:withString:)];
        [__NSCFString methodSwizzleForInstanceFrom:@selector(hasPrefix:) to:@selector(pya__NSCFString_hasPrefix:)];
        [__NSCFString methodSwizzleForInstanceFrom:@selector(hasSuffix:) to:@selector(pya__NSCFString_hasSuffix:)];
        [__NSCFString methodSwizzleForInstanceFrom:@selector(rangeOfString:options:range:locale:) to:@selector(pya__NSCFString_rangeOfString:options:range:locale:)];
        [__NSCFString methodSwizzleForInstanceFrom:@selector(rangeOfCharacterFromSet:options:range:) to:@selector(pya__NSCFString_rangeOfCharacterFromSet:options:range:)];
        [__NSCFString methodSwizzleForInstanceFrom:@selector(stringByAppendingString:) to:@selector(pya__NSCFString_stringByAppendingString:)];
//        [__NSCFString methodSwizzleForInstanceFrom:@selector(stringByAppendingFormat:) to:@selector(pya__NSCFString_stringByAppendingFormat:)];
        
        [NSString methodSwizzleForInstanceFrom:@selector(rangeOfComposedCharacterSequenceAtIndex:) to:@selector(pya_rangeOfComposedCharacterSequenceAtIndex:)];
    });
}

- (NSUInteger)pya_length {
    PYACrashLog(PYACrashTypeString, @"-length only defined for abstract class.  Define -[NSPlaceholderString length]!");
    return 0;
}

- (unichar)pya__NSCFConstantString_characterAtIndex:(NSUInteger)index {
    if (index >= self.length) {
        PYACrashLog(PYACrashTypeString, @"-[__NSCFConstantString characterAtIndex:]: Range or index out of bounds");
        return 0;
    }
    return [self pya__NSCFConstantString_characterAtIndex:index];
}

- (unichar)pya__NSCFString_characterAtIndex:(NSUInteger)index {
    if (index >= self.length) {
        PYACrashLog(PYACrashTypeString, @"-[__NSCFString characterAtIndex:]: Range or index out of bounds");
        return 0;
    }
    return [self pya__NSCFString_characterAtIndex:index];
}

- (NSString *)pya__NSCFConstantString_substringFromIndex:(NSUInteger)from {
    if (from > self.length) {
        PYACrashLog(PYACrashTypeString, @"[__NSCFConstantString substringFromIndex:]: Index %lu out of bounds; string length %lu", from, self.length);
        return nil;
    }
    return [self pya__NSCFConstantString_substringFromIndex:from];
}

- (NSString *)pya__NSCFString_substringFromIndex:(NSUInteger)from {
    if (from > self.length) {
        PYACrashLog(PYACrashTypeString, @"[__NSCFString substringFromIndex:]: Index %lu out of bounds; string length %lu", from, self.length);
        return nil;
    }
    return [self pya__NSCFString_substringFromIndex:from];
}

- (NSString *)pya__NSCFConstantString_substringToIndex:(NSUInteger)to {
    if (to > self.length) {
        PYACrashLog(PYACrashTypeString, @"-[__NSCFConstantString substringToIndex:]: Index %lu out of bounds; string length %lu", to, self.length);
        return nil;
    }
    return [self pya__NSCFConstantString_substringToIndex:to];
}

- (NSString *)pya__NSCFString_substringToIndex:(NSUInteger)to {
    if (to > self.length) {
        PYACrashLog(PYACrashTypeString, @"-[__NSCFString substringToIndex:]: Index %lu out of bounds; string length %lu", to, self.length);
        return nil;
    }
    return [self pya__NSCFString_substringToIndex:to];
}

- (NSString *)pya__NSCFConstantString_substringWithRange:(NSRange)range {
    if (range.location + range.length > self.length) {
        PYACrashLog(PYACrashTypeString, @"-[__NSCFConstantString substringWithRange:]: Range %@ out of bounds; string length %lu", NSStringFromRange(range), self.length);
        return nil;
    }
    return [self pya__NSCFConstantString_substringWithRange:range];
}

- (NSString *)pya__NSCFString_substringWithRange:(NSRange)range {
    if (range.location + range.length > self.length) {
        PYACrashLog(PYACrashTypeString, @"-[__NSCFString substringWithRange:]: Range %@ out of bounds; string length %lu", NSStringFromRange(range), self.length);
        return nil;
    }
    return [self pya__NSCFString_substringWithRange:range];
}

- (NSString *)pya__NSCFConstantString_stringByReplacingOccurrencesOfString:(NSString *)target withString:(NSString *)replacement options:(NSStringCompareOptions)options range:(NSRange)searchRange {
    if (!replacement) {
        PYACrashLog(PYACrashTypeString, @"-[__NSCFConstantString stringByReplacingOccurrencesOfString:withString:options:range:]: nil argument");
        return nil;
    } else if (!target) {
        PYACrashLog(PYACrashTypeString, @"-[__NSCFString replaceOccurrencesOfString:withString:options:range:]: nil argument");
        return nil;
    } else if (searchRange.location + searchRange.length > self.length) {
        PYACrashLog(PYACrashTypeString, @"-[__NSCFString replaceOccurrencesOfString：withString:options:range:]: Range %@ out of bounds; string length %lu", NSStringFromRange(searchRange), self.length);
        return nil;
    }
    return [self pya__NSCFConstantString_stringByReplacingOccurrencesOfString:target withString:replacement options:options range:searchRange];
}

- (NSString *)pya__NSCFString_stringByReplacingOccurrencesOfString:(NSString *)target withString:(NSString *)replacement options:(NSStringCompareOptions)options range:(NSRange)searchRange {
    if (!replacement) {
        PYACrashLog(PYACrashTypeString, @"-[__NSCFString stringByReplacingOccurrencesOfString:withString:options:range:]: nil argument");
        return nil;
    } else if (!target) {
        PYACrashLog(PYACrashTypeString, @"-[__NSCFString replaceOccurrencesOfString:withString:options:range:]: nil argument");
        return nil;
    } else if (searchRange.location + searchRange.length > self.length) {
        PYACrashLog(PYACrashTypeString, @"-[__NSCFString replaceOccurrencesOfString：withString:options:range:]: Range %@ out of bounds; string length %lu", NSStringFromRange(searchRange), self.length);
        return nil;
    }
    return [self pya__NSCFString_stringByReplacingOccurrencesOfString:target withString:replacement options:options range:searchRange];
}

- (NSString *)pya__NSCFConstantString_stringByReplacingCharactersInRange:(NSRange)range withString:(NSString *)replacement {
    if (!replacement) {
        PYACrashLog(PYACrashTypeString, @"-[__NSCFConstantString stringByReplacingCharactersInRange:withString:]: nil argument");
        return nil;
    } else if (range.location + range.length > self.length) {
        PYACrashLog(PYACrashTypeString, @"-[__NSCFString replaceCharactersInRange：withString：]： Range or index out of bounds");
        return nil;
    }
    return [self pya__NSCFConstantString_stringByReplacingCharactersInRange:range withString:replacement];
}

- (NSString *)pya__NSCFString_stringByReplacingCharactersInRange:(NSRange)range withString:(NSString *)replacement {
    if (!replacement) {
        PYACrashLog(PYACrashTypeString, @" -[__NSCFString stringByReplacingCharactersInRange:withString:]: nil argument");
        return nil;
    } else if (range.location + range.length > self.length) {
        PYACrashLog(PYACrashTypeString, @"-[__NSCFString replaceCharactersInRange:withString:]: Range or index out of bounds");
        return nil;
    }
    return [self pya__NSCFString_stringByReplacingCharactersInRange:range withString:replacement];
}

- (BOOL)pya__NSCFConstantString_hasPrefix:(NSString *)str {
    if (!str) {
        PYACrashLog(PYACrashTypeString, @"-[__NSCFConstantString hasPrefix:]: nil argument");
        return NO;
    }
    return [self pya__NSCFConstantString_hasPrefix:str];
}

- (BOOL)pya__NSCFString_hasPrefix:(NSString *)str {
    if (!str) {
        PYACrashLog(PYACrashTypeString, @"-[__NSCFString hasPrefix:]: nil argument");
        return NO;
    }
    return [self pya__NSCFString_hasPrefix:str];
}

- (BOOL)pya__NSCFConstantString_hasSuffix:(NSString *)str {
    if (!str) {
        PYACrashLog(PYACrashTypeString, @"-[__NSCFConstantString hasSuffix:]: nil argument");
        return NO;
    }
    return [self pya__NSCFConstantString_hasSuffix:str];
}

- (BOOL)pya__NSCFString_hasSuffix:(NSString *)str {
    if (!str) {
        PYACrashLog(PYACrashTypeString, @"-[__NSCFString hasSuffix:]: nil argument");
        return NO;
    }
    return [self pya__NSCFString_hasSuffix:str];
}

- (NSRange)pya__NSCFConstantString_rangeOfString:(NSString *)searchString options:(NSStringCompareOptions)mask range:(NSRange)rangeOfReceiverToSearch locale:(NSLocale *)locale {
    if (rangeOfReceiverToSearch.location + rangeOfReceiverToSearch.length > self.length) {
        PYACrashLog(PYACrashTypeString, @" -[__NSCFConstantString pya__NSCFConstantString_rangeOfString:options:range:locale:]: Range %@ out of bounds; string length %lu", NSStringFromRange(rangeOfReceiverToSearch), self.length);
        return NSMakeRange(NSNotFound, 0);
    } else if (!searchString) {
        PYACrashLog(PYACrashTypeString, @"-[__NSCFConstantString rangeOfString:options:range:locale:]: nil argument");
        return NSMakeRange(NSNotFound, 0);
    }
    return [self pya__NSCFConstantString_rangeOfString:searchString options:mask range:rangeOfReceiverToSearch locale:locale];
}

- (NSRange)pya__NSCFString_rangeOfString:(NSString *)searchString options:(NSStringCompareOptions)mask range:(NSRange)rangeOfReceiverToSearch locale:(NSLocale *)locale {
    if (rangeOfReceiverToSearch.location + rangeOfReceiverToSearch.length > self.length) {
        PYACrashLog(PYACrashTypeString, @"-[__NSCFString pya__NSCFString_rangeOfString:options:range:locale:]: Range %@ out of bounds; string length %lu", NSStringFromRange(rangeOfReceiverToSearch), self.length);
        return NSMakeRange(NSNotFound, 0);
    } else if (!searchString) {
        PYACrashLog(PYACrashTypeString, @"-[__NSCFString rangeOfString:options:range:locale:]: nil argument");
        return NSMakeRange(NSNotFound, 0);
    }
    return [self pya__NSCFString_rangeOfString:searchString options:mask range:rangeOfReceiverToSearch locale:locale];
}

- (NSRange)pya__NSCFConstantString_rangeOfCharacterFromSet:(NSCharacterSet *)searchSet options:(NSStringCompareOptions)mask range:(NSRange)rangeOfReceiverToSearch {
    if (rangeOfReceiverToSearch.location + rangeOfReceiverToSearch.length > self.length) {
        PYACrashLog(PYACrashTypeString, @"-[__NSCFConstantString pya__NSCFConstantString_rangeOfCharacterFromSet:options:range:]: Range %@ out of bounds; string length %lu", NSStringFromRange(rangeOfReceiverToSearch), self.length);
        return NSMakeRange(NSNotFound, 0);
    } else if (!searchSet) {
        PYACrashLog(PYACrashTypeString, @" -[__NSCFConstantString rangeOfCharacterFromSet:options:range:]: nil argument");
        return NSMakeRange(NSNotFound, 0);
    }
    return [self pya__NSCFConstantString_rangeOfCharacterFromSet:searchSet options:mask range:rangeOfReceiverToSearch];
}

- (NSRange)pya__NSCFString_rangeOfCharacterFromSet:(NSCharacterSet *)searchSet options:(NSStringCompareOptions)mask range:(NSRange)rangeOfReceiverToSearch {
    if (rangeOfReceiverToSearch.location + rangeOfReceiverToSearch.length > self.length) {
        PYACrashLog(PYACrashTypeString, @"-[__NSCFString pya__NSCFString_rangeOfCharacterFromSet:options:range:]: Range %@ out of bounds; string length %lu", NSStringFromRange(rangeOfReceiverToSearch), self.length);
        return NSMakeRange(NSNotFound, 0);
    } else if (!searchSet) {
        PYACrashLog(PYACrashTypeString, @"-[__NSCFString rangeOfCharacterFromSet:options:range:]: nil argument");
        return NSMakeRange(NSNotFound, 0);
    }
    return [self pya__NSCFString_rangeOfCharacterFromSet:searchSet options:mask range:rangeOfReceiverToSearch];
}

- (NSRange)pya_rangeOfComposedCharacterSequenceAtIndex:(NSUInteger)index {
    if (index >= self.length) {
        PYACrashLog(PYACrashTypeString, @"The index %lu is invalid", index);
        return NSMakeRange(NSNotFound, 0);
    }
    return [self pya_rangeOfComposedCharacterSequenceAtIndex:index];
}

- (NSString *)pya__NSCFConstantString_stringByAppendingString:(NSString *)aString {
    if (!aString) {
        PYACrashLog(PYACrashTypeString, @"-[__NSCFConstantString stringByAppendingString:]: nil argument");
        return nil;
    }
    return [self pya__NSCFConstantString_stringByAppendingString:aString];
}

- (NSString *)pya__NSCFString_stringByAppendingString:(NSString *)aString {
    if (!aString) {
        PYACrashLog(PYACrashTypeString, @"-[__NSCFString stringByAppendingString:]: nil argument");
        return nil;
    }
    return [self pya__NSCFString_stringByAppendingString:aString];
}

//- (NSString *)pya__NSCFConstantString_stringByAppendingFormat:(NSString *)format, ... {
//    if (!format) {
//        PYACrashLog(PYACrashTypeString, @"-[NSPlaceholderString initWithFormat:locale:arguments:]: nil argument");
//        return nil;
//    }
//    va_list args;
//    va_start(args,format);
//    NSString *result = [self pya__NSCFConstantString_stringByAppendingFormat:format, args];
//    va_end(args);
//
//    return result;
//}
//
//- (NSString *)pya__NSCFString_stringByAppendingFormat:(NSString *)format, ... {
//    if (!format) {
//        PYACrashLog(PYACrashTypeString, @"-[NSPlaceholderString initWithFormat:locale:arguments:]: nil argument");
//        return nil;
//    }
//    va_list args;
//    va_start(args,format);
//    NSString *result = [self pya__NSCFString_stringByAppendingFormat:format, args];
//    va_end(args);
//
//    return result;
//}
//
//- (instancetype)pya_initWithFormat:(NSString *)format locale:(id)locale arguments:(va_list)argList {
//    if (!format) {
//        PYACrashLog(PYACrashTypeString, @"-[NSPlaceholderString initWithFormat:locale:arguments:]: nil argument");
//        return nil;
//    }
//    return [self pya_initWithFormat:format locale:locale arguments:argList];
//}

@end
