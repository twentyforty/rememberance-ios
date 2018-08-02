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

@interface RMBVideoSeries : RMBModel

@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *progressTitle;
@property (copy, nonatomic) NSNumber *bookmarkedByMe;
@property (copy, nonatomic) NSNumber *videoIndex;
@property (strong, nonatomic) NSArray<RMBScholar *> *scholars;
@property (strong, nonatomic) NSArray<RMBVideo *> *videoSummaries;
@property (strong, nonatomic) NSURL *imageURL;
@property (copy, nonatomic) NSNumber *completed;

- (void)bookmark;
- (void)unbookmark;

@end
