//
//  RLLWriting.h
//  Realm--
//
//  Created by MeterWhite on 2020/1/21.
//  Copyright © 2020 Meterwhite. All rights reserved.
//  https://github.com/Meterwhite/RealmLess
//

#if __has_include(<Realm/Realm.h>)
#import <Realm/Realm.h>
#else
#import <Realm/Realm.h>
#endif

/// Base class.RLL means realm less less.
@interface RLLWriting : NSProxy {
@public
    __strong id *_uobj;
    NSArray<RLMNotificationToken *> * _withoutNTFTokens;
}

@property (nonnull,nonatomic,readonly) RLMRealm *realm;

/// 创建一个默认作用域对象 / Create a default scope object
+ (nonnull RLMRealm*)scope;
/// 创建一个指定文件的作用域对象 / Create a scope object for the specified realm file
+ (nonnull RLMRealm*)scopeUsingRealm:(nonnull RLMRealm *)realm;

+ (nonnull RLMRealm*)scopeWithUserObject:(__strong id _Nonnull *_Nonnull)user;

/// 切换realm文件 / switch realm file object
- (void)switchRealm:(nonnull RLMRealm *)realm;

- (nonnull RLMRealm*)letWithoutNotifying:(nonnull NSArray<RLMNotificationToken *> *)tokens;

/**
 * 提交当前这个被嵌套的事务以及外层事务，以使被嵌套的事务及外层事务立即生效，而嵌套事务外层的未执行的事务将在新事务中继续。理解以防止预期外的行为。/ Submit the current nested transaction and the outer transaction so that the nested transaction and the outer transaction take effect immediately, and the unexecuted transactions outside the nested transaction will continue in the new transaction. Understand to prevent unexpected behavior.
 */
- (nonnull RLMRealm*)nestedCommit;

/// 作用域末尾的清理，会触发提交事务 / End the scope and commit the transaction
- (void)cleanup;

/// 子类实现 / Subclass implementation
- (void)willCommit;
@end
