//
//  RMBCollection.m
//  Rememberance
//
//  Created by Aly Ibrahim on 7/28/18.
//  Copyright © 2018 Aly Ibrahim. All rights reserved.
//

#import "RMBVideoSeries.h"
#import "Mantle.h"
#import "RMBClient.h"

@implementation RMBVideoSeries

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
  return [[super JSONKeyPathsByPropertyKey] mtl_dictionaryByAddingEntriesFromDictionary:
          @{@"title": @"title",
            @"bookmarkedByMe": @"bookmarked_by_me",
            @"videoIndex": @"video_index",
            @"videoCount": @"video_count",
            @"scholars": @"scholars",
            @"imageURL": @"image_url",
            @"completedVideoIndexes": @"completed_video_indexes",
            @"progressTitle": @"progress_title",
            @"videoSeriesDescription": @"description"
            }];
}

+ (NSString *)serverModelName {
  return  @"VideoSeries";
}

+ (NSArray<NSString *> *)defaultSummaryPropertyKeys {
  return [[super defaultSummaryPropertyKeys] arrayByAddingObjectsFromArray:
          @[@"title", @"bookmarkedByMe", @"videoIndex", @"videoCount", @"scholarImages", @"imageURL", @"completedVideoIndexes", @"progressTItle"]];
}

+ (NSArray<NSString *> *)detailPropertyKeys {
  return [[self defaultSummaryPropertyKeys] arrayByAddingObjectsFromArray:
          @[@"videoSeriesDescription"]];
}

+ (NSString *)resourcePathFormat {
  return @"videoseries/%ld/";
}

//+ (NSValueTransformer *)completedVideoIndexesJSONTransformer {
//  return [NSValueTransformer mtl_arrayMappingTransformerWithTransformer:[NSValueTransformer mtl_numberTransformerWithNumberStyle:NSNumberFormatterOrdinalStyle locale:nil]];
//}

+ (NSValueTransformer *)scholarsJSONTransformer {
  return [MTLJSONAdapter arrayTransformerWithModelClass:[RMBScholar class]];
//  return [NSValueTransformer mtl_arrayMappingTransformerWithTransformer:[NSValueTransformer valueTransformerForName:MTLURLValueTransformerName]];
}

+ (NSValueTransformer *)imageURLJSONTransformer {
  return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

- (void)bookmark {
  self.bookmarkedByMe = @(YES);
  [[RMBClient sharedClient] PUT:[NSString stringWithFormat:@"videoseries/%ld/bookmark/", self.identifier]
                     parameters:nil success:nil failure:nil];
}

- (void)unbookmark {
  self.bookmarkedByMe = @(NO);
  [[RMBClient sharedClient] DELETE:[NSString stringWithFormat:@"videoseries/%ld/bookmark/", self.identifier]
                        parameters:nil success:nil failure:nil];
}

@end
