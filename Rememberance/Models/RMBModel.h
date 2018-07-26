//
//  RMBModel.h
//  Rememberance
//
//  Created by Aly Ibrahim on 7/17/18.
//  Copyright © 2018 Aly Ibrahim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Mantle.h"
#import "RMBUtils.h"
#import "NSDictionary+MTLManipulationAdditions.h"

@interface RMBModel : MTLModel <MTLJSONSerializing>

@property (assign, nonatomic) NSInteger identifier;

- (NSString *)cacheKey;

+ (NSString *)cacheKeyPrefix;
+ (NSString *)cacheKeyForIdentifier:(NSInteger)identifier;

@end
