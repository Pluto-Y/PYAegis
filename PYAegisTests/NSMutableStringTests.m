//
//  NSMutableStringTests.m
//  PYAegisTests
//
//  Created by linhuijie on 2018/12/24.
//  Copyright © 2018年 pluto-y. All rights reserved.
//

#import "Kiwi.h"

SPEC_BEGIN(NSMutableStringTests)

context(@"NSMutableString", ^{
    NSMutableString *__NSCFString = [NSMutableString string];
    NSMutableString *NSPlaceholderMutableString = [NSMutableString alloc];
    NSString *nilStr      = nil;
    NSString *constantStr = @"Hello World";
    NSRange inRange       = NSMakeRange(1, 1);
    NSRange outRange      = NSMakeRange(-1, 0);
    
    // length
    describe(@"get length from 'NSPlaceholderMutableString'", ^{
        it(@"should not crash", ^{
            [[theBlock(^{
                [[theValue(NSPlaceholderMutableString.length) should] beZero];
            }) shouldNot] raiseWithName:NSInvalidArgumentException];
        });
    });
    
    // appendString:
    describe(@"when appendString", ^{
        describe(@"with nil value", ^{
            it(@"should not crash", ^{
                [[theBlock(^{
                    [__NSCFString appendString:nilStr];
                }) shouldNot] raiseWithName:NSInvalidArgumentException];
            });
        });
        
        describe(@"with normal value", ^{
            it(@"should have same behavior as old", ^{
                [[theBlock(^{
                    [__NSCFString appendString:constantStr];
                    [[__NSCFString should] equal:constantStr];
                }) shouldNot] raiseWithName:NSInvalidArgumentException];
            });
        });
    });
    
    // insertString:
    describe(@"when insertString", ^{
        describe(@"with nil string", ^{
            describe(@"and in range", ^{
                it(@"shoud not crash and nothing to insert", ^{
                    [[theBlock(^{
                        [__NSCFString insertString:nilStr atIndex:0];
                    }) shouldNot] raiseWithName:NSInvalidArgumentException];
                });
            });
            
            describe(@"and out range", ^{
                it(@"shoud not crash and nothing to insert", ^{
                    [[theBlock(^{
                        [__NSCFString insertString:nilStr atIndex:-1];
                    }) shouldNot] raiseWithName:NSInvalidArgumentException];
                });
            });
        });
        
        describe(@"with normal string", ^{
            describe(@"and in range", ^{
                it(@"should have same behavior as old", ^{
                    [[theBlock(^{
                        [__NSCFString insertString:constantStr atIndex:0];
                    }) shouldNot] raiseWithName:NSInvalidArgumentException];
                });
            });
            
            describe(@"and out range", ^{
                it(@"shoud not crash and nothing to insert", ^{
                    [[theBlock(^{
                        [__NSCFString insertString:constantStr atIndex:-1];
                    }) shouldNot] raiseWithName:NSInvalidArgumentException];
                });
            });
        });
    });
    
    // deleteCharactersInRange:
    describe(@"when deleteCharactersInRange", ^{
        describe(@"with in range", ^{
            it(@"should have same behavior as old", ^{
                [[theBlock(^{
                    [__NSCFString setString:constantStr];
                    [__NSCFString deleteCharactersInRange:inRange];
                    [[__NSCFString should] equal:@"Hllo World"];
                }) shouldNot] raiseWithName:NSInvalidArgumentException];
            });
        });
        
        describe(@"with out range", ^{
            it(@"should not crash and nothing to delete", ^{
                [[theBlock(^{
                    [__NSCFString setString:constantStr];
                    [__NSCFString deleteCharactersInRange:outRange];
                    [[__NSCFString should] equal:constantStr];
                }) shouldNot] raiseWithName:NSInvalidArgumentException];
            });
        });
    });
    
    // setString:
    describe(@"when setString", ^{
        describe(@"with nil value", ^{
            it(@"should not crash", ^{
                [[theBlock(^{
                    [__NSCFString setString:nilStr];
                }) shouldNot] raiseWithName:NSInvalidArgumentException];
            });
        });
        
        describe(@"with normal value", ^{
            it(@"should have same behavior as old", ^{
                [[theBlock(^{
                    [__NSCFString setString:constantStr];
                    [[__NSCFString should] equal:constantStr];
                }) shouldNot] raiseWithName:NSInvalidArgumentException];
            });
        });
    });
    
    // replaceCharactersInRange:withString:
    describe(@"when replace Characters In Range with String", ^{
        describe(@"with in range", ^{
            describe(@"and nil value", ^{
                it(@"should not crash and nothing to replace", ^{
                    [[theBlock(^{
                        [__NSCFString setString:constantStr];
                        [__NSCFString replaceCharactersInRange:inRange withString:nilStr];
                        [[__NSCFString should] equal:__NSCFString];
                    }) shouldNot] raiseWithName:NSInvalidArgumentException];
                });
            });
            
            describe(@"with normal value", ^{
                it(@"should have same behavior as old", ^{
                    [[theBlock(^{
                        [__NSCFString setString:constantStr];
                        [__NSCFString replaceCharactersInRange:inRange withString:constantStr];
                        [[__NSCFString should] equal:@"HHello Worldllo World"];
                    }) shouldNot] raiseWithName:NSInvalidArgumentException];
                });
            });
        });
        
        describe(@"with out range", ^{
            describe(@"with nil value", ^{
                it(@"should not crash and nothing to replace", ^{
                    [[theBlock(^{
                        [__NSCFString setString:constantStr];
                        [__NSCFString replaceCharactersInRange:outRange withString:nilStr];
                        [[__NSCFString should] equal:__NSCFString];
                    }) shouldNot] raiseWithName:NSInvalidArgumentException];
                });
            });
            
            describe(@"with normal value", ^{
                it(@"should not crash and nothing to replace", ^{
                    [[theBlock(^{
                        [__NSCFString setString:constantStr];
                        [__NSCFString replaceCharactersInRange:outRange withString:constantStr];
                        [[__NSCFString should] equal:__NSCFString];
                    }) shouldNot] raiseWithName:NSInvalidArgumentException];
                });
            });
        });
    });
    
    // replaceOccurrencesOfString:withString:options:range:
    describe(@"when replace Occurrences Of String with String in range", ^{
        describe(@"with target string is nil", ^{
            describe(@"and replacement string is nil", ^{
                
                describe(@"and in range", ^{
                    it(@"should not crash and return 0", ^{
                        [[theBlock(^{
                            [__NSCFString setString:constantStr];
                            [[theValue([__NSCFString replaceOccurrencesOfString:nilStr withString:nilStr options:0 range:inRange]) should] beZero];
                        }) shouldNot] raiseWithName:NSInvalidArgumentException];
                    });
                });
                
                describe(@"and out range", ^{
                    it(@"should not crash and return 0", ^{
                        [[theBlock(^{
                            [__NSCFString setString:constantStr];
                            [[theValue([__NSCFString replaceOccurrencesOfString:nilStr withString:nilStr options:0 range:outRange]) should] beZero];
                        }) shouldNot] raiseWithName:NSInvalidArgumentException];
                    });
                });
            });
            
            describe(@"and replacement string is normal", ^{
                describe(@"and in range", ^{
                    it(@"should not crash and return 0", ^{
                        [[theBlock(^{
                            [__NSCFString setString:constantStr];
                            [[theValue([__NSCFString replaceOccurrencesOfString:nilStr withString:constantStr options:0 range:inRange]) should] beZero];
                        }) shouldNot] raiseWithName:NSInvalidArgumentException];
                    });
                });
                
                describe(@"and out range", ^{
                    it(@"should not crash and return 0", ^{
                        [[theBlock(^{
                            [__NSCFString setString:constantStr];
                            [[theValue([__NSCFString replaceOccurrencesOfString:nilStr withString:constantStr options:0 range:outRange]) should] beZero];
                        }) shouldNot] raiseWithName:NSInvalidArgumentException];
                    });
                });
            });
        });
        
        describe(@"with target string is normal", ^{
            describe(@"and replacement string is nil", ^{
                
                describe(@"and in range", ^{
                    it(@"should not crash and return 0", ^{
                        [[theBlock(^{
                            [__NSCFString setString:constantStr];
                            [[theValue([__NSCFString replaceOccurrencesOfString:constantStr withString:nilStr options:0 range:inRange]) should] beZero];
                        }) shouldNot] raiseWithName:NSInvalidArgumentException];
                    });
                });
                
                describe(@"and out range", ^{
                    it(@"should not crash and return 0", ^{
                        [[theBlock(^{
                            [__NSCFString setString:constantStr];
                            [[theValue([__NSCFString replaceOccurrencesOfString:constantStr withString:nilStr options:0 range:outRange]) should] beZero];
                        }) shouldNot] raiseWithName:NSInvalidArgumentException];
                    });
                });
            });
            
            describe(@"and replacement string is normal", ^{
                describe(@"and in range", ^{
                    it(@"should have same behavior as old", ^{
                        [[theBlock(^{
                            [__NSCFString setString:constantStr];
                            [[theValue([__NSCFString replaceOccurrencesOfString:@"e" withString:@"1" options:0 range:inRange]) should] equal:@(1)];
                        }) shouldNot] raiseWithName:NSInvalidArgumentException];
                    });
                });
                
                describe(@"and out range", ^{
                    it(@"should not crash and return 0", ^{
                        [[theBlock(^{
                            [__NSCFString setString:constantStr];
                            [[theValue([__NSCFString replaceOccurrencesOfString:constantStr withString:constantStr options:0 range:outRange]) should] beZero];
                        }) shouldNot] raiseWithName:NSInvalidArgumentException];
                    });
                });
            });
        });
    });
    
    // initWithCapacity:
    describe(@"when initWithCapacity", ^{
        describe(@"and the method has implement", ^{
            it(@"should have same behavior as old", ^{
                [[theBlock(^{
                    [[[NSPlaceholderMutableString initWithCapacity:1] shouldNot] beNil];
                }) shouldNot] raiseWithName:NSInvalidArgumentException];
            });
        });
        
        describe(@"and the method has not implement", ^{
            it(@"should not crash and return nil", ^{
                [[theBlock(^{
                    [[[__NSCFString initWithCapacity:1] should] beNil];
                }) shouldNot] raiseWithName:NSInvalidArgumentException];
            });
        });
    });
});

SPEC_END
