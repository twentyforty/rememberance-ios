//
//  RMBVideoCell.h
//  Rememberance
//
//  Created by Aly Ibrahim on 7/19/18.
//  Copyright © 2018 Aly Ibrahim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "RMBVideo.h"
#import "MGSwipeTableCell.h"

@interface RMBVideoCell : MGSwipeTableCell

@property (strong, nonatomic, readwrite) RMBVideo *video;

@end
