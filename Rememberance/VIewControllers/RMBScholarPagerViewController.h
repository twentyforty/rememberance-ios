//
//  RMBScholarViewController.h
//  Rememberance
//
//  Created by Aly Ibrahim on 7/19/18.
//  Copyright © 2018 Aly Ibrahim. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

#import "RMBScholar.h"
#import "XLButtonBarPagerTabStripViewController.h"

@interface RMBScholarPagerViewController : XLButtonBarPagerTabStripViewController

- (instancetype)initWithScholar:(RMBScholar *)scholar;

@end
