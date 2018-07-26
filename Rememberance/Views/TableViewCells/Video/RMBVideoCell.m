//
//  RMBVideoCell.m
//  Rememberance
//
//  Created by Aly Ibrahim on 7/19/18.
//  Copyright © 2018 Aly Ibrahim. All rights reserved.
//

#import "RMBVideoCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "Masonry.h"

@interface RMBVideoCell ()

@property (strong, nonatomic, readwrite) UIImageView *videoImageView;
@property (strong, nonatomic, readwrite) UILabel *videoTitleLabel;
@property (strong, nonatomic, readwrite) UILabel *durationLabel;
@property (strong, nonatomic, readwrite) UIView *progressBarBackground;
@property (strong, nonatomic, readwrite) UIView *progressBar;

@end


@implementation RMBVideoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
  if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    self.videoImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.videoImageView];
    
    [self.videoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
      make.width.equalTo(@(120));
      make.height.equalTo(@(90));
      make.left.equalTo(self.contentView.mas_left).with.offset(16);
      make.top.equalTo(self.contentView.mas_top).with.offset(8);
      make.bottom.equalTo(self.contentView.mas_bottom).with.offset(-8);
    }];
    
    self.progressBarBackground = [[UIView alloc] initWithFrame:CGRectZero];
    self.progressBarBackground.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.8];
    self.progressBarBackground.hidden = YES;
    [self.contentView addSubview:self.progressBarBackground];
    
    [self.progressBarBackground mas_makeConstraints:^(MASConstraintMaker *make) {
      make.right.equalTo(self.videoImageView).offset(-1);
      make.height.equalTo(@(4));
      make.left.equalTo(self.videoImageView).offset(-1);
      make.bottom.equalTo(self.videoImageView);
    }];
    
    self.progressBar = [[UIView alloc] initWithFrame:CGRectZero];
    self.progressBar.backgroundColor = [UIColor redColor];
    [self.progressBarBackground addSubview:self.progressBar];

    self.videoTitleLabel = [[UILabel alloc] init];
    self.videoTitleLabel.font = [UIFont systemFontOfSize:12];
    self.videoTitleLabel.numberOfLines = 3;
    self.videoTitleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [self.contentView addSubview:self.videoTitleLabel];
    
    [self.videoTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.equalTo(self.videoImageView.mas_right).offset(8);
      make.top.equalTo(self.videoImageView);
      make.right.equalTo(self.contentView).offset(-8);
    }];
    
    self.durationLabel = [[UILabel alloc] init];
    self.durationLabel.textColor = [UIColor darkGrayColor];
    self.durationLabel.font = [UIFont systemFontOfSize:10];
    [self.contentView addSubview:self.durationLabel];
    
    [self.durationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.equalTo(self.videoTitleLabel);
      make.top.equalTo(self.videoTitleLabel.mas_bottom).offset(4);
    }];
  }
  return self;
}

- (void)setVideo:(RMBVideo *)video {
  _video = video;
  self.videoTitleLabel.text = video.title;
  
  long duration = [self.video.duration longValue];
  NSDate *date = [NSDate dateWithTimeIntervalSince1970:duration];
  NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
  [formatter setDateFormat:@"HH:mm:ss"];
  [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];

  self.durationLabel.text = [NSString stringWithFormat:@"Duration: %@", [formatter stringFromDate:date]];
  [self.imageView sd_setImageWithURL:video.imageSmallURL placeholderImage:[UIImage imageNamed:@"gray_placeholder"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
    [self setNeedsLayout];
  }];
  
  if (self.video.progressPercentage > 0) {
    self.progressBarBackground.hidden = NO;
    self.progressBar.frame = CGRectMake(0, 0, self.video.progressPercentage * 120, 4);
  } else {
    self.progressBarBackground.hidden = YES;
  }
  [self setNeedsLayout];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
  UIColor *progressBarColor = self.progressBar.backgroundColor;
  UIColor *progressBarBackgroundColor = self.progressBarBackground.backgroundColor;
  [super setSelected:selected animated:animated];
  
  if (selected) {
    self.progressBar.backgroundColor = progressBarColor;
    self.progressBarBackground.backgroundColor = progressBarBackgroundColor;
  }
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
  UIColor *progressBarColor = self.progressBar.backgroundColor;
  UIColor *progressBarBackgroundColor = self.progressBarBackground.backgroundColor;
  [super setHighlighted:highlighted animated:animated];
  
  if (highlighted) {
    self.progressBar.backgroundColor = progressBarColor;
    self.progressBarBackground.backgroundColor = progressBarBackgroundColor;
  }
}

@end
