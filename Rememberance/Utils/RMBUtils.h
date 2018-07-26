//
//  RMBUtils.h
//  Rememberance
//
//  Created by Aly Ibrahim on 7/16/18.
//  Copyright © 2018 Aly Ibrahim. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^RMBCompletion)(void);
typedef void (^RMBFailure)(NSString *message);

#if __has_feature(objc_arc_weak)
#define WEAKSELF_T __weak __typeof__(self)
#else
#define WEAKSELF_T __unsafe_unretained __typeof__(self)
#endif

@interface RMBUtils : NSObject

@end
