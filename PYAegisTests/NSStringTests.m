//
//  NSStringTests.m
//  PYAegisTests
//
//  Created by Pluto-Y on 2018/12/19.
//  Copyright © 2018 pluto-y. All rights reserved.
//

#import "Kiwi.h"

SPEC_BEGIN(NSStringTests)

context(@"NSString", ^{
    int constInt = 6;
    NSString *nilStr = nil;
    NSString *constantStr = @"Hello World";
    NSString *string = [NSString stringWithFormat:@"six equal %d", constInt];
    NSString *emptyStr = @"";
    
    describe(@"get length from 'NSPlaceholderString'", ^{
        it(@"should not crash", ^{
            [[theBlock(^{
                [[theValue([NSString alloc].length) should] beZero];
            }) shouldNot] raiseWithName:NSInvalidArgumentException];
        });
    });
    
    describe(@"get character at index", ^{
        describe(@"and index is out of range", ^{
            it(@"should not crash", ^{
                [[theBlock(^{
                    [[theValue([constantStr characterAtIndex:constantStr.length]) should] equal:theValue(0)];
                    [[theValue([constantStr characterAtIndex:constantStr.length + 1]) should] equal:theValue(0)];
                    [[theValue([string characterAtIndex:string.length]) should] equal:theValue(0)];
                    [[theValue([string characterAtIndex:string.length]) should] equal:theValue(0)];
                }) shouldNot] raiseWithName:NSRangeException];
            });
        });
        
        describe(@"and index is valid", ^{
            [[theValue([constantStr characterAtIndex:0]) should] equal:theValue('H')];
            [[theValue([constantStr characterAtIndex:5]) should] equal:theValue(' ')];
            [[theValue([string characterAtIndex:0]) should] equal:theValue('s')];
            [theValue([string characterAtIndex:string.length - 1]) equal:theValue('6')];
        });
    });
    
    describe(@"get substring", ^{
        describe(@"from index", ^{
            describe(@"when the index is out range", ^{
                it(@"should not crash", ^{
                    [[theBlock(^{
                        [[[constantStr substringFromIndex:constantStr.length + 1] should] beNil];
                        [[[string substringFromIndex:string.length + 1] should] beNil];
                    }) shouldNot] raiseWithName:NSRangeException];
                });
            });
            
            describe(@"when the index is valid", ^{
               it(@"should have same behavior as old", ^{
                   [[[constantStr substringFromIndex:6] should] equal:@"World"];
                   [[[constantStr substringFromIndex:constantStr.length] should] equal:emptyStr];

                   [[[string substringFromIndex:9] should] equal:[NSString stringWithFormat:@" %d", constInt]];
                   [[[string substringFromIndex:string.length] should] equal:emptyStr];
               });
            });
        });
        
        describe(@"to index", ^{
            describe(@"when the index is out range", ^{
                it(@"should not be crash", ^{
                    [[theBlock(^{
                        [[[constantStr substringToIndex:constantStr.length + 1] should] beNil];
                        [[[string substringToIndex:string.length + 1] should] beNil];
                    }) shouldNot] raiseWithName:NSRangeException];
                });
            });
            
            describe(@"when the index is valid", ^{
                it(@"should have same behavior as old", ^{
                    [[[constantStr substringToIndex:5] should] equal:@"Hello"];
                    [[[string substringToIndex:5] should] equal:@"six e"];
                });
            });
        });
        
        describe(@"in range", ^{
            describe(@"when the range is invalid", ^{
                it(@"should not crash", ^{
                    [[theBlock(^{
                        [[[constantStr substringWithRange:NSMakeRange(0, constantStr.length + 1)] should] beNil];
                        [[[constantStr substringWithRange:NSMakeRange(0, constantStr.length + 2)] should] beNil];
                        [[[string substringWithRange:NSMakeRange(0, string.length + 1)] should] beNil];
                        [[[string substringWithRange:NSMakeRange(0, string.length + 2)] should] beNil];
                    }) shouldNot] raiseWithName:NSRangeException];
                });
            });
            
            describe(@"when the range is valid", ^{
                it(@"should have same behavior as old", ^{
                    [[[constantStr substringWithRange:NSMakeRange(0, constantStr.length - 1)] should] equal:@"Hello Worl"];
                    [[[constantStr substringWithRange:NSMakeRange(0, 7)] should] equal:@"Hello W"];
                    [[[string substringWithRange:NSMakeRange(0, string.length - 1)] should] equal:@"six equal "];
                    [[[string substringWithRange:NSMakeRange(0, 7)] should] equal:@"six equ"];
                });
            });
        });
    });
    
    describe(@"replace string", ^{
        describe(@"when call 'stringByReplacingOccurrencesOfString:withString:'", ^{
            describe(@"and the origin or target string is nil", ^{
                it(@"should not crash and treat the string as empty string", ^{
                    [[theBlock(^{
                        [[[constantStr stringByReplacingOccurrencesOfString:nilStr withString:nilStr] should] beNil];
                        [[[constantStr stringByReplacingOccurrencesOfString:@"h" withString:nilStr] should] beNil];
                        [[[constantStr stringByReplacingOccurrencesOfString:nilStr withString:@"w"] should] beNil];
                        [[[string stringByReplacingOccurrencesOfString:nilStr withString:nilStr] should] beNil];
                        [[[string stringByReplacingOccurrencesOfString:@"h" withString:nilStr] should] beNil];
                        [[[string stringByReplacingOccurrencesOfString:nilStr withString:@"w"] should] beNil];
                    }) shouldNot] raiseWithName:NSInvalidArgumentException];
                });
            });
            
            describe(@"and the origin and target are valid", ^{
                it(@"should have same behavior as old", ^{
                    [[[constantStr stringByReplacingOccurrencesOfString:@"o" withString:@""] should] equal:@"Hell Wrld"];
                    [[[constantStr stringByReplacingOccurrencesOfString:@"z" withString:@"h"] should] equal:constantStr];
                    [[[string stringByReplacingOccurrencesOfString:@"x" withString:@"z"] should] equal:[NSString stringWithFormat:@"siz equal %d", constInt]];
                    [[[string stringByReplacingOccurrencesOfString:@" " withString:@""] should] equal:[NSString stringWithFormat:@"sixequal%d", constInt]];
                });
            });
        });
        
        describe(@"whe call 'stringByReplacingOccurrencesOfString:withString:options:range:'", ^{
            describe(@"and the paramters are invalid", ^{
                it(@"should not crash and return nil", ^{
                    [[theBlock(^{
                        [[[constantStr stringByReplacingOccurrencesOfString:nilStr withString:nilStr options:0 range:NSMakeRange(0, constantStr.length + 1)] should] beNil];
                        [[[constantStr stringByReplacingOccurrencesOfString:nilStr withString:nilStr options:0 range:NSMakeRange(0, constantStr.length + 2)] should] beNil];
                        [[[constantStr stringByReplacingOccurrencesOfString:@"h" withString:nilStr options:0 range:NSMakeRange(0, constantStr.length)] should] beNil];
                        [[[constantStr stringByReplacingOccurrencesOfString:nilStr withString:@"w" options:0 range:NSMakeRange(0, constantStr.length)] should] beNil];
                        [[[constantStr stringByReplacingOccurrencesOfString:@"h" withString:@"w" options:0 range:NSMakeRange(0, constantStr.length + 1)] should] beNil];
                        
                        [[[string stringByReplacingOccurrencesOfString:nilStr withString:nilStr options:0 range:NSMakeRange(0, string.length + 1)] should] beNil];
                        [[[string stringByReplacingOccurrencesOfString:nilStr withString:nilStr options:0 range:NSMakeRange(0, string.length + 2)] should] beNil];
                        [[[string stringByReplacingOccurrencesOfString:@"h" withString:nilStr options:0 range:NSMakeRange(0, string.length)] should] beNil];
                        [[[string stringByReplacingOccurrencesOfString:nilStr withString:@"w" options:0 range:NSMakeRange(0, string.length)] should] beNil];
                        [[[string stringByReplacingOccurrencesOfString:@"h" withString:@"w" options:0 range:NSMakeRange(0, string.length + 1)] should] beNil];
                    }) shouldNot] raise];
                });
            });
            
            describe(@"and the parameters are valid", ^{
                it(@"should have same behavior as old", ^{
                    [[[constantStr stringByReplacingOccurrencesOfString:@"H" withString:@"h" options:0 range:NSMakeRange(0, constantStr.length)] should] equal:@"hello World"];
                    NSString *str1 = @"HELLO world";
                    [[[str1 stringByReplacingOccurrencesOfString:@"o" withString:@"0" options:NSCaseInsensitiveSearch range:NSMakeRange(0, str1.length)] should] equal:@"HELL0 w0rld"];
                    [[[string stringByReplacingOccurrencesOfString:@" " withString:@"#" options:NSBackwardsSearch range:NSMakeRange(0, string.length)] should] equal:[NSString stringWithFormat:@"six#equal#%d", constInt]];
                });
            });
        });
        
        describe(@"when call 'stringByReplacingCharactersInRange:withString:'", ^{
            describe(@"and the parameters are invlid", ^{
                it(@"should not crash and return nil", ^{
                    [[theBlock(^{
                        [[[constantStr stringByReplacingCharactersInRange:NSMakeRange(0, constantStr.length + 1) withString:nilStr] should] beNil];
                        [[[constantStr stringByReplacingCharactersInRange:NSMakeRange(5, constantStr.length) withString:nilStr] should] beNil];
                        [[[constantStr stringByReplacingCharactersInRange:NSMakeRange(5, 0) withString:nilStr] should] beNil];
                        [[[constantStr stringByReplacingCharactersInRange:NSMakeRange(5, constantStr.length) withString:@""] should] beNil];
                        
                        [[[string stringByReplacingCharactersInRange:NSMakeRange(0, string.length + 1) withString:nilStr] should] beNil];
                        [[[string stringByReplacingCharactersInRange:NSMakeRange(5, string.length) withString:nilStr] should] beNil];
                        [[[string stringByReplacingCharactersInRange:NSMakeRange(5, 0) withString:nilStr] should] beNil];
                        [[[string stringByReplacingCharactersInRange:NSMakeRange(5, string.length) withString:@""] should] beNil];
                    }) shouldNot] raise];
                });
            });
            
            describe(@"and the parameter are valid", ^{
                it(@"should have same behavior as old", ^{
                    [[[constantStr stringByReplacingCharactersInRange:NSMakeRange(0, constantStr.length) withString:@""] should] equal:emptyStr];
                    [[[constantStr stringByReplacingCharactersInRange:NSMakeRange(0, constantStr.length) withString:@"abc"] should] equal:@"abc"];
                    [[[constantStr stringByReplacingCharactersInRange:NSMakeRange(0, 5) withString:@"abcde"] should] equal:@"abcde World"];
                    
                    [[[string stringByReplacingCharactersInRange:NSMakeRange(0, 3) withString:@"seven"] should] equal:@"seven equal 6"];
                    [[[string stringByReplacingCharactersInRange:NSMakeRange(string.length - 1, 1) withString:@"7"] should] equal:@"six equal 7"];
                    [[[string stringByReplacingCharactersInRange:NSMakeRange(0, string.length) withString:@""] should] equal:emptyStr];
                });
            });
        });
    });
    
    describe(@"when judge hasPrefix or hasSuffix", ^{
        describe(@"and the paramter is nil", ^{
            it(@"should not crash and return NO", ^{
                [[theBlock(^{
                    [[theValue([constantStr hasPrefix:nilStr]) should] beNo];
                    [[theValue([string hasPrefix:nilStr]) should] beNo];
                    [[theValue([constantStr hasSuffix:nilStr]) should] beNo];
                    [[theValue([string hasSuffix:nilStr]) should] beNo];
                }) shouldNot] raiseWithName:NSInvalidArgumentException];
            });
        });
        
        describe(@"and the parameter is valid", ^{
            it(@"should have same behavior as old", ^{
                [[theValue([constantStr hasPrefix:@"Hello"]) should] beYes];
                [[theValue([string hasPrefix:@"six"]) should] beYes];
                [[theValue([constantStr hasPrefix:@"six"]) should] beNo];
                [[theValue([string hasPrefix:@"Hello"]) should] beNo];
                
                [[theValue([constantStr hasSuffix:@"World"]) should] beYes];
                [[theValue([string hasSuffix:@" 6"]) should] beYes];
                [[theValue([constantStr hasSuffix:@" 6"]) should] beNo];
                [[theValue([string hasSuffix:@"World"]) should] beNo];
            });
        });
    });
    
    describe(@"when judge contain string", ^{
        describe(@"and the string is nil", ^{
            it(@"should not crash and return NO", ^{
                [[theBlock(^{
                    [[theValue([constantStr containsString:nilStr]) should] beNo];
                    [[theValue([string containsString:nilStr]) should] beNo];
                    
                    [[theValue([constantStr localizedCaseInsensitiveContainsString:nilStr]) should] beNo];
                    [[theValue([string localizedCaseInsensitiveContainsString:nilStr]) should] beNo];
                }) shouldNot] raiseWithName:NSInvalidArgumentException];
            });
        });
        
        describe(@"and the string is valid", ^{
            it(@"should have same behavior as old", ^{
                [[theValue([constantStr containsString:@"Hello"]) should] beYes];
                [[theValue([constantStr containsString:@"HELLO"]) should] beNo];
                [[theValue([constantStr containsString:@" "]) should] beYes];
                [[theValue([constantStr containsString:@"six"]) should] beNo];
                
                [[theValue([string containsString:@"equal"]) should] beYes];
                [[theValue([string containsString:@"EQUAL"]) should] beNo];
                [[theValue([string containsString:@" "]) should] beYes];
                [[theValue([string containsString:@"World"]) should] beNo];
                
                [[theValue([constantStr localizedCaseInsensitiveContainsString:@"Hello"]) should] beYes];
                [[theValue([constantStr localizedCaseInsensitiveContainsString:@"hello"]) should] beYes];
                [[theValue([constantStr localizedCaseInsensitiveContainsString:@"HELLO"]) should] beYes];
                [[theValue([constantStr localizedCaseInsensitiveContainsString:@"NO"]) should] beNo];
                
                [[theValue([string localizedCaseInsensitiveContainsString:@"equal"]) should] beYes];
                [[theValue([string localizedCaseInsensitiveContainsString:@"EQUAL"]) should] beYes];
                [[theValue([string localizedCaseInsensitiveContainsString:@"EQuaL"]) should] beYes];
                [[theValue([string localizedCaseInsensitiveContainsString:@"YES"]) should] beNo];
            });
        });
    });
    
    describe(@"search a string", ^{
        describe(@"when call 'rangeOfString:'", ^{
            describe(@"and the string is nil", ^{
                it(@"should not crash and return {NSNotFound, 0}", ^{
                    [[theBlock(^{
                        [[theValue([constantStr rangeOfString:nilStr].location) should] equal:theValue(NSNotFound)];
                        [[theValue([string rangeOfString:nilStr].location) should] equal:theValue(NSNotFound)];
                    }) shouldNot] raiseWithName:NSInvalidArgumentException];
                });
            });
            
            describe(@"and the string is valid", ^{
                it(@"should have same behavior as old", ^{
                    [[theValue([constantStr rangeOfString:@"Hello"]) should] equal:theValue(NSMakeRange(0, 5))];
                    [[theValue([constantStr rangeOfString:@"World"]) should] equal:theValue(NSMakeRange(6, 5))];
                    [[theValue([constantStr rangeOfString:@"six"]) should] equal:theValue(NSMakeRange(NSNotFound, 0))];
                    [[theValue([string rangeOfString:@"six"]) should] equal:theValue(NSMakeRange(0, 3))];
                    [[theValue([string rangeOfString:@" 6"]) should] equal:theValue(NSMakeRange(9, 2))];
                    [[theValue([string rangeOfString:@"Hello"]) should] equal:theValue(NSMakeRange(NSNotFound, 0))];
                });
            });
        });
        
        describe(@"when call 'rangeOfString:options:'", ^{
            describe(@"and the string is nil", ^{
                it(@"should not crash and return {NSNotFound, 0}", ^{
                    [[theBlock(^{
                        [constantStr rangeOfString:nilStr options:NSCaseInsensitiveSearch];
                        [string rangeOfString:nilStr options:NSLiteralSearch];
                    }) shouldNot] raiseWithName:NSInvalidArgumentException];
                });
            });
        });
        
        describe(@"when call 'rangeOfString:options:range'", ^{
            describe(@"and the parameters are invalid", ^{
                it(@"should not crash and return {NSNotFound, 0}", ^{
                    [[theBlock(^{
                        [[theValue([constantStr rangeOfString:nilStr options:NSCaseInsensitiveSearch range:NSMakeRange(constantStr.length + 1, 1)]) should] equal:theValue(NSMakeRange(NSNotFound, 0))];
                        [[theValue([constantStr rangeOfString:nilStr options:NSLiteralSearch range:NSMakeRange(0, 1)]) should] equal:theValue(NSMakeRange(NSNotFound, 0))];
                        [[theValue([constantStr rangeOfString:@"Hello" options:NSBackwardsSearch range:NSMakeRange(0, constantStr.length + 2)]) should] equal:theValue(NSMakeRange(NSNotFound, 0))];
                        
                        [[theValue([string rangeOfString:nilStr options:NSCaseInsensitiveSearch range:NSMakeRange(string.length + 1, 1)]) should] equal:theValue(NSMakeRange(NSNotFound, 0))];
                        [[theValue([string rangeOfString:nilStr options:NSLiteralSearch range:NSMakeRange(0, 1)]) should] equal:theValue(NSMakeRange(NSNotFound, 0))];
                        [[theValue([string rangeOfString:@"six" options:NSBackwardsSearch range:NSMakeRange(0, string.length + 2)]) should] equal:theValue(NSMakeRange(NSNotFound, 0))];
                    }) shouldNot] raise];
                });
            });
        });
        
        describe(@"when call 'rangeOfString:options:range:locale:'", ^{
            describe(@"and the parameters are invalid", ^{
                it(@"should not crash and return {NSNotFound, 0}", ^{
                    [[theBlock(^{
                        [[theValue([constantStr rangeOfString:nilStr options:NSCaseInsensitiveSearch range:NSMakeRange(constantStr.length + 1, 1) locale:nil]) should] equal:theValue(NSMakeRange(NSNotFound, 0))];
                        [[theValue([constantStr rangeOfString:nilStr options:NSLiteralSearch range:NSMakeRange(0, 1) locale:nil]) should] equal:theValue(NSMakeRange(NSNotFound, 0))];
                        [[theValue([constantStr rangeOfString:@"Hello" options:NSBackwardsSearch range:NSMakeRange(0, constantStr.length + 2) locale:nil]) should] equal:theValue(NSMakeRange(NSNotFound, 0))];
                        
                        [[theValue([string rangeOfString:nilStr options:NSCaseInsensitiveSearch range:NSMakeRange(string.length + 1, 1) locale:nil]) should] equal:theValue(NSMakeRange(NSNotFound, 0))];
                        [[theValue([string rangeOfString:nilStr options:NSLiteralSearch range:NSMakeRange(0, 1) locale:nil]) should] equal:theValue(NSMakeRange(NSNotFound, 0))];
                        [[theValue([string rangeOfString:@"six" options:NSBackwardsSearch range:NSMakeRange(0, string.length + 2) locale:nil]) should] equal:theValue(NSMakeRange(NSNotFound, 0))];
                    }) shouldNot] raise];
                });
            });
        });
    });
    
    describe(@"search a character in NSCharacterSet", ^{
        NSCharacterSet *nilCharacterSet = nil;
        describe(@"when call 'rangeOfCharacterFromSet:' or 'rangeOfCharacterFromSet:options:'", ^{
            describe(@"and characterSet is nil", ^{
                it(@"should not crash and return {NSNotFound, 0}", ^{
                    [[theBlock(^{
                        [[theValue([constantStr rangeOfCharacterFromSet:nilCharacterSet]) should] equal:theValue(NSMakeRange(NSNotFound, 0))];
                        [[theValue([constantStr rangeOfCharacterFromSet:nilCharacterSet options:NSCaseInsensitiveSearch]) should] equal:theValue(NSMakeRange(NSNotFound, 0))];
                        
                        [[theValue([string rangeOfCharacterFromSet:nilCharacterSet]) should] equal:theValue(NSMakeRange(NSNotFound, 0))];
                        [[theValue([string rangeOfCharacterFromSet:nilCharacterSet options:NSForcedOrderingSearch]) should] equal:theValue(NSMakeRange(NSNotFound, 0))];
                    }) shouldNot] raiseWithName:NSInvalidArgumentException];
                });
            });
        });
        
        describe(@"when call 'rangeOfCharacterFromSet:options:range:'", ^{
            describe(@"and parameters are invalid", ^{
                it(@"should not crash and return {NSNotFound, 0}", ^{
                    [[theBlock(^{
                        [[theValue([constantStr rangeOfCharacterFromSet:nilCharacterSet options:0 range:NSMakeRange(constantStr.length + 1, 1)]) should] equal:theValue(NSMakeRange(NSNotFound, 0))];
                        [[theValue([constantStr rangeOfCharacterFromSet:nilCharacterSet options:0 range:NSMakeRange(0, constantStr.length)]) should] equal:theValue(NSMakeRange(NSNotFound, 0))];
                        [[theValue([constantStr rangeOfCharacterFromSet:[NSCharacterSet whitespaceAndNewlineCharacterSet] options:0 range:NSMakeRange(constantStr.length + 1, 1)]) should] equal:theValue(NSMakeRange(NSNotFound, 0))];

                        [[theValue([string rangeOfCharacterFromSet:nilCharacterSet options:0 range:NSMakeRange(string.length + 1, 1)]) should] equal:theValue(NSMakeRange(NSNotFound, 0))];
                        [[theValue([string rangeOfCharacterFromSet:nilCharacterSet options:0 range:NSMakeRange(0, string.length)]) should] equal:theValue(NSMakeRange(NSNotFound, 0))];
                        [[theValue([string rangeOfCharacterFromSet:[NSCharacterSet whitespaceAndNewlineCharacterSet] options:0 range:NSMakeRange(string.length + 1, 1)]) should] equal:theValue(NSMakeRange(NSNotFound, 0))];
                    }) shouldNot] raise];
                });
            });
        });
    });
    
    describe(@"get rang of composed character sequence when call 'rangeOfComposedCharacterSequenceAtIndex:'", ^{
        describe(@"and the index is out of range", ^{
            it(@"should not crash and return {NSNotFound, 0}", ^{
                [[theBlock(^{
                    [[theValue([constantStr rangeOfComposedCharacterSequenceAtIndex:constantStr.length]) should] equal:theValue(NSMakeRange(NSNotFound, 0))];
                    [[theValue([string rangeOfComposedCharacterSequenceAtIndex:string.length]) should] equal:theValue(NSMakeRange(NSNotFound, 0))];
                }) shouldNot] raiseWithName:NSInvalidArgumentException];
            });
        });
        
        describe(@"and the parameter is valid", ^{
            it(@"should have samve behavior as old", ^{
                [[theValue([constantStr rangeOfComposedCharacterSequenceAtIndex:1]) should] equal:theValue(NSMakeRange(1, 1))];
                [[theValue([string rangeOfComposedCharacterSequenceAtIndex:string.length - 1]) should] equal:theValue(NSMakeRange(string.length - 1, 1))];
                
                NSString *testStr = @"Hello, it's sunny. 😁";
                [[theValue([testStr rangeOfComposedCharacterSequenceAtIndex:testStr.length - 1]) shouldNot] equal:theValue(NSMakeRange(testStr.length - 1, 1))];
                [[theValue([testStr rangeOfComposedCharacterSequenceAtIndex:testStr.length - 1]) shouldNot] equal:theValue(NSMakeRange(NSNotFound, 0))];
            });
        });
    });
    
    describe(@"get a new string by appending a string", ^{
        describe(@"when call 'stringByAppendingString:'", ^{
            describe(@"and the string is nil", ^{
                it(@"should not crash and return nil", ^{
                    [[theBlock(^{
                        [[[constantStr stringByAppendingString:nilStr] should] beNil];
                        [[[string stringByAppendingString:nilStr] should] beNil];
                    }) shouldNot] raiseWithName:NSInvalidArgumentException];
                });
            });
            
            describe(@"and the string is valid", ^{
                it(@"should have samve behavior as old", ^{
                    [[[constantStr stringByAppendingString:string] should] equal:[NSString stringWithFormat:@"%@%@", constantStr, string]];
                    [[[string stringByAppendingString:constantStr] should] equal:[NSString stringWithFormat:@"%@%@", string, constantStr]];
                    
                    [[[constantStr stringByAppendingString:emptyStr] should] equal:constantStr];
                    [[[string stringByAppendingString:emptyStr] should] equal:string];
                });
            });
        });
        
//        describe(@"when call 'stringByAppendingFormat:'", ^{
//            describe(@"and the format is nil", ^{
//                it(@"should not crash and return nil", ^{
//                    [[theBlock(^{
//                        [[[constantStr stringByAppendingFormat:nilStr] should] beNil];
//                        [[[string stringByAppendingFormat:nilStr] should] beNil];
//                    }) shouldNot] raiseWithName:NSInvalidArgumentException];
//                });
//            });
//            
//            describe(@"and format is valid", ^{
//                it(@"should have samve behavior as old", ^{
//                    [[[constantStr stringByAppendingFormat:@"%@" ,emptyStr] should] equal:constantStr];
//                    [[[constantStr stringByAppendingFormat:@"%@", string] should] equal:[NSString stringWithFormat:@"%@%@", constantStr, string]];
//                    
//                    [[[string stringByAppendingFormat:@"%@", emptyStr] should] equal:string];
//                    [[[string stringByAppendingFormat:@"%@", constantStr] should] equal:[NSString stringWithFormat:@"%@%@", string, constantStr]];
//                });
//            });
//        });
    });
});

SPEC_END
