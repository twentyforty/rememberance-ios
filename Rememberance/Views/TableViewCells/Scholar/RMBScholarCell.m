//
//  RMBScholarCell.m
//  Rememberance
//
//  Created by Aly Ibrahim on 7/19/18.
//  Copyright © 2018 Aly Ibrahim. All rights reserved.
//

#import "RMBScholarCell.h"

#import <SDWebImage/UIImageView+WebCache.h>
#import "UIColor+RMBAdditions.h"
#import "UIView+RMBAdditions.h"
#import "Masonry.h"

@interface RMBScholarCell () <MGSwipeTableCellDelegate>

@property (strong, nonatomic, readwrite) UIImageView *scholarImageView;
@property (strong, nonatomic, readwrite) UILabel *scholarNameLabel;

@end

@implementation RMBScholarCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
  if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    self.scholarImageView = [[UIImageView alloc] init];
    self.scholarImageView.clipsToBounds = YES;
    self.scholarImageView.layer.borderColor = [UIColor renovatioRed].CGColor;
    self.scholarImageView.layer.borderWidth = 2;
    self.scholarImageView.layer.cornerRadius = 20;
    self.scholarImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:self.scholarImageView];

    [self.scholarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
      make.width.equalTo(@(40));
      make.height.equalTo(@(40));
      make.left.equalTo(self.contentView).with.offset(16);
      make.top.equalTo(self.contentView).with.offset(4);
      make.bottom.equalTo(self.contentView).with.offset(-4);
    }];
    
    self.scholarNameLabel = [[UILabel alloc] init];
    self.scholarNameLabel.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:self.scholarNameLabel];
    
    [self.scholarNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.equalTo(self.scholarImageView.mas_right).offset(8);
      make.centerY.equalTo(self.contentView);
    }];
  }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
}

- (void)setScholar:(RMBScholar *)scholar {
  self.scholarNameLabel.text = scholar.name;
  [self.scholarImageView sd_setImageWithURL:scholar.imageURL placeholderImage:[UIImage imageNamed:@"gray_placeholder"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
    [self setNeedsLayout];
  }];
}

@end
