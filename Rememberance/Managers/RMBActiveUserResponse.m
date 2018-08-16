//
//  RMBActiveUserResponse.m
//  Rememberance
//
//  Created by Aly Ibrahim on 8/13/18.
//  Copyright © 2018 Aly Ibrahim. All rights reserved.
//

#import "RMBActiveUserResponse.h"

@implementation RMBActiveUserResponse

+ (NSString *)resultKeyPathForJSONDictionary:(NSDictionary *)JSONDictionary {
  return @"user";
}

@end
