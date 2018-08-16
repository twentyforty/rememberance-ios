//
//  RMBResponse.m
//  Rememberance
//
//  Created by Aly Ibrahim on 8/2/18.
//  Copyright © 2018 Aly Ibrahim. All rights reserved.
//

#import "RMBListResponse.h"

@implementation RMBListResponse

+ (NSString *)resultKeyPathForJSONDictionary:(NSDictionary *)JSONDictionary {
  return @"results";
}

@end
