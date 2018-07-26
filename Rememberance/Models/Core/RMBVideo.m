//
//  RMBVideo.m
//  Rememberance
//
//  Created by Aly Ibrahim on 7/18/18.
//  Copyright © 2018 Aly Ibrahim. All rights reserved.
//

#import "RMBVideo.h"
#import "Mantle.h"
#import "RMBClient.h"

@implementation RMBVideo

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
  return [[super JSONKeyPathsByPropertyKey] mtl_dictionaryByAddingEntriesFromDictionary:
          @{@"identifier": @"id",
            @"title": @"title",
            @"url": @"url",
            @"videoDescription": @"description",
            @"youtubeId": @"youtube_id",
            @"imageSmallURL": @"image_small_url",
            @"imageMediumURL": @"image_medium_url",
            @"imageLargeURL": @"image_large_url",
            @"aspectRatio": @"aspect_ratio",
            @"duration": @"duration",
            @"progress": @"progress",
            @"bookmarkedByMe": @"bookmarked_by_me"
            }];
}

+ (NSValueTransformer *)urlJSONTransformer {
  return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)imageSmallURLJSONTransformer {
  return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)imageMediumURLJSONTransformer {
  return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)imageLargeURLJSONTransformer {
  return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

- (float)progressPercentage {
  long progress = [self.progress longValue];
  long duration = [self.duration longValue];

  if (progress > -1 && duration > 0) {
    return (double)progress / (double)duration;
  } else {
    return 0;
  }
}

- (void)updateProgressWithPosition:(long)position {
  self.progress = @(position);
  [[RMBClient sharedClient] PUT:[NSString stringWithFormat:@"videos/%ld/progress/", self.identifier]
                     parameters:@{@"position": @(position)} success:nil failure:nil];
}

- (void)bookmark {
  [[RMBClient sharedClient] PUT:[NSString stringWithFormat:@"videos/%ld/bookmark/", self.identifier]
                     parameters:nil success:nil failure:nil];
}

- (void)unbookmark {
  [[RMBClient sharedClient] DELETE:[NSString stringWithFormat:@"videos/%ld/bookmark/", self.identifier]
                        parameters:nil success:nil failure:nil];
}

@end
