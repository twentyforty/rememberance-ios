//
//  RMBVideo.h
//  Rememberance
//
//  Created by Aly Ibrahim on 7/18/18.
//  Copyright © 2018 Aly Ibrahim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RMBModel.h"

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
@property (copy, nonatomic) NSNumber *progress;
@property (copy, nonatomic) NSNumber *bookmarkedByMe;
@property (assign, nonatomic) float progressPercentage;

- (void)updateProgressWithPosition:(long)position;

@end
