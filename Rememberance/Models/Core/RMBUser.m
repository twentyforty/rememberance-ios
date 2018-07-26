//
//  RMBUser.m
//  Rememberance
//
//  Created by Aly Ibrahim on 7/16/18.
//  Copyright © 2018 Aly Ibrahim. All rights reserved.
//

#import "RMBUser.h"
#import "Mantle.h"

@implementation RMBUser

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
  return [[super JSONKeyPathsByPropertyKey] mtl_dictionaryByAddingEntriesFromDictionary:
          @{@"identifier": @"id",
            @"email": @"email",
            @"username": @"username"}];
}

+ (NSString *)relativeRemotePathForClass {
  return @"users/";
}

@end
