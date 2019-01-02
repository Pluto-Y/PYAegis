//
//  NSMutableArrayTests.m
//  PYCrashGuardTests
//
//  Created by Pluto-Y on 2018/12/1.
//  Copyright © 2018 pluto-y. All rights reserved.
//

#import "Kiwi.h"

SPEC_BEGIN(NSMutableArrayTests)

context(@"NSMutableArray", ^{
    NSMutableArray *mutableArray = [NSMutableArray new];
    NSObject *nilObj = nil;
    NSIndexSet *nilIndexSet = nil;
    
    afterEach(^{
        [mutableArray removeAllObjects];
    });
    
    describe(@"when insert an object at index", ^{
        // addObject: dependent on insertObject:atIndex
        describe(@"when add a nil object", ^{
            it(@"should not crash", ^{
                [[theBlock(^{
                    [mutableArray addObject:nilObj];
                }) shouldNot] raiseWithName:NSInvalidArgumentException];
            });
        });

        describe(@"and the object is nilObj", ^{
            it(@"should not crash", ^{
                [[theBlock(^{
                    [[theValue(mutableArray.count) should] beZero];
                    [mutableArray insertObject:nilObj atIndex:0];
                }) shouldNot] raiseWithName:NSInvalidArgumentException];
            });
        });
        
        describe(@"and the index is out of the range", ^{
            it(@"should not crash", ^{
                [[theBlock(^{
                    [mutableArray insertObject:[NSObject new] atIndex:1];
                    [mutableArray insertObject:[NSObject new] atIndex:0];
                    [mutableArray insertObject:[NSObject new] atIndex:2];
                }) shouldNot] raiseWithName:NSRangeException];
            });
        });
    });
    
    describe(@"when replace object at index", ^{
        describe(@"and new object is nil", ^{
            it(@"should not crash", ^{
                [[theBlock(^{
                    [mutableArray replaceObjectAtIndex:1 withObject:nilObj];
                    [mutableArray replaceObjectAtIndex:0 withObject:nilObj];
                }) shouldNot] raiseWithName:NSInvalidArgumentException];
            });
        });
        
        describe(@"and the index is out of range", ^{
            it(@"should not crash", ^{
                [[theBlock(^{
                    [mutableArray replaceObjectAtIndex:1 withObject:[NSObject new]];
                    [mutableArray addObject:[NSObject new]];
                    [mutableArray replaceObjectAtIndex:2 withObject:[NSObject new]];
                }) shouldNot] raiseWithName:NSRangeException];
            });
        });
    });
    
    describe(@"when exchange two element", ^{
        describe(@"and the parameters are invalidate", ^{
            it(@"should not crash", ^{
                [[theBlock(^{
                    [mutableArray exchangeObjectAtIndex:1 withObjectAtIndex:0];
                    [mutableArray exchangeObjectAtIndex:0 withObjectAtIndex:1];
                    [mutableArray exchangeObjectAtIndex:1 withObjectAtIndex:1];
                    [mutableArray addObject:[NSObject new]];
                    [mutableArray exchangeObjectAtIndex:2 withObjectAtIndex:1];
                    [mutableArray exchangeObjectAtIndex:1 withObjectAtIndex:2];
                    [mutableArray exchangeObjectAtIndex:2 withObjectAtIndex:2];
                }) shouldNot] raiseWithName:NSRangeException];
            });
        });
        
        describe(@"and the parameter are valid", ^{
            it(@"should have same behavior as old", ^{
                [[theBlock(^{
                    [mutableArray addObject:@1];
                    [mutableArray addObject:@2];
                    [mutableArray addObject:@3];
                    [mutableArray exchangeObjectAtIndex:0 withObjectAtIndex:2];
                    [[mutableArray should] equal:[@[@3, @2, @1] mutableCopy]];
                }) shouldNot] raise];
            });
        });
    });
    
    describe(@"when remove all objects in range", ^{
        // removeObjectAtIndex: dependent on removeObjectsInRange:
        describe(@"and remove object at index and index out of range", ^{
            it(@"should not crash", ^{
                [[theBlock(^{
                    [mutableArray removeObjectAtIndex:0];
                    [mutableArray addObject:@1];
                    [mutableArray removeObjectAtIndex:1];
                }) shouldNot] raiseWithName:NSRangeException];
            });
        });
        
        describe(@"and the parameters are invalidate", ^{
            it(@"should not crash", ^{
                [[theBlock(^{
                    [mutableArray removeObjectsInRange:NSMakeRange(0, 1)];
                    [mutableArray addObject:@1];
                    [mutableArray removeObjectsInRange:NSMakeRange(2, 3)];
                }) shouldNot] raiseWithName:NSRangeException];
            });
        });
        
        describe(@"and the parameters are valid", ^{
           it(@"should have same behavior as old", ^{
               [[theBlock(^{
                   NSMutableArray *result1 = [NSMutableArray new];
                   NSMutableArray *result2 = [NSMutableArray new];
                   NSMutableArray *result3 = [NSMutableArray new];
                   for (int i = 0 ; i < 50; i ++) {
                       if (i < 10) {
                           [result2 addObject:@(i)];
                           [result3 addObject:@(i)];
                       } else if (i >= 20 && i < 30) {
                           [result1 addObject:@(i)];
                           [result3 addObject:@(i)];
                       } else if (i >= 40) {
                           [result1 addObject:@(i)];
                           [result2 addObject:@(i)];
                       } else {
                           [result1 addObject:@(i)];
                           [result2 addObject:@(i)];
                           [result3 addObject:@(i)];
                       }
                       [mutableArray addObject:@(i)];
                   }
                   
                   NSMutableArray *mutableArray1 = [mutableArray mutableCopy];
                   [mutableArray1 removeObjectsInRange:NSMakeRange(0, 10)];
                   [[mutableArray1 should] equal:result1];
                   NSMutableArray *mutableArray2 = [mutableArray mutableCopy];
                   [mutableArray2 removeObjectsInRange:NSMakeRange(20, 10)];
                   [[mutableArray2 should] equal:result2];
                   NSMutableArray *mutableArray3 = [mutableArray mutableCopy];
                   [mutableArray3 removeObjectsInRange:NSMakeRange(40, 10)];
                   [[mutableArray3 should] equal:result3];
                   
               }) shouldNot] raise];
           });
        });
    });
    
    describe(@"when remove object in range", ^{
        describe(@"and the parameters are invalidate", ^{
            it(@"should not crash", ^{
                [[theBlock(^{
                    [mutableArray removeObject:nilObj inRange:NSMakeRange(0, 1)];
                    [mutableArray addObject:[NSObject new]];
                    [mutableArray removeObject:nilObj inRange:NSMakeRange(0, 2)];
                }) shouldNot] raiseWithName:NSRangeException];
            });
        });
        
        describe(@"and the parameters are valid", ^{
            it(@"should have same behavior as old", ^{
                [mutableArray addObject:@1];
                [mutableArray addObject:@2];
                [mutableArray addObject:@3];
                [mutableArray removeObject:@4 inRange:NSMakeRange(0, mutableArray.count)];
                [[mutableArray should] equal:mutableArray];
                [mutableArray removeObject:@2 inRange:NSMakeRange(0, mutableArray.count)];
                [[mutableArray should] equal:[@[@1, @3] mutableCopy]];
            });
        });
    });
    
    describe(@"when remove object by address in range", ^{
        describe(@"and the parameters are invalidate", ^{
            it(@"should not crash", ^{
                [[theBlock(^{
                    [mutableArray removeObjectIdenticalTo:nilObj inRange:NSMakeRange(0, 2)];
                    [mutableArray addObject:@1];
                    [mutableArray removeObjectIdenticalTo:nilObj inRange:NSMakeRange(0, 2)];
                }) shouldNot] raiseWithName:NSRangeException];
            });
        });
        
        describe(@"and the parameters are valid", ^{
            it(@"should have same behavior as old", ^{
                NSObject *obj1 = [NSObject new];
                NSObject *obj2 = [NSObject new];
                NSObject *obj3 = [NSObject new];
                [mutableArray addObject:obj1];
                [mutableArray addObject:obj2];
                [mutableArray addObject:obj3];
                [mutableArray removeObjectIdenticalTo:obj1 inRange:NSMakeRange(0, mutableArray.count)];
                [[mutableArray should] equal:[@[obj2, obj3] mutableCopy]];
                [mutableArray insertObject:obj1 atIndex:0];
                [mutableArray removeObjectIdenticalTo:[NSObject new] inRange:NSMakeRange(0, mutableArray.count)];
                [[mutableArray should] equal:[@[obj1, obj2, obj3] mutableCopy]];
            });
        });
    });
    
    describe(@"when replace objects in range with objects in array", ^{
        describe(@"and the parameters are invalidate", ^{
            it(@"should not crash", ^{
#warning "consider whether it has more test cases"
                [[theBlock(^{
                    [mutableArray replaceObjectsInRange:NSMakeRange(0, 1) withObjectsFromArray:@[@(0)]];
                    [mutableArray addObject:@2];
                    [mutableArray replaceObjectsInRange:NSMakeRange(0, 2) withObjectsFromArray:@[@0]];
                }) shouldNot] raiseWithName:NSRangeException];
            });
        });
        
        describe(@"and the parameters are valid", ^{
            it(@"should have same behavior as old", ^{
                [mutableArray addObject:@1];
                [mutableArray addObject:@2];
                [mutableArray addObject:@3];
                [mutableArray replaceObjectsInRange:NSMakeRange(0, 3) withObjectsFromArray:@[@3, @2, @1]];
                [[mutableArray should] equal:[@[@3, @2, @1] mutableCopy]];
                [mutableArray replaceObjectsInRange:NSMakeRange(1, 2) withObjectsFromArray:@[@4, @5]];
                [[mutableArray should] equal:[@[@3, @4, @5] mutableCopy]];
            });
        });
    });
    
    describe(@"when replace objects in range with objects of array in range", ^{
        describe(@"and the parameters are invalidate", ^{
            it(@"should not crash", ^{
                [[theBlock(^{
                    [mutableArray replaceObjectsInRange:NSMakeRange(0, 1) withObjectsFromArray:@[@(0)] range:NSMakeRange(0, 1)];
                    [mutableArray replaceObjectsInRange:NSMakeRange(0, 0) withObjectsFromArray:@[] range:NSMakeRange(0, 1)];
                    
                    [mutableArray addObject:@(1)];
                    [mutableArray replaceObjectsInRange:NSMakeRange(0, 2) withObjectsFromArray:@[@(0)] range:NSMakeRange(0, 1)];
                    [mutableArray replaceObjectsInRange:NSMakeRange(0, 1) withObjectsFromArray:@[@(0)] range:NSMakeRange(0, 2)];
                }) shouldNot] raiseWithName:NSRangeException];
            });
        });
        
        describe(@"and the parameters are valid", ^{
            it(@"should have same behavior as old", ^{
                [mutableArray addObject:@1];
                [mutableArray addObject:@2];
                [mutableArray addObject:@3];
                [mutableArray replaceObjectsInRange:NSMakeRange(2, 1) withObjectsFromArray:@[@4, @5, @6] range:NSMakeRange(0, 2)];
                [[mutableArray should] equal:[@[@1, @2, @4, @5] mutableCopy]];
            });
        });
    });
    
    describe(@"when insert object at indexes", ^{
        describe(@"parameters are invalidate", ^{
            describe(@"and indexes is a nil object", ^{
                it(@"should not crash", ^{
                    [[theBlock(^{
                        [mutableArray insertObjects:@[@(1)] atIndexes:nilIndexSet];
                    }) shouldNot] raiseWithName:NSInvalidArgumentException];
                });
            });
            
            describe(@"and indexes is out of range", ^{
                it(@"should not crash", ^{
                    [[theBlock(^{
                        [mutableArray insertObjects:@[@(1)] atIndexes:[NSIndexSet indexSetWithIndex:1]];
                        [mutableArray insertObjects:@[@(1)] atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 2)]];
                        
                        [mutableArray addObject:@(2)];
                        [mutableArray addObject:@(3)];
                        [mutableArray insertObjects:@[@8] atIndexes:[NSIndexSet indexSetWithIndex:10]];
                        [mutableArray insertObjects:@[@(1)] atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 2)]]; // ?? NSInvalidArgumentException?
                    }) shouldNot] raiseWithName:NSRangeException];
                });
            });
        });
        
        describe(@"and the parameters are valid", ^{
            it(@"should have same behavior as old", ^{
                [mutableArray insertObjects:@[@1, @2, @3] atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 3)]];
                [[mutableArray should] equal:[@[@1, @2, @3] mutableCopy]];
                [mutableArray insertObjects:@[@4, @5, @6] atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(3, 3)]];
                [[mutableArray should] equal:[@[@1, @2, @3, @4, @5, @6] mutableCopy]];
            });
        });
    });
    
    describe(@"when remove objects at indexes", ^{
        describe(@"parameters are invalidate", ^{
            describe(@"and the indexes is a nil object", ^{
                it(@"should not crash", ^{
                    [[theBlock(^{
                        [mutableArray removeObjectsAtIndexes:nilIndexSet];
                    }) shouldNot] raiseWithName:NSInvalidArgumentException];
                });
            });
            
            describe(@"and the indexes is out of range", ^{
                it(@"should not crash", ^{
                    [[theBlock(^{
                        [mutableArray removeObjectsAtIndexes:[NSIndexSet indexSet]];
                        [mutableArray removeObjectsAtIndexes:[NSIndexSet indexSetWithIndex:0]];
                        [mutableArray removeObjectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 1)]];
                        
                        [mutableArray addObject:@(1)];
                        [mutableArray removeObjectsAtIndexes:[NSIndexSet indexSetWithIndex:1]];
                        [mutableArray removeObjectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 2)]];
                    }) shouldNot] raiseWithName:NSRangeException];
                });
            });
        });
        
        describe(@"and the parameters are valid", ^{
            it(@"should have same behavior as old", ^{
                [mutableArray addObject:@1];
                [mutableArray addObject:@2];
                [mutableArray addObject:@3];
                [mutableArray removeObjectsAtIndexes:[NSIndexSet indexSetWithIndex:1]];
                [[mutableArray should] equal:[@[@1, @3] mutableCopy]];
                [mutableArray insertObject:@2 atIndex:1];
                [mutableArray removeObjectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(2, 1)]];
                [[mutableArray should] equal:[@[@1, @2] mutableCopy]];
            });
        });
    });
    
    describe(@"when replace object at indexes with objects", ^{
#warning "replaceObjectsAtIndexes_withObjects"
    });
    
    describe(@"when set objects at indexedSubscript", ^{
#warning "setObject_atIndexedSubscript"
    });
    
});

SPEC_END
