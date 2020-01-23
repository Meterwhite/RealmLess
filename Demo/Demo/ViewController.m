//
//  ViewController.m
//  Demo
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
    
    /// Using realm commit pool
    @realm_writing_pool({
        [realm addOrUpdateObject:obj];
    });
    @realm_update_pool({
        Update = obj;
        // Or
        Update = objs;
    });
    @realm_delete_pool({
        Delete = obj;
        // Or
        Delete = objs;
    });
    @realm_add_pool({
        Add = obj;
        // Or
        Add = objs;
    });
    
    /// Using commit scope
    {
        /// Here in a scope.
        @realm_writing_scope;
        [realm addObject:obj];
    }
        
    {
        @realm_update_scope;
        Update = obj;
        // Or
        Update = objs;
    }
    
    {
        @realm_delete_scope;
        Delete = obj;
        // Or
        Delete = objs;
    }
    
    @autoreleasepool {
        /// Used in autoreleasepool commits transactions immimediately.
        @realm_add_scope;
        Add = obj;
        // Or
        Add = objs;
    }
}

void yourMethod(RLMObject *obj) {
    @realm_writing_scope;
    /// Switch realm object.
    RLMRealm *otherRealm;
    @realm_switch(otherRealm);
    /// ...
    [realm addObject:obj];
    /// ...
}

@end
