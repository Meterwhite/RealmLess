//
//  RLLWriting.m
//  Realm--
//
//  Created by MeterWhite on 2020/1/21.
//  Copyright © 2020 Meterwhite. All rights reserved.
//  https://github.com/Meterwhite/RealmLess
//

#import "RLLWriting.h"

@implementation RLLWriting {
@private
    RLMRealm  *_realm;
    BOOL       _isNested;
}

+ (RLMRealm *)scope {
    return [[[self alloc] initWithRealm:[RLMRealm defaultRealm]] begging];
}

+ (RLMRealm *)scopeUsingRealm:(RLMRealm *)realm {
    return [[[self alloc] initWithRealm:realm] begging];
}

+ (RLMRealm *)scopeWithUserObject:(__strong id  _Nonnull *)user{
    RLLWriting *scope = [[self alloc] initWithRealm:[RLMRealm defaultRealm]];
    scope->_uobj = user;
    return [scope begging];
}

- (instancetype)initWithRealm:(RLMRealm *)realm {
    if (self) {
        NSAssert(realm, @"Nonnull");
        _realm          = realm;
        _isNested       = [_realm inWriteTransaction];
    }
    return self;
}

- (RLMRealm *)begging {
     if(!_isNested) {
        [_realm beginWriteTransaction];
#ifdef DEBUG
        NSLog(@"realm-- : begging commit.");
#endif
    }
    return (id)self;
}

- (void)cleanup {
    [self willCommit];
    if(_withoutNTFTokens == nil) {
        [_realm commitWriteTransaction];
    } else {
        [_realm commitWriteTransactionWithoutNotifying:_withoutNTFTokens error:nil];
    }
    if(_isNested) {
        /// 传递事务
        [_realm beginWriteTransaction];
#ifdef DEBUG
        NSLog(@"realm-- : nested over go on commit.");
#endif
    }
#ifdef DEBUG
    else {
        NSLog(@"realm-- : committed.");
    }
#endif
}

- (RLMRealm *)nestedCommit {
    if([_realm inWriteTransaction]) {
        if(_isNested) {
            _isNested = NO;
            [self cleanup];
            [self begging];
            _isNested = YES;
        } else {
            [self cleanup];
            [self begging];
        }
    }
    return (id)self;
}

- (void)switchRealm:(RLMRealm *)realm {
    NSAssert(realm, @"Nonnull!");
    if(realm == _realm) return;/// 同文件则无为
    /// 提交处理旧的文件事务
    [self cleanup];
    _realm      = realm;
    _isNested   = [_realm inWriteTransaction];
    [self begging];
}

- (RLMRealm *)letWithoutNotifying:(NSArray<RLMNotificationToken *> *)tokens {
    _withoutNTFTokens = tokens;
    return (id)self;
}

#pragma mark - NSProxy
- (void)forwardInvocation:(NSInvocation *)invocation {
    [invocation invokeWithTarget:_realm];
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

- (void)willCommit { }
@end
