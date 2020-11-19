//
//  NSArray+RLL.h
//  Realm--
//
//  Created by MeterWhite on 2020/1/29.
//  Copyright © 2020 Meterwhite. All rights reserved.
//  https://github.com/Meterwhite/RealmLess
//

#import <Realm/Realm.h>

@interface RLMResults(RLL)
@property (nonnull,nonatomic,readonly,copy) NSMutableArray<RLMObject *> *rll_asArray;
@property (nonnull,nonatomic,readonly,copy) RLMObject *rll_asObject;
@end

