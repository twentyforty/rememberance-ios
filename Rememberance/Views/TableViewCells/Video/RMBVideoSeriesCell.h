//
//  RMBVideoSeriesCell.h
//  Rememberance
//
//  Created by Aly Ibrahim on 7/31/18.
//  Copyright © 2018 Aly Ibrahim. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RMBVideoSeries.h"
#import "MGSwipeTableCell.h"
@interface RMBVideoSeriesCell : MGSwipeTableCell

@property (strong, nonatomic, readwrite) RMBVideoSeries *videoSeries;

@end
