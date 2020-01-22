//
//  RLLWriting.h
//  Realm--
//
//  Created by MeterWhite on 2020/1/21.
//  Copyright © 2020 Meterwhite. All rights reserved.
//

#if __has_include(<Realm/Realm.h>)
#import <Realm/Realm.h>
#else
#import <Realm/Realm.h>
#endif

/// Base class.RLL means realm less less.
@interface RLLWriting : NSProxy
{
@public
    RLMRealm    *_realm;
    __strong id *_value;
}
+ (nonnull RLMRealm*)scope;
+ (nonnull RLMRealm*)scopeWithPointer:(__strong id _Nonnull *_Nonnull)ptr;
- (void)switchRealm:(nonnull RLMRealm *)realm;
@end
