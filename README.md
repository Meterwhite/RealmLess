# RealmLess
## Description
* Solutions to simplify Realm(ObjC) transactions.(简化Realm事务的解决方案)
* No `beginWriteTransaction`, no `commitWriteTransaction`,no `__block`.You can return method anywhere.Nested commit transactions will not throw exceptions.
* For developers who are not familiar with realm, using realmless can avoid many bugs.
* Give a star so god bless you.
* [Swift Version](https://github.com/Meterwhite/RealmLessSwift "RealmLessSwift")

## CocoaPods
```
pod 'RealmLess'
```

## Header
```
#import <RealmLess/Realm--.h>
```

## RealmLess transaction scope (RealmLess事务作用域)
    
- > RealmLess transaction will be committed when leaving current scope.
    >> 写事务将在离开当前作用域时自动提交.

- > RealmLess variable `rll_realm` is provided in Realm-- scope to ensure the possibility of all operations.
    >> 在Realm--作用域中提供了realm变量`rll_realm`来保证所有操作的可能性。
    
- > In RealmLess scopes can be nested without throwing exceptions, and nested scopes will be merged. This solves a big trouble.
    >> 在RealmLess作用域是可以被嵌套而不会抛出异常的，嵌套的作用域会被合并。这解决了一个很大烦恼。
    
### Basic RealmLess  scope (写作用域)
```objc
@realm_writing_scope
[rll_realm addObject:YourObject];
```
### RealmLess Update scope (更新或添加作用域)
```objc
@realm_update_scope
[rll_realm addObject:YourObject];
RLLUpdate_obj = YourObject;
```
### RealmLess Add scope (添加作用域)
```objc
@realm_add_scope
RLLAdd_obj = YourObject;
```
### RealmLess Delete scope (删除作用域)
```objc
@realm_delete_scope
RLLDelete_obj = YourObject;
```
## RealmLess transaction pool / 作用域池
- Commit pool definitions ensure commits transaction to default realm when leaving pool scope.The variable `realm` (default realm) can be used in the commit pool.
- 提交池确保了离开作用域时进行提交到default realm。在提交池内可以使用变量`realm`(default realm)。
### Realm writing pool
```objc
@realm_writing_pool({
    [rll_realm addObject:YourObject];
});
```
### RealmLess update pool
```objc
@realm_update_pool({
    ...
});
```
### RealmLess add pool
```objc
@realm_add_pool({
    ...
});
```
### RealmLess delete pool
```objc
@realm_delete_pool({
    ...
});
```
## Switch realm variable (切换realm文件)
- > Change realm variable of current scope.It will try to commit the previous transaction.
    >> 在当前作用域内使用新的realm变量，这会将之前的事务提交。
```objc
@realm_writing_scope
...
@realm_switch(New Realm);
...
```

## Nested / 嵌套
```objc
{ @realm_writing_scope
  (第一段事务 / First transaction)
  @realm_commit_up // The first transaction takes effect immediately so that the changes can be queried in the second transaction / 第一段事务立即生效从而可以在第二段事务中查询到变更
  (第二段事务 / Second transaction)
  @realm_commit_up
  (第三段事务 / Third transaction)
}


@realm_writing_pool({
    (第一段事务 / First transaction)
    @realm_commit_up // The first transaction takes effect immediately so that the changes can be queried in the second transaction / 第一段事务立即生效从而可以在第二段事务中查询到变更
    (第二段事务 / Second transaction)
});

```

## Use RealmLess scoped objects / 使用RealmLess作用域对象
```objc
{
    RLLScopeObj(rll);
    [rll.realm addObject:obj];
    [rll nestedCommit];
    [rll.realm addObject:obj];
    [rll nestedCommit];
}
```
