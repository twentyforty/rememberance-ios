//
//  RMBModel.m
//  Rememberance
//
//  Created by Aly Ibrahim on 7/17/18.
//  Copyright © 2018 Aly Ibrahim. All rights reserved.
//

#import "RMBModel.h"
#import "PINCache.h"

@implementation RMBModel

- (NSString *)cacheKey {
  return [[self class] cacheKeyForIdentifier:self.identifier];
}

+ (NSString *)cacheKeyForIdentifier:(NSInteger)identifier {
  return [NSString stringWithFormat:@"%@-%ld", [[self class] cacheKeyPrefix], identifier];
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
  return @{@"identifier": @"id"};
}

+ (NSString *)cacheKeyPrefix {
  return NSStringFromClass([self class]);
}

@end
