//
//  NSObject+KVOCrash.m
//  PYAegis
//
//  Created by Pluto-Y on 2018/9/30.
//  Copyright © 2018 pluto-y. All rights reserved.
//

#import "NSObject+KVOCrash.h"
#import "NSObject+MethodSwizzling.h"
#import <objc/runtime.h>

@interface __PYAKVOInfo : NSObject

@property (nonatomic, copy) NSString *keyPath;
@property (nonatomic, weak) id observer;
@property (nonatomic, assign) void *context;

- (instancetype)initWithKeyPath:(NSString *)keyPath observer:(id)observer context:(void *)context;

@end

@interface __PYAKVODelegate : NSObject

@property (nonatomic, unsafe_unretained) id observeredObj;
@property (nonatomic, strong) NSMapTable<NSString *, NSMutableSet<__PYAKVOInfo *> *> *keyPathToInfos;

- (instancetype)initWithObserveredObj:(id)observerObj;

- (void)addKVOInfo:(__PYAKVOInfo *)info forOptions:(NSKeyValueObservingOptions)options;
- (void)removeKVOInfo:(__PYAKVOInfo *)info;
- (void)randomRemoveKVOInfoForKeyPath:(NSString *)keyPath observer:(id)observer;
- (void)removeAllObserver;

@end

@interface NSObject()

@property (nonatomic, strong) __PYAKVODelegate *pya_delegate;

@end

@implementation NSObject (KVOCrash)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self methodSwizzleForInstanceFrom:@selector(addObserver:forKeyPath:options:context:) to:@selector(pya_addObserver:forKeyPath:options:context:)];
        [self methodSwizzleForInstanceFrom:@selector(removeObserver:forKeyPath:context:) to:@selector(pya_removeObserver:forKeyPath:context:)];
        [self methodSwizzleForInstanceFrom:@selector(removeObserver:forKeyPath:) to:@selector(pya_removeObserver:forKeyPath:)];
    });
}

- (void)pya_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context {
    [[self createDelegateIfNeeded] addKVOInfo:[[__PYAKVOInfo alloc] initWithKeyPath:keyPath observer:observer context:context] forOptions:options];
}

- (void)pya_removeObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath context:(void *)context {
    [[self createDelegateIfNeeded] removeKVOInfo:[[__PYAKVOInfo alloc] initWithKeyPath:keyPath observer:observer context:context]];
}

- (void)pya_removeObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath {
    for (NSString *functionSymbols in [NSThread callStackSymbols]) {
        if ([functionSymbols rangeOfString:@"removeObserver:forKeyPath:context:"].location != NSNotFound) {
            // Ignore if the caller is from 'pya_removeObserver:forKeyPath:context:'
            // NSLog(@">>>>>>>>>> Call from 'pya_removeObserver:forKeyPath:context:', so call origin implementation... <<<<<<<<<<");
            return [self pya_removeObserver:observer forKeyPath:keyPath];
        }
    }
    
    [[self createDelegateIfNeeded] randomRemoveKVOInfoForKeyPath:keyPath observer:observer];
}

- (__PYAKVODelegate * _Nonnull)createDelegateIfNeeded {
    __block __PYAKVODelegate *pya_delegate = nil;
    @synchronized (self) {
        pya_delegate = objc_getAssociatedObject(self, @selector(pya_delegate));
        if (pya_delegate == nil) {
            pya_delegate = [[__PYAKVODelegate alloc] initWithObserveredObj:self];
            self.pya_delegate = pya_delegate;
        }
    }
    return pya_delegate;
}

- (__PYAKVODelegate *)pya_delegate {
    return objc_getAssociatedObject(self, @selector(pya_delegate));
}

