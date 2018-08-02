//
//  RMBScholarAvatarCell.m
//  Rememberance
//
//  Created by Aly Ibrahim on 7/31/18.
//  Copyright © 2018 Aly Ibrahim. All rights reserved.
//

#import "RMBScholarAvatarCell.h"
#import "UIColor+RMBAdditions.h"
#import "Masonry.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface RMBScholarAvatarCell ()

@property (strong, nonatomic, readwrite) UIImageView *scholarImageView;
@property (strong, nonatomic, readwrite) UILabel *scholarNameLabel;

@end

@implementation RMBScholarAvatarCell : UICollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    self.scholarImageView = [[UIImageView alloc] init];
    self.scholarImageView.clipsToBounds = YES;
    self.scholarImageView.layer.borderColor = [UIColor renovatioRed].CGColor;
    self.scholarImageView.layer.borderWidth = 1;
    self.scholarImageView.layer.cornerRadius = 12;
    self.scholarImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:self.scholarImageView];
    
    [self.scholarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
      make.width.equalTo(@(24));
      make.height.equalTo(@(24));
      make.left.equalTo(self.contentView).with.offset(2);
      make.top.equalTo(self.contentView).with.offset(2);
      make.bottom.equalTo(self.contentView).with.offset(-2);
      make.bottom.equalTo(self.contentView).with.offset(-2);
    }];
    
//    self.scholarNameLabel = [[UILabel alloc] init];
//    self.scholarNameLabel.font = [UIFont systemFontOfSize:16];
//    [self.contentView addSubview:self.scholarNameLabel];
//
//    [self.scholarNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//      make.left.equalTo(self.scholarImageView.mas_right).offset(8);
//      make.centerY.equalTo(self.contentView);
//    }];
  }
  return self;
}

- (void)setScholar:(RMBScholar *)scholar {
  _scholar = scholar;
  [self.scholarImageView sd_setImageWithURL:scholar.imageURL];
}

@end
