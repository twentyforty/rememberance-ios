//
//  RMBVideo.h
//  Rememberance
//
//  Created by Aly Ibrahim on 7/18/18.
//  Copyright © 2018 Aly Ibrahim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RMBModel.h"
#import "RMBMediaProgress.h"
//#import "RMBScholar.h"

@class RMBVideoSeries;
@class RMBScholar;

typedef NS_ENUM(NSInteger, RMBVideoProgressState) {
  RMBVideoProgressStateNotStarted,
  RMBVideoProgressStateStarted,
  RMBVideoProgressStateCompleted
};

@interface RMBVideo : RMBModel

@property (copy, nonatomic) NSString* title;
@property (strong, nonatomic) NSURL* url;
@property (copy, nonatomic) NSString *youtubeId;
@property (copy, nonatomic) NSString *videoDescription;
@property (strong, nonatomic) NSURL *imageSmallURL;
@property (strong, nonatomic) NSURL *imageMediumURL;
@property (strong, nonatomic) NSURL *imageLargeURL;
@property (copy, nonatomic) NSNumber *aspectRatio;
@property (copy, nonatomic) NSNumber *duration;
@property (copy, nonatomic) RMBMediaProgress *progress;
@property (copy, nonatomic) NSNumber *bookmarkedByMe;
@property (strong, nonatomic) NSArray<RMBScholar *> *scholars;
@property (strong, nonatomic) RMBVideoSeries *series;

@property (assign, nonatomic) RMBVideoProgressState state;
@property (assign, nonatomic) float progressPercentage;
@property (copy, nonatomic) NSString *lengthString;

- (void)updateProgressWithPosition:(long)position;
- (void)markComplete;
- (void)markIncomplete;
- (void)bookmark;
- (void)unbookmark;

@end
