//
//  RMBSeriesProgressView.h
//  Rememberance
//
//  Created by Aly Ibrahim on 8/1/18.
//  Copyright © 2018 Aly Ibrahim. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RMBSeriesProgressView : UIView

- (instancetype)initWithSize:(CGFloat)bubbleSize
            interItemSpacing:(CGFloat)interItemSpacing;

@property (assign, nonatomic, readwrite) NSInteger totalCount;

- (void)selectBubbleAtIndex:(NSInteger)index selected:(BOOL)selected;
- (void)resetBackgroundColors;

@end
