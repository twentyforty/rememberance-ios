//
//  RMBSeriesProgressView.m
//  Rememberance
//
//  Created by Aly Ibrahim on 8/1/18.
//  Copyright © 2018 Aly Ibrahim. All rights reserved.
//

#import "RMBSeriesProgressView.h"

#import "UIColor+RMBAdditions.h"

@interface RMBSeriesProgressView ()

@property (strong, nonatomic, readwrite) NSMutableArray<UIView *> *bubbles;
@property (assign, nonatomic, readwrite) CGFloat bubbleSize;
@property (assign, nonatomic, readwrite) CGFloat interItemSpacing;

@end

@implementation RMBSeriesProgressView

- (instancetype)initWithSize:(CGFloat)bubbleSize
            interItemSpacing:(CGFloat)interItemSpacing {
  if (self = [super init]) {
    _bubbleSize = bubbleSize;
    _interItemSpacing = interItemSpacing;
    _bubbles = [NSMutableArray array];
  }
  return self;
}


- (void)setTotalCount:(NSInteger)totalCount {
  _totalCount = totalCount;
  [self update];
}

- (void)update {
  [self.bubbles removeAllObjects];
  for (UIView *view in self.subviews) {
    [view removeFromSuperview];
  }
  CGFloat left = 0;
  for (int i = 0; i < self.totalCount; i++) {
    UIView *bubble = [[UIView alloc] initWithFrame:CGRectMake(left, 0, self.bubbleSize, self.bubbleSize)];
    bubble.clipsToBounds = YES;
    bubble.layer.cornerRadius = self.bubbleSize / 2;
    bubble.backgroundColor = [UIColor renovatioBackground];
    [self.bubbles addObject:bubble];
    [self addSubview:bubble];
    left += self.bubbleSize + self.interItemSpacing;
  }
}

- (void)selectBubbleAtIndex:(NSInteger)index selected:(BOOL)selected {
  if (index >= self.bubbles.count) {
    return;
  }
  UIView *bubble = self.bubbles[index];
  bubble.tag = selected ? 1 : 0;
  [self resetBackgroundColorOfBubbleAtIndex:index];
}

- (void)resetBackgroundColorOfBubbleAtIndex:(NSInteger)index {
  UIView *bubble = self.bubbles[index];
  bubble.backgroundColor = bubble.tag == 1 ? [UIColor renovatioRed] : [UIColor renovatioBackground];
}

- (void)resetBackgroundColors {
  for (int i = 0; i < self.bubbles.count; i++) {
    [self resetBackgroundColorOfBubbleAtIndex:i];
  }
}

//- (void)setBackgroundColor:(UIColor *)backgroundColor {
//  if (CGColorGetAlpha(backgroundColor.CGColor) != 0) {
//    [super setBackgroundColor:backgroundColor];
//  }
//}
//
//- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
////  UIColor *progressBarColor = self.progressBar.backgroundColor;
////  UIColor *progressBarBackgroundColor = self.progressBarBackground.backgroundColor;
////  [super setSelected:selected animated:animated];
////
////  if (selected) {
////    self.progressBar.backgroundColor = progressBarColor;
////    self.progressBarBackground.backgroundColor = progressBarBackgroundColor;
////  }
//}
//
//- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
//  UIColor *progressBarColor = self.progressBar.backgroundColor;
//  UIColor *progressBarBackgroundColor = self.progressBarBackground.backgroundColor;
//  [super setHighlighted:highlighted animated:animated];
//
//  if (highlighted) {
//    self.progressBar.backgroundColor = progressBarColor;
//    self.progressBarBackground.backgroundColor = progressBarBackgroundColor;
//  }
//}

@end
