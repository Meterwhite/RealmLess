//
//  RLLUpdate.m
//  Realm--
//
//  Created by MeterWhite on 2020/1/21.
//  Copyright © 2020 Meterwhite. All rights reserved.
//

#import "RLLUpdate.h"

@implementation RLLUpdate

- (void)cleanup {
    if([_realm inWriteTransaction]) {
        id obj = *_value;
        if(obj) {
            if([obj conformsToProtocol:@protocol(NSFastEnumeration)]){
                [_realm addOrUpdateObjects:obj];
            } else {
                [_realm addOrUpdateObject:obj];
            }
        }
        if(_withoutNotifying == nil) {
            [_realm commitWriteTransaction];
        } else {
            [_realm commitWriteTransactionWithoutNotifying:_withoutNotifying error:nil];
        }
#ifdef DEBUG
        NSLog(@"realm-- : committed.");
#endif
    }
}
@end
