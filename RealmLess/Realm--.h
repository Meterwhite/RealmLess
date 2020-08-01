//
//  Realm--.h
//  Realm--
//
//  Created by MeterWhite on 2020/1/21.
//  Copyright © 2020 Meterwhite. All rights reserved.
//

#ifndef RealmLess
#define RealmLess

#import "RLLWriting.h"
#import "RLLCleanUp.h"
#import "RLLUpdate.h"
#import "RLLDelete.h"
#import "RLLAdd.h"

#pragma mark - Realm Commit Scope
/**
 * Realm transaction will be committed when leaving current scope.
 * scope
 * { @realm_writing_scope;
 *    ...
 * }
 */
#define realm_writing_scope \
rll_keywordify              \
RLMRealm *realm __attribute__((cleanup(rll_cleanup),unused)) = [RLLWriting scope];

#define realm_update_scope  \
rll_keywordify              \
id UpdateFor;                  \
RLMRealm *realm __attribute__((cleanup(rll_cleanup),unused)) = [RLLUpdate scopeWithPointer:&UpdateFor];

#define realm_add_scope \
rll_keywordify              \
id AddFor;                 \
RLMRealm *realm __attribute__((cleanup(rll_cleanup),unused)) = [RLLAdd scopeWithPointer:&AddFor];

#define realm_delete_scope  \
rll_keywordify              \
id DeleteFor;                  \
RLMRealm *realm __attribute__((cleanup(rll_cleanup),unused)) = [RLLDelete scopeWithPointer:&DeleteFor];

#pragma mark - Change realm of current scope
/**
 * Switch realm in current scope.It will try to commit the previous transaction before.
 */
#define realm_switch(...)   \
rll_keywordify              \
[(RLLWriting *)realm switchRealm:(__VA_ARGS__)];

#pragma mark -
#define realm_without_notifying(...)    \
rll_keywordify                          \
[(RLLWriting *)realm setWithoutNotifying:(__VA_ARGS__)];

#pragma mark - Realm Commit Pool
/**
 * These macro definitions ensure commits transaction when leaving this scope.
 * Variable 'realm' can be used in each commit pool.
 * @realm_writing_pool({
 *     ...
 * });
 * @realm_update_pool({
 *     ...
 *     UpdateFor = ...
 * });
 * @realm_delete_pool({
 *     ...
 *     DeleteFor = ...
 * });
 * @realm_add_pool({
 *     ...
 *     AddFor = ...
 * });
 */
#define realm_writing_pool(...) \
rll_keywordify {            \
    @realm_writing_scope    \
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

#if DEBUG
#define rll_keywordify  autoreleasepool {}
#else
#define rll_keywordify  try {} @catch (...) {}
#endif

#endif /// RealmLess