- (void)setPycg_delegate:(__PYAKVODelegate *)pya_delegate {
    objc_setAssociatedObject(self, @selector(pya_delegate), pya_delegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

@implementation __PYAKVOInfo

- (instancetype)initWithKeyPath:(NSString *)keyPath observer:(id)observer context:(void *)context {
    NSParameterAssert(observer != nil);
    NSParameterAssert(keyPath != nil);
    self = [super init];
    if (self) {
        _keyPath = [keyPath copy];
        _observer = observer;
        _context = context;
    }
    return self;
}

- (NSUInteger)hash {
    return self.keyPath.hash;
}

- (BOOL)isEqualToKVOInfo:(__PYAKVOInfo *)info {
    return [info.keyPath isEqualToString:self.keyPath] && info.context == self.context && ((info.observer == nil && self.observer == nil) || [info.observer isEqual:self.observer]);
}

- (BOOL)isEqual:(id)object {
    if (object == self) return YES;
    if (![object isKindOfClass:[self class]]) return NO;
    
    __PYAKVOInfo *info = (__PYAKVOInfo *)object;
    return [self isEqualToKVOInfo:info];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"KVOInfo{observer: %@, keyPath: %@, context: %p}", _observer, _keyPath, _context];
}

@end

@implementation __PYAKVODelegate

- (instancetype)initWithObserveredObj:(id)observerObj
{
    self = [super init];
    if (self) {
        _observeredObj = observerObj;
        _keyPathToInfos = [NSMapTable strongToStrongObjectsMapTable];
    }
    return self;
}

- (void)dealloc {
    NSLog(@"__PYAKVODelegate dealloc");
    [self removeAllObserver];
    self.observeredObj = nil;
}

- (void)addKVOInfo:(__PYAKVOInfo *)info forOptions:(NSKeyValueObservingOptions)options {
    NSMutableSet *infos = [_keyPathToInfos objectForKey:info.keyPath];
    if (infos == nil) {
        infos = [NSMutableSet new];
        [infos addObject:info];
        [self.observeredObj pya_addObserver:self forKeyPath:info.keyPath options:options context:info.context];
        [_keyPathToInfos setObject:infos forKey:info.keyPath];
        return;
    }
    
    BOOL notInDic = YES; //
    NSHashTable *tmp = [infos copy];
    for (__PYAKVOInfo *i in tmp) {
        if (notInDic && [i isEqual:info]) {
            NSLog(@">>>>>>>>>> Duplicate add the observer: %@ forKeyPath: %@ context: %p <<<<<<<<<<", info.observer, info.keyPath, info.context);
            NSLog(@">>>>>>>>>> the call stack: <<<<<<<<<<\n%@", [NSThread callStackSymbols]);
            notInDic = NO;
        }
        
        [self checkKVOInfo:i inInfos:infos];
    }
    
    if (notInDic) {
        [infos addObject:info];
        [self.observeredObj pya_addObserver:self forKeyPath:info.keyPath options:options context:info.context];
    }
}

- (void)removeKVOInfo:(__PYAKVOInfo *)info {
    NSMutableSet *infos = [_keyPathToInfos objectForKey:info.keyPath];
    if (infos == nil) { // If remove a keyPath which had not been registered
        NSLog(@">>>>>>>>>> Remove unregistered forKeyPath: %@ <<<<<<<<<", info.keyPath);
        NSLog(@">>>>>>>>>> the call stack: <<<<<<<<<<\n%@", [NSThread callStackSymbols]);
        return ;
    }
    
    BOOL isInDic = NO;
    NSHashTable *tmp = [infos copy];
    for (__PYAKVOInfo *i in tmp) {
        if (!isInDic && [i isEqual:info]) {
            isInDic = YES;
            [self.observeredObj pya_removeObserver:self forKeyPath:info.keyPath context:info.context];
            [infos removeObject:i];
        }
        
        [self checkKVOInfo:i inInfos:infos];
    }
    
    if (infos.count == 0) {
        [_keyPathToInfos removeObjectForKey:info.keyPath];
    }
    
    if (!isInDic) {
        NSLog(@">>>>>>>>>> Remove unregistered observer: %@ forKeyPath: %@ context: %p <<<<<<<<<", info.observer, info.keyPath, info.context);
        NSLog(@">>>>>>>>>> the call stack: <<<<<<<<<<\n%@", [NSThread callStackSymbols]);
    }
}

- (void)randomRemoveKVOInfoForKeyPath:(NSString *)keyPath observer:(id)observer {
    NSMutableSet *infos = [_keyPathToInfos objectForKey:keyPath];
    
    if (infos == nil) { // If remove a keyPath which had not been registered
        NSLog(@">>>>>>>>>> Remove unregistered forKeyPath: %@ <<<<<<<<<", keyPath);
        NSLog(@">>>>>>>>>> the call stack: <<<<<<<<<<\n%@", [NSThread callStackSymbols]);
        return ;
    }
    
    NSHashTable *tmp = [infos copy];
    BOOL hasRemoved = NO;
    for (__PYAKVOInfo *info in tmp) {
        if (!hasRemoved && [info.observer isEqual:observer]) {
            hasRemoved = YES;
            NSLog(@">>>>>>>>>> Random remove observer: %@, keyPath: %@, context: %p <<<<<<<<<<", info.observer, info.keyPath, info.context);
            [self.observeredObj pya_removeObserver:self forKeyPath:keyPath context:info.context];
            [infos removeObject:info];
        }
        [self checkKVOInfo:info inInfos:infos];
    }
}

- (void)checkKVOInfo:(__PYAKVOInfo *)info inInfos:(NSMutableSet *)infos {
    // Remove observer which has been released
    if (info.observer == nil) {
        NSLog(@">>>>>>>>>> Observer has been release!!! <<<<<<<<<<");
        [self.observeredObj pya_removeObserver:self forKeyPath:info.keyPath context:info.context];
        [infos removeObject:info];
        if (infos.count == 0) {
            [self.keyPathToInfos removeObjectForKey:info.keyPath];
        }
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSMutableSet *infos = [_keyPathToInfos objectForKey:keyPath];
    NSHashTable *tmp = [infos copy];
    for (__PYAKVOInfo *info in tmp) {
        [self checkKVOInfo:info inInfos:infos];
        [info.observer observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)removeAllObserver {
    NSLog(@">>>>>>>>>> Remove all observer <<<<<<<<<<");
    NSEnumerator *enumerator = [self.keyPathToInfos objectEnumerator];
    NSHashTable<__PYAKVOInfo *> *infos;
    while ((infos = [enumerator nextObject])) {
        NSHashTable<__PYAKVOInfo *> *tmp = [infos copy];
        for (__PYAKVOInfo *info in tmp) {
            [self.observeredObj pya_removeObserver:self forKeyPath:info.keyPath context:info.context];
            [infos removeObject:info];
        }
    }
    [self.keyPathToInfos removeAllObjects];
}

@end
