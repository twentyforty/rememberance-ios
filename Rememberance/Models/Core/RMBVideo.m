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
#import "RMBMediaProgress.h"

@implementation RMBVideo

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
  return [[super JSONKeyPathsByPropertyKey] mtl_dictionaryByAddingEntriesFromDictionary:
          @{@"identifier": @"id",
            @"title": @"display_title",
            @"url": @"url",
            @"videoDescription": @"description",
            @"youtubeId": @"youtube_id",
            @"imageSmallURL": @"image_small_url",
            @"imageMediumURL": @"image_medium_url",
            @"imageLargeURL": @"image_large_url",
            @"aspectRatio": @"aspect_ratio",
            @"duration": @"duration",
            @"progress": @"progress",
            @"bookmarkedByMe": @"bookmarked_by_me",
            @"scholars": @"scholars"
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

+ (NSValueTransformer *)progressJSONTransformer {
  return [MTLJSONAdapter dictionaryTransformerWithModelClass:RMBMediaProgress.class];
}

+ (NSValueTransformer *)scholarsJSONTransformer {
  return [MTLJSONAdapter arrayTransformerWithModelClass:[RMBScholar class]];
}

- (RMBVideoProgressState)state {
  if ([self.progress.completed boolValue]) {
    return RMBVideoProgressStateCompleted;
  } else if (self.progress.position < 0) {
    return RMBVideoProgressStateNotStarted;
  } else {
    return RMBVideoProgressStateStarted;
  }
}

- (float)progressPercentage {
  long progress = [self.progress.position longValue];
  long duration = [self.duration longValue];

  if (progress > -1 && duration > 0) {
    return (double)progress / (double)duration;
  } else {
    return 0;
  }
}

- (NSString *)lengthString {
  long elapsedSeconds = [self.duration longValue];
  NSUInteger h = elapsedSeconds / 3600;
  NSUInteger m = (elapsedSeconds / 60) % 60;
  NSUInteger s = elapsedSeconds % 60;
  
  NSString *formattedTime;
  if (h > 0) {
    formattedTime = [NSString stringWithFormat:@"%lu:%02lu:%02lu", h, m, s];
  } else if (m > 0) {
    formattedTime = [NSString stringWithFormat:@"%lu:%02lu", m, s];
  } else {
    formattedTime = [NSString stringWithFormat:@":%02lu", s];
  }
  return formattedTime;
}

- (void)updateProgressWithPosition:(long)position {
  self.progress.position = @(position);
  [[RMBClient sharedClient] PUT:[NSString stringWithFormat:@"videos/%ld/progress/", self.identifier]
                     parameters:@{@"position": @(position)} success:nil failure:nil];
}

- (void)markComplete {
  self.progress.completed = @(YES);
  [[RMBClient sharedClient] PUT:[NSString stringWithFormat:@"videos/%ld/complete/", self.identifier]
                     parameters:nil success:nil failure:nil];
}

- (void)markIncomplete {
  self.progress.completed = @(NO);
  [[RMBClient sharedClient] DELETE:[NSString stringWithFormat:@"videos/%ld/complete/", self.identifier]
                        parameters:nil success:nil failure:nil];
}

- (void)bookmark {
  self.bookmarkedByMe = @(YES);
  [[RMBClient sharedClient] PUT:[NSString stringWithFormat:@"videos/%ld/bookmark/", self.identifier]
                     parameters:nil success:nil failure:nil];
}

- (void)unbookmark {
  self.bookmarkedByMe = @(NO);
  [[RMBClient sharedClient] DELETE:[NSString stringWithFormat:@"videos/%ld/bookmark/", self.identifier]
                        parameters:nil success:nil failure:nil];
}

@end
