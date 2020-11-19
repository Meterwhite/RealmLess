//
//  ViewController.m
//  Realm--
//
//  Created by MeterWhite on 2020/1/21.
//  Copyright © 2020 Meterwhite. All rights reserved.
//  https://github.com/Meterwhite/RealmLess
//

#import "ViewController.h"
#import "TPerson.h"
#import "Realm--.h"

@implementation ViewController

- (void)Example {
    /// Your object
    RLMObject *obj;
    NSArray *objs;
    
    /// Using commit scope
    {
        /// Here in a scope.
        @realm_writing_scope;
        [rll_realm addObject:obj];
        @realm_commit_up
        [rll_realm deleteObject:obj];
        @realm_commit_up
        [rll_realm addObject:obj];
        @realm_commit_up
        [rll_realm deleteObject:obj];
    }
    NSLog(@"");
    {
        @realm_update_scope;
        RLLUpdate_obj = obj;
        // Or
        RLLUpdate_obj = objs;
    }
    
    {
        @realm_delete_scope;
        RLLDelete_obj = obj;
        // Or
        RLLDelete_obj = objs;
    }
    
    {
        /// Used in autoreleasepool commits transactions immimediately.
        @realm_add_scope;
        RLLAdd_obj = obj;
        // Or
        RLLAdd_obj = objs;
    }
    
    /// Using realm commit pool
    @realm_writing_pool({
        [rll_realm addOrUpdateObject:obj];
    });
    @realm_update_pool({
        RLLUpdate_obj = obj;
        // Or
        RLLUpdate_obj = objs;
    });
    @realm_delete_pool({
        RLLDelete_obj = obj;
        // Or
        RLLDelete_obj = objs;
    });
    @realm_add_pool({
        RLLAdd_obj = obj;
        // Or
        RLLAdd_obj = objs;
    });
    
    /// 使用RealmLess对象 / Use the RealmLess object
    RLLScopeObj(rll);
    [rll.realm addObject:obj];
    [rll nestedCommit];
    [rll.realm addObject:obj];
    [rll nestedCommit];
}

void ExampleMethod(RLMObject *obj) {
    @realm_writing_scope;
    RLMRealm *otherRealm;
    @realm_switch(otherRealm);
    [rll_realm addObject:obj];
    NSArray<RLMNotificationToken *> * tokens;
    @realm_without_notifying(tokens);
}

#pragma mark - Test


- (void)viewDidLoad {
    [super viewDidLoad];
    [self deleteAllTData];
    [self begginTest];
}

- (void)begginTest {
    {
        @realm_add_scope
        TPerson *p1 = [TPerson new];
        [p1 setName:@"1"];
        RLLAdd_obj = p1;
        @realm_commit_up
        TPerson *p2 = [TPerson new];
        [p2 setName:@"2"];
        RLLAdd_obj = p2;
        @realm_commit_up
        TPerson *p3 = [TPerson new];
        [p3 setName:@"3"];
        RLLAdd_obj = p3;
    }
    [self check1];
}

- (void)check1 {
    NSAssert([TPerson allObjects].count == 3, @"测试1失败");
    NSLog(@"测试1成功");
    [self test2];
}

- (void)test2 {
    {
        @realm_writing_scope_with([self testRealm])
        TPerson *p1 = [TPerson new];
        [p1 setName:@"1"];
        [rll_realm addObject:p1];
        @realm_commit_up
        TPerson *p2 = [TPerson new];
        [p2 setName:@"2"];
        [rll_realm addObject:p2];
        @realm_commit_up
        TPerson *p3 = [TPerson new];
        [p3 setName:@"3"];
        [rll_realm addObject:p3];
    }
    [self check2];
}

- (void)check2 {
    NSAssert([TPerson allObjectsInRealm:[self testRealm]].count == 3, @"测试2失败");
    NSLog(@"测试2成功");
    [self test3];
}

- (void)test3 {
    [self deleteAllTData];
    [[RLMRealm defaultRealm] transactionWithBlock:^{
        {
            @realm_add_scope
            TPerson *p1 = [TPerson new];
            [p1 setName:@"1"];
            RLLAdd_obj = p1;
            @realm_commit_up
            TPerson *p2 = [TPerson new];
            [p2 setName:@"2"];
            RLLAdd_obj = p2;
            @realm_commit_up
            TPerson *p3 = [TPerson new];
            [p3 setName:@"3"];
            RLLAdd_obj = p3;
        }
        NSAssert([RLMRealm.defaultRealm inWriteTransaction] == YES, @"测试3失败");
    }];
    NSAssert([RLMRealm.defaultRealm inWriteTransaction] == NO, @"测试3失败");
    [self check3];
}

- (void)check3 {
    NSAssert([TPerson allObjects].count == 3, @"测试3失败");
    NSLog(@"测试3成功");
}


#pragma mark - 辅助
- (void)deleteAllTData {
    [[RLMRealm defaultRealm] transactionWithBlock:^{
        [[RLMRealm defaultRealm] deleteAllObjects];
    }];
    [[self testRealm] transactionWithBlock:^{
        [[self testRealm] deleteAllObjects];
    }];
}

- (RLMRealm *)testRealm {
    id path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"RLLTest"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:path]) {
        [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    id url = [[[NSURL URLWithString:path] URLByAppendingPathComponent:@"COMMON"] URLByAppendingPathExtension:@"realm"];
    return [RLMRealm realmWithURL:url];
}

@end
