//
//  RMBBookmarkView.m
//  Rememberance
//
//  Created by Aly Ibrahim on 8/2/18.
//  Copyright © 2018 Aly Ibrahim. All rights reserved.
//

#import "RMBBookmarkView.h"
#import "UIView+RMBAdditions.h"
@interface RMBBookmarkView ()

@property (strong, nonatomic, readwrite) UIImageView *imageView;
@property (assign, nonatomic, readwrite) CGFloat size;

@end

@implementation RMBBookmarkView

- (instancetype)initWithSize:(CGFloat)size {
  if (self = [super initWithFrame:CGRectMake(0, 0, size, size)]) {
    _size = size;
    _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"star_unhighlighted"]];
    _imageView.frame = CGRectMake(0, 0, size, size);
    _imageView.hidden = YES;
    [self addSubview:_imageView];
  }
  return self;
}
- (void)setBookmarked:(BOOL)bookmarked {
  [self setBookmarked:bookmarked animated:NO];
}

- (void)setBookmarked:(BOOL)bookmarked animated:(BOOL)animated {
  self.imageView.hidden = NO;
  CGFloat initialDuration = .3;
  CGFloat finalDuration = .05;
  CGPoint center = CGPointMake(self.size / 2, self.size / 2);
  
  CGSize hiddenSize = CGSizeMake(0, 0);
  CGSize expandedSize = CGSizeMake(self.size * 1.2, self.size * 1.2);
  CGSize finalSize = CGSizeMake(self.size, self.size);
  
  if (!animated) {
    self.imageView.size = bookmarked ? finalSize : hiddenSize;
    self.imageView.center = center;
    return;
  }
  if (bookmarked) {
    self.imageView.size = hiddenSize;
    self.imageView.center = center;
    [UIView animateWithDuration:initialDuration animations:^{
      self.imageView.size = expandedSize;
      self.imageView.center = center;
    } completion:^(BOOL finished) {
      [UIView animateWithDuration:finalDuration animations:^{
        self.imageView.size = finalSize;
        self.imageView.center = center;
      }];
    }];
  } else {
    self.imageView.size = finalSize;
    self.imageView.center = center;
    [UIView animateWithDuration:finalDuration animations:^{
      self.imageView.size = expandedSize;
      self.imageView.center = center;
    } completion:^(BOOL finished) {
      [UIView animateWithDuration:initialDuration animations:^{
        self.imageView.size = hiddenSize;
        self.imageView.center = center;
      }];
    }];
  }
}

@end
