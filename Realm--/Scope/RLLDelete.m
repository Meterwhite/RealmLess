//
//  RLLDelete.m
//  Realm--
//
//  Created by MeterWhite on 2020/1/21.
//  Copyright © 2020 Meterwhite. All rights reserved.
//

#import "RLLDelete.h"
@implementation RLLDelete

- (void)dealloc {
    if([_realm inWriteTransaction]) {
        id obj = *_value;
        if(obj) {
            if([obj conformsToProtocol:@protocol(NSFastEnumeration)]){
                [_realm deleteObjects:obj];
            } else {
                [_realm deleteObject:obj];
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
    _value = nil;
    _realm = nil;
}
@end
