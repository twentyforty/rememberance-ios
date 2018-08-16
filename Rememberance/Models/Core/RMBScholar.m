//
//  RMBModel.m
//  Rememberance
//
//  Created by Aly Ibrahim on 7/17/18.
//  Copyright © 2018 Aly Ibrahim. All rights reserved.
//

#import "RMBScholar.h"
#import "RMBClient.h"

@interface RMBScholar ()

@end

@implementation RMBScholar

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
  return [[super JSONKeyPathsByPropertyKey] mtl_dictionaryByAddingEntriesFromDictionary:
          @{@"name": @"full_name",
            @"bio": @"bio",
            @"imageURL": @"small_image_url",
            @"videoCount": @"video_count",
            @"videoSeriesCount": @"video_series_count",
            @"bookmarkedByMe": @"bookmarked_by_me",
            }];
}

+ (NSString *)serverModelName {
  return @"Scholar";
}

+ (NSString *)resourcePathFormat {
  return @"scholars/%ld/";
}

+ (NSArray<NSString *> *)defaultSummaryPropertyKeys {
  return [[super defaultSummaryPropertyKeys] arrayByAddingObjectsFromArray:
          @[@"name", @"imageURL", @"bookmarkedByMe"]];
}

+ (NSArray<NSString *> *)detailPropertyKeys {
  return [[self defaultSummaryPropertyKeys] arrayByAddingObjectsFromArray:
          @[@"bio", @"videoCount", @"videoSeriesCount"]];
}

+ (NSValueTransformer *)imageURLJSONTransformer {
  return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

- (void)bookmark {
  self.bookmarkedByMe = @(YES);
  [[RMBClient sharedClient] PUT:[NSString stringWithFormat:@"scholars/%ld/bookmark/", self.identifier]
                     parameters:nil success:nil failure:nil];
}

- (void)unbookmark {
  self.bookmarkedByMe = @(NO);
  [[RMBClient sharedClient] DELETE:[NSString stringWithFormat:@"scholars/%ld/bookmark/", self.identifier]
                        parameters:nil success:nil failure:nil];
}


@end
