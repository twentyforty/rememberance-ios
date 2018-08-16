//
//  RMBBookmarkView.m
//  Rememberance
//
//  Created by Aly Ibrahim on 8/2/18.
//  Copyright © 2018 Aly Ibrahim. All rights reserved.
//

#import "RMBBookmarkView.h"
#import "UIView+RMBAdditions.h"
#import "UIColor+RMBAdditions.h"
#import "UIImage+RMBAdditions.h"

@interface RMBBookmarkView ()

@property (strong, nonatomic, readwrite) UIImageView *imageView;
@property (assign, nonatomic, readwrite) CGFloat size;
@property (assign, nonatomic, readwrite) BOOL permanent;
@property (strong, nonatomic, readwrite) UIImage *highlightedImage;
@property (strong, nonatomic, readwrite) UIImage *unhighlightedImage;

@end

@implementation RMBBookmarkView

- (instancetype)initWithSize:(CGFloat)size permanent:(BOOL)permanent {
  if (self = [super initWithFrame:CGRectMake(0, 0, size, size)]) {
    _size = size;
    UIImage *bookmarkImage = [UIImage imageNamed:@"star_unhighlighted"];
    _highlightedImage = [bookmarkImage imageTintedWithColor:[UIColor renovatioRed]];
    _unhighlightedImage = [bookmarkImage imageTintedWithColor:[UIColor lightGrayColor]];
    _imageView = [[UIImageView alloc] initWithImage:_unhighlightedImage];
    _imageView.frame = CGRectMake(0, 0, size, size);
    _permanent = permanent;
//    _imageView.hidden = !permanent;
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
  CGSize fullSize = CGSizeMake(self.size, self.size);
  CGSize finalSize;
  
  if (self.permanent || bookmarked) {
    finalSize = fullSize;
  } else {
    finalSize = hiddenSize;
  }

  if (!animated) {
    self.imageView.size = finalSize;
    self.imageView.center = center;
    if (bookmarked) {
      self.imageView.image = self.highlightedImage;
    } else {
      self.imageView.image = self.unhighlightedImage;
    }
    return;
  }
  if (bookmarked) {
    [UIView animateWithDuration:initialDuration animations:^{
      self.imageView.size = expandedSize;
      self.imageView.center = center;
    } completion:^(BOOL finished) {
      [UIView animateWithDuration:finalDuration animations:^{
        self.imageView.size = finalSize;
        self.imageView.center = center;
        self.imageView.image = self.highlightedImage;
      }];
    }];
  } else {
    [UIView animateWithDuration:initialDuration animations:^{
      self.imageView.size = expandedSize;
      self.imageView.center = center;
    } completion:^(BOOL finished) {
      [UIView animateWithDuration:finalDuration animations:^{
        self.imageView.size = finalSize;
        self.imageView.center = center;
        self.imageView.image = self.unhighlightedImage;
      }];
    }];
  }
}

@end
