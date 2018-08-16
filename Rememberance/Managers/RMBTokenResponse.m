//
//  RMBTokenResponse.m
//  Rememberance
//
//  Created by Aly Ibrahim on 8/13/18.
//  Copyright © 2018 Aly Ibrahim. All rights reserved.
//

#import "RMBTokenResponse.h"

@implementation RMBTokenResponse

+ (NSString *)resultKeyPathForJSONDictionary:(NSDictionary *)JSONDictionary {
  return @"token";
}

@end
