//
//  RMBScholarHeaderView.h
//  Rememberance
//
//  Created by Aly Ibrahim on 7/19/18.
//  Copyright © 2018 Aly Ibrahim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "GSKStretchyHeaderView.h"
#import "RMBScholar.h"

@protocol RMBHeaderViewDelegate <NSObject>

- (void)backButtonPressed;

@end

@interface RMBScholarHeaderView : GSKStretchyHeaderView 

@property (strong, nonatomic, readwrite) RMBScholar *scholar;
@property (weak, nonatomic, readwrite) id<RMBHeaderViewDelegate> delegate;

@end
