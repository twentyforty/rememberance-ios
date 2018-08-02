//
//  RMBScholarAvatarsView.m
//  Rememberance
//
//  Created by Aly Ibrahim on 8/1/18.
//  Copyright © 2018 Aly Ibrahim. All rights reserved.
//

#import "RMBScholarAvatarsView.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "Masonry.h"
#import "UIColor+RMBAdditions.h"

@interface RMBScholarAvatarsView ()

@property (assign, nonatomic, readwrite) CGFloat avatarSize;
@property (assign, nonatomic, readwrite) CGFloat interItemSpacing;

@end

@implementation RMBScholarAvatarsView

- (instancetype)initWithSize:(CGFloat)avatarSize
            interItemSpacing:(CGFloat)interItemSpacing {
  if (self = [super init]) {
    _avatarSize = avatarSize;
    _interItemSpacing = interItemSpacing;
  }
  return self;
}

- (void)setScholars:(NSArray<RMBScholar *> *)scholars {
  for (UIView *view in self.subviews) {
    [view removeFromSuperview];
  }
  CGFloat left = 0;
  for (RMBScholar *scholar in scholars) {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(left, 0, self.avatarSize, self.avatarSize)];
    imageView.clipsToBounds = YES;
    imageView.layer.cornerRadius = self.avatarSize / 2;
    imageView.layer.borderColor = [UIColor renovatioRed].CGColor;
    imageView.layer.borderWidth = 2;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [imageView sd_setImageWithURL:scholar.imageURL completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
      
    }];
    [self addSubview:imageView];
    left += self.avatarSize + self.interItemSpacing;
  }
}

+ (CGFloat)widthWithScholars:(NSArray<RMBScholar *> *)scholars
                        size:(CGFloat)avatarSize
            interItemSpacing:(CGFloat)interItemSpacing {
  return scholars.count * avatarSize + (scholars.count - 1) * interItemSpacing;
}

@end
