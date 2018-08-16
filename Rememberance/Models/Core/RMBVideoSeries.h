//
//  RMBCollection.h
//  Rememberance
//
//  Created by Aly Ibrahim on 7/28/18.
//  Copyright © 2018 Aly Ibrahim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RMBModel.h"
#import "RMBVideo.h"
#import "RMBScholar.h"
#import "RMBMediaProgress.h"

@interface RMBVideoSeries : RMBModel

@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *videoSeriesDescription;
@property (copy, nonatomic) NSString *progressTitle;
@property (copy, nonatomic) NSNumber *bookmarkedByMe;
@property (copy, nonatomic) NSNumber *videoIndex;
@property (copy, nonatomic) NSNumber *videoCount;
@property (strong, nonatomic) NSArray<RMBScholar *> *scholars;
@property (strong, nonatomic) NSArray<NSNumber *> *completedVideoIndexes;
@property (strong, nonatomic) NSURL *imageURL;

- (void)bookmark;
- (void)unbookmark;

@end
