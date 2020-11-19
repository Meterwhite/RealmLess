//
//  RLLUpdate.m
//  Realm--
//
//  Created by MeterWhite on 2020/1/21.
//  Copyright © 2020 Meterwhite. All rights reserved.
//  https://github.com/Meterwhite/RealmLess
//

#import "RLLUpdate.h"

@implementation RLLUpdate

- (void)willCommit {
    id obj = *_uobj;
    if(obj) {
        if([obj conformsToProtocol:@protocol(NSFastEnumeration)]){
            [self.realm addOrUpdateObjects:obj];
        } else {
            [self.realm addOrUpdateObject:obj];
        }
    }
}
@end
