# Realm--
## Introduce
* Perfect solution to reduce realm (objc) tedious write commit coding.一套减少Realm写入事务代码量的三方解决方案。
* Good luck for one start.点赞富一生.
* No `__block`, no `beginWriteTransaction`, no `commitWriteTransaction`.You can return method anywhere.

## CocoaPods
```
pod 'Realm--'
```

## Realm commit pool
- Commit pool definitions ensure commits transaction to default realm when leaving this scope.Variable 'realm' can be used in each realm pool.The variable `realm` (default realm) can be used in the commit pool.
- 提交池确保了离开作用域时进行提交到default realm。在提交池内可以使用变量`realm`(default realm)。
### Writing pool
```objc
@realm_writing_pool({
    ...
    <realm> /// [realm addObject:obj];
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
## Realm commit scope
- Realm commit scope  commits transaction when autoreleapool is released.Usually at the end of the runloop. This is a minimal code solution, but may delay commit.
- 提交作用域是代码量最少的方案，但是可能会延迟提交的时机。该提交发生在当前作用域的autoreleasepool释放之时，这通常是当前runloop运行结束时。
### Writing scope
```objc
@realm_writing_scope;
<realm>
```
### Update scope
```objc
@realm_update_scope;
<realm>
<Update> /// Update = obj; Update = objs;
```
### Add scope
```objc
@realm_add_scope;
<realm>
<Add> /// Add = obj; Add = objs; 
```
### Delete scope
```objc
@realm_delete_scope;
<realm>
<Delete> /// Delete = obj; Delete = objs;
```
## Switch realm
- Change realm of current scope.It will try to commit the previous transaction.
```objc
@realm_writing_scope;
...
@realm_switch(otherRealm);
...
```
