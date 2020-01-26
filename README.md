# Realm--
## Description
* Perfect solution to reduce realm (objc) tedious write commit coding.一套减少Realm写入事务代码量的三方解决方案。
* No `__block`, no `beginWriteTransaction`, no `commitWriteTransaction`.You can return method anywhere.

## CocoaPods
```
pod 'Realm--'
```
## Realm commit scope
- Realm transaction will be committed when leaving current scope.
- 写事务将在离开当前作用域时自动提交.
### Writing scope
```objc
@realm_writing_scope[;]
<realm>
return ... /// It works fine after return.
```
### Update scope
```objc
@realm_update_scope[;]
<realm>
<Update> /// Update = obj; Update = objs;
```
### Add scope
```objc
@realm_add_scope[;]
<realm>
<Add> /// Add = obj; Add = objs; 
```
### Delete scope
```objc
@realm_delete_scope[;]
<realm>
<Delete> /// Delete = obj; Delete = objs;
```
## Realm commit pool
- Commit pool definitions ensure commits transaction to default realm when leaving pool scope.The variable `realm` (default realm) can be used in the commit pool.
- 提交池确保了离开作用域时进行提交到default realm。在提交池内可以使用变量`realm`(default realm)。
### Writing pool
```objc
@realm_writing_pool({
    ...
    <realm> /// [realm addObject:obj];
    return ... /// It works fine after return.
});
```
### Update pool
```objc
@realm_update_pool({
    ...
    <realm>
    <Update> /// Update = obj; Update = objs;
});
```
### Add pool
```objc
@realm_add_pool({
    ...
    <realm>
    <Add> /// Add = obj; Add = objs; 
});
```
### Delete pool
```objc
@realm_delete_pool({
    ...
    <realm>
    <Delete> /// Delete = obj; Delete = objs; 
});
```
## Switch realm
- Change realm of current scope.It will try to commit the previous transaction.
```objc
@realm_writing_scope[;]
...
@realm_switch(otherRealm);
...
```
