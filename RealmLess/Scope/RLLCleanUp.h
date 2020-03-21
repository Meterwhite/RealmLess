//
//  RLLCleanup.h
//  Realm--
//
//  Created by MeterWhite on 2020/1/26.
//  Copyright © 2020 Meterwhite. All rights reserved.
//

#ifndef RLLCleanup_h
#define RLLCleanup_h

#import "RLLWriting.h"

NS_INLINE void rll_cleanup(id _Nonnull * _Nonnull rll) {
    [(RLLWriting *)(*rll) cleanup];
}

#endif /* RLLCleanup_h */
