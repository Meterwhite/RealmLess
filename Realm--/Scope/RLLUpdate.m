//
//  RLLUpdate.m
//  ProjRealm--
//
//  Created by MeterWhite on 2020/1/21.
//  Copyright © 2020 Meterwhite. All rights reserved.
//

#import "RLLUpdate.h"

@implementation RLLUpdate

- (void)dealloc {
    if([_realm inWriteTransaction]) {
        id obj = *_value;
        if(obj) {
            if([obj conformsToProtocol:@protocol(NSFastEnumeration)]){
                [_realm addOrUpdateObjects:obj];
            } else {
                [_realm addOrUpdateObject:obj];
            }
        }
        [_realm commitWriteTransaction];
#ifdef DEBUG
        NSLog(@"realm-- : committed.");
#endif
    }
    _value = nil;
    _realm = nil;
}
@end
