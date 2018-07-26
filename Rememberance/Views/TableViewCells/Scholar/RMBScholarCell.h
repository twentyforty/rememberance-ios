//
//  RMBScholarCell.h
//  Rememberance
//
//  Created by Aly Ibrahim on 7/19/18.
//  Copyright © 2018 Aly Ibrahim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MGSwipeTableCell.h"
#import "RMBScholar.h"

@interface RMBScholarCell : MGSwipeTableCell

@property (strong, nonatomic, readwrite) RMBScholar *scholar;

@end
