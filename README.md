# RealmLess 
## Description
* Streamlined scheme of realm commit transaction.(Realm的提交事务的精简方案。)
* No `beginWriteTransaction`, no `commitWriteTransaction`,no `__block`.You can return method anywhere.
* [Swift](https://github.com/Meterwhite/RealmLessSwift "RealmLessSwift")

## CocoaPods
```
pod 'RealmLess'
```

## Head file
```
#import <RealmLess/Realm--.h>
```

## Realm commit scope (具有提交能力作用域)
- > Any `{}` is a scope, which is very important for this project，in normal times this is forgotten.
    >> 任何地方书写的`{}`都是作用域，这对于本项目十分重要。在平常这却是被淡忘的。
    
- > Realm transaction will be committed when leaving current scope.
    >> 写事务将在离开当前作用域时自动提交.

- > Variable realm can be used in scope
    >> 在作用域里面可以使用变量`realm`
    
- > The scope of different functions can also use corresponding variables such as: Add, Update,...
    >> 不同功能的作用域还可以使用对应的变量如：Add,Update,...
### Writing scope (写作用域)
```objc
@realm_writing_scope[;]
<realm>    /// [realm ....];
return ... /// It works fine after return.
```
### Update scope (更新或添加作用域)
```objc
@realm_update_scope[;]
<realm>
<UpdateFor> /// UpdateFor = obj; UpdateFor = objs;
```
### Add scope (添加作用域)
```objc
@realm_add_scope[;]
<realm>
<AddFor> /// AddFor = obj; AddFor = objs; 
```
### Delete scope (删除作用域)
```objc
@realm_delete_scope[;]
<realm>
<DeleteFor> /// DeleteFor = obj; DeleteFor = objs;
```
## Realm commit pool
- Commit pool definitions ensure commits transaction to default realm when leaving pool scope.The variable `realm` (default realm) can be used in the commit pool.
- 提交池确保了离开作用域时进行提交到default realm。在提交池内可以使用变量`realm`(default realm)。
### Realm writing pool
```objc
@realm_writing_pool({
    ...
    <realm>    /// [realm addObject:obj];
    return ... /// It works fine after return.
});
```
### Realm update pool
```objc
@realm_update_pool({
    ...
    <realm>
    <UpdateFor> /// UpdateFor = obj; UpdateFor = objs;
});
```
### Realm add pool
```objc
@realm_add_pool({
    ...
    <realm>
    <AddFor> /// AddFor = obj; AddFor = objs; 
});
```
### Realm delete pool
```objc
@realm_delete_pool({
    ...
    <realm>
    <DeleteFor> /// DeleteFor = obj; DeleteFor = objs; 
});
```
## Switch realm variable (切换realm变量)
- > Change realm variable of current scope.It will try to commit the previous transaction.
    >> 在当前作用域内使用新的realm变量，这会将之前的事务提交。
```objc
@realm_writing_scope[;]
...
@realm_switch(otherRealm);
...
```
