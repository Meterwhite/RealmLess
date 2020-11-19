//
//  RLLAdd.m
//  Realm--
//
//  Created by MeterWhite on 2020/1/22.
//  Copyright © 2020 Meterwhite. All rights reserved.
//  https://github.com/Meterwhite/RealmLess
//

#import "RLLAdd.h"

@implementation RLLAdd

- (void)willCommit {
    id obj = *_uobj;
    if(obj){
        if([obj conformsToProtocol:@protocol(NSFastEnumeration)]){
            [self.realm addObjects:obj];
        } else {
            [self.realm addObject:obj];
        }
    }
}
@end
