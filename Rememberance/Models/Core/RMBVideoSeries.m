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
          @{@"identifier": @"id",
            @"title": @"title",
            @"bookmarkedByMe": @"bookmarked_by_me",
            @"videoIndex": @"video_index",
            @"scholars": @"scholars",
            @"imageURL": @"image_url",
            @"videoSummaries": @"video_summaries",
            @"progressTitle": @"progress_title",
            @"completed": @"completed"
            }];
}

+ (NSValueTransformer *)videoSummariesJSONTransformer {
   return [MTLJSONAdapter arrayTransformerWithModelClass:[RMBVideo class]];
}

+ (NSValueTransformer *)scholarsJSONTransformer {
  return [MTLJSONAdapter arrayTransformerWithModelClass:[RMBScholar class]];
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
