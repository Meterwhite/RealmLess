//
//  Realm--.h
//  Realm--
//
//  Created by MeterWhite on 2020/1/21.
//  Copyright © 2020 Meterwhite. All rights reserved.
//  https://github.com/Meterwhite/RealmLess
//

#ifndef RealmLess
#define RealmLess

#import "RLLWriting.h"
#import "RLLCleanUp.h"
#import "RLLUpdate.h"
#import "RLLDelete.h"
#import "RLLAdd.h"


/**
 *
 * Realm--通过作用域实现自动提交事务，这避免了多余的提交代码和block闭包的跨作用域问题。
 * 在Realm--作用域中提供了realm变量`rll_realm`来保证所有操作的可能性。
 * 在Realm--作用域是可以被嵌套而不会抛出异常的，嵌套的作用域会被合并。
 * Realm--支持将嵌套的事务立即提交生效并自动延续事务的作用域。
 *
 * Realm-- Realize automatic transaction commit through scope, which avoids the cross-scope problem of redundant commit code and block closure.
 * Realm variable `rll_realm` is provided in Realm--scope to ensure the possibility of all operations.
 * In Realm--scopes can be nested without throwing exceptions, and nested scopes will be merged.
 * Realm--supports the immediate submission of nested transactions to take effect and automatically extends the scope of the transaction.
 *
 * 基本使用 / Basic use
 * { @realm_writing_scope
 *    [rll_realm addObject:YourObject];
 * }
 *
 * 明确的使用 / Explicit use
 * { @realm_add_scope
 *   RLLAdd_obj = YourObject;
 * }
 *
 * 嵌套问题 / Nested
 * { @realm_writing_scope
 *   (第一段事务/First transaction)
 *   @realm_commit_up
 *   (第二段事务/Second transaction)
 *   @realm_commit_up
 *   (第三段事务/Third transaction)
 * }
 *
 * 使用指定的realm文件 / Use the specified realm file
 * { @realm_writing_scope_with(YourRealm)
 *
 * }
 *
 * 切换到新的realm事务作用域 / Switch to the new realm transaction scope
 * { ... ...
 *   @realm_switch(NewRealm)
 * }
 *
 *
 */


#pragma mark - Realm事务作用域 / Realm Transaction Scope
/**
 * Realm transaction will be committed when leaving current scope.
 * Realm事务在花括号作用域结束前自动提交。
 * { @realm_writing_scope;
 *    [rll_realm addObject:... ...
 *    [rll_realm deleteObject:... ...
 *    ... ...
 * }
 */
#define realm_writing_scope \
rll_keywordify              \
RLMRealm *rll_realm __attribute__((cleanup(rll_cleanup),unused)) = [RLLWriting scope];

/// 指定的realm文件的realm_writing_scope
#define realm_writing_scope_with(rlm) \
rll_keywordify              \
RLMRealm *rll_realm __attribute__((cleanup(rll_cleanup),unused)) = [RLLWriting scopeUsingRealm:rlm];

/**
 * 提供变量RLLUpdate_obj用于指定更新的对象
 */
#define realm_update_scope  \
rll_keywordify              \
id RLLUpdate_obj;                  \
RLMRealm *rll_realm __attribute__((cleanup(rll_cleanup),unused)) = [RLLUpdate scopeWithUserObject:&RLLUpdate_obj];
/**
 * 提供变量RLLAdd_obj用于指定要添加的对象
 */
#define realm_add_scope \
rll_keywordify              \
id RLLAdd_obj;                 \
RLMRealm *rll_realm __attribute__((cleanup(rll_cleanup),unused)) = [RLLAdd scopeWithUserObject:&RLLAdd_obj];
/**
 * 提供变量RLLDelete_obj用于指定要删除的对象
 */
#define realm_delete_scope  \
rll_keywordify              \
id RLLDelete_obj;                  \
RLMRealm *rll_realm __attribute__((cleanup(rll_cleanup),unused)) = [RLLDelete scopeWithUserObject:&RLLDelete_obj];

#pragma mark - 控制 / Control
/**
 * 立即提交上方事务，未完成的事务将在新启的事务中处理。
 * Commit the above transaction immediately, and the uncommit transaction will be processed in the newly opened transaction.
 */
#define realm_commit_up \
rll_keywordify          \
[(RLLWriting *)rll_realm nestedCommit];

#pragma mark - Change realm of current scope
/**
 * 切换当前作用于下的realm，此行为会提交前方事务，未完成的事务将在新启的事务中处理。
 * Switch realm in current scope.It will try to commit the previous transaction before.
 */
#define realm_switch(realm) \
rll_keywordify              \
[(RLLWriting *)rll_realm switchRealm:realm];

#define realm_without_notifying(tokens) \
rll_keywordify                          \
[(RLLWriting *)rll_realm letWithoutNotifying:tokens];

#pragma mark - Realm Commit Pool
/**
 * These macro definitions ensure commits transaction when leaving this scope.
 * Variable 'realm' can be used in each commit pool.
 * @realm_writing_pool({
 *     ...
 * });
 * @realm_update_pool({
 *     ...
 *     RLLUpdate_obj = ...
 * });
 * @realm_delete_pool({
 *     ...
 *     RLLDelete_obj = ...
 * });
 * @realm_add_pool({
 *     ...
 *     RLLAdd_obj = ...
 * });
 */
#define realm_writing_pool(...) \
rll_keywordify {            \
    @realm_writing_scope    \
    __VA_ARGS__             \
}

#define realm_writing_pool_with(rlm, ...) \
rll_keywordify {            \
    @realm_writing_scope_with(rlm)    \
    __VA_ARGS__             \
}

#define realm_update_pool(...) \
rll_keywordify {            \
    @realm_update_scope     \
    __VA_ARGS__             \
}

#define realm_delete_pool(...) \
rll_keywordify {            \
    @realm_delete_scope     \
    __VA_ARGS__             \
}

#define realm_add_pool(...) \
rll_keywordify {            \
    @realm_add_scope        \
    __VA_ARGS__             \
}

#pragma mark - 使用自定义
/// 创建默认作用域对象
#define RLLScopeObj(var) \
RLLWriting *var __attribute__((cleanup(rll_cleanup),unused)) = (id)[RLLWriting scope]

#define RLLScopeObjWithRLM(var,realm) \
RLLWriting *var __attribute__((cleanup(rll_cleanup),unused)) = (id)[RLLWriting scopeUsingRealm:realm]

#if DEBUG
#define rll_keywordify  autoreleasepool {}
#else
#define rll_keywordify  try {} @catch (...) {}
#endif

#endif /// RealmLess
