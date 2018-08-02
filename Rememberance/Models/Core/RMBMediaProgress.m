//
//  RMBMediaProgress.m
//  Rememberance
//
//  Created by Aly Ibrahim on 7/30/18.
//  Copyright © 2018 Aly Ibrahim. All rights reserved.
//

#import "RMBMediaProgress.h"

@implementation RMBMediaProgress

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
  return @{@"position": @"position",
           @"completed": @"completed"
           };
}

@end
