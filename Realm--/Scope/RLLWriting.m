//
//  RLLWriting.m
//  Realm--
//
//  Created by MeterWhite on 2020/1/21.
//  Copyright © 2020 Meterwhite. All rights reserved.
//

#import "RLLWriting.h"

@implementation RLLWriting

+ (RLMRealm *)scope {
    return (id)[[self alloc] init];
}

+ (nonnull RLMRealm *)scopeWithPointer:(__strong id  _Nonnull *)ptr{
    RLLWriting *scope = [[self alloc] init];
    scope->_value = ptr;
    return (id)scope;
}

- (instancetype)init {
    if (self) {
        _realm = [RLMRealm defaultRealm];
        if(![_realm inWriteTransaction]) {
            [_realm beginWriteTransaction];
#ifdef DEBUG
            NSLog(@"realm-- : begging commit.");
#endif
        }
    }
    return self;
}

- (void)dealloc {
    if([_realm inWriteTransaction]) {
        if(_withoutNotifying == nil) {
            [_realm commitWriteTransaction];
        } else {
            [_realm commitWriteTransactionWithoutNotifying:_withoutNotifying error:nil];
        }
#ifdef DEBUG
        NSLog(@"realm-- : committed.");
#endif
    }
    _value = nil;
    _realm = nil;
}

- (RLMRealm *)realm {
    return _realm;
}

- (void)switchRealm:(RLMRealm *)realm {
    NSAssert(realm, @"Nonnull!");
    if([_realm inWriteTransaction]) {
        [_realm commitWriteTransaction];
#ifdef DEBUG
        NSLog(@"realm-- : committed.");
#endif
    }
    _realm = realm;
    if(![_realm inWriteTransaction]) {
        if(_withoutNotifying == nil) {
            [_realm commitWriteTransaction];
        } else {
            [_realm commitWriteTransactionWithoutNotifying:_withoutNotifying error:nil];
        }
#ifdef DEBUG
        NSLog(@"realm-- : begging commit.");
#endif
    }
}

- (void)setWithoutNotifying:(NSArray<RLMNotificationToken *> *)nots {
    _withoutNotifying = nots;
}

#pragma mark - NSProxy
- (void)forwardInvocation:(NSInvocation *)invocation {
    [_realm forwardInvocation:invocation];
}

- (nullable NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    return [_realm methodSignatureForSelector:sel];
}

- (NSString *)description {
    return [_realm description];
}

- (NSString *)debugDescription {
    return [_realm debugDescription];
}

- (BOOL)isEqual:(id)object {
    return [_realm isEqual:object];
}

- (NSUInteger)hash {
    return [_realm hash];
}

- (Class)superclass {
    return [_realm superclass];
}

- (Class)class {
    return [_realm class];
}

- (id)self {
    return (id)_realm;
}

- (id)performSelector:(SEL)aSelector {
    return (((id(*)(id, SEL))[_realm methodForSelector:aSelector])(_realm, aSelector));
}

- (id)performSelector:(SEL)aSelector withObject:(id)object {
    return (((id(*)(id, SEL, id))[_realm methodForSelector:aSelector])(_realm, aSelector, object));
}

- (id)performSelector:(SEL)aSelector withObject:(id)object1 withObject:(id)object2 {
    return (((id(*)(id, SEL, id, id))[_realm methodForSelector:aSelector])(_realm, aSelector, object1, object2));
}
@end
