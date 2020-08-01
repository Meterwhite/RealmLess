//
//  ViewController.m
//  Realm--
//
//  Created by MeterWhite on 2020/1/21.
//  Copyright © 2020 Meterwhite. All rights reserved.
//

#import "ViewController.h"
#import "Realm--.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /// Your object
    RLMObject *obj;
    NSArray *objs;
    
    /// Using commit scope
    {
        /// Here in a scope.
        @realm_writing_scope;
        [realm addObject:obj];
    }
    NSLog(@"");
    {
        @realm_update_scope;
        UpdateFor = obj;
        // Or
        UpdateFor = objs;
    }
    
    {
        @realm_delete_scope;
        DeleteFor = obj;
        // Or
        DeleteFor = objs;
    }
    
    {
        /// Used in autoreleasepool commits transactions immimediately.
        @realm_add_scope;
        AddFor = obj;
        // Or
        AddFor = objs;
    }
    
    /// Using realm commit pool
    @realm_writing_pool({
        [realm addOrUpdateObject:obj];
    });
    @realm_update_pool({
        UpdateFor = obj;
        // Or
        UpdateFor = objs;
    });
    @realm_delete_pool({
        DeleteFor = obj;
        // Or
        DeleteFor = objs;
    });
    @realm_add_pool({
        AddFor = obj;
        // Or
        AddFor = objs;
    });
}

void yourMethod(RLMObject *obj) {
    @realm_writing_scope;
    /// Switch realm object.
    RLMRealm *otherRealm;
    @realm_switch(otherRealm);
    /// ...
    [realm addObject:obj];
    /// ...
    
    NSArray<RLMNotificationToken *> * tokens;
    @realm_without_notifying(tokens);
    /// ...
}

@end
