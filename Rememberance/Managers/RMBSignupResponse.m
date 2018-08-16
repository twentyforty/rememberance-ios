//
//  RMBSignupResponse.m
//  Rememberance
//
//  Created by Aly Ibrahim on 8/16/18.
//  Copyright © 2018 Aly Ibrahim. All rights reserved.
//

#import "RMBSignupResponse.h"

@implementation RMBSignupResponse

+ (NSString *)resultKeyPathForJSONDictionary:(NSDictionary *)JSONDictionary {
  return @"data";
}

@end
