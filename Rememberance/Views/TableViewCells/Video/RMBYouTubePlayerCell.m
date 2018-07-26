//
//  RMBYouTubePlayerCell.m
//  Rememberance
//
//  Created by Aly Ibrahim on 7/20/18.
//  Copyright © 2018 Aly Ibrahim. All rights reserved.
//

#import "RMBYouTubePlayerCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

#import "YTPlayerView.h"
#import "Masonry.h"
#import "UIView+RMBAdditions.h"

@interface RMBYouTubePlayerCell ()

@property (strong, nonatomic, readwrite) YTPlayerView *player;
@property (strong, nonatomic, readwrite) UIImageView *placeholder;
@property (strong, nonatomic, readwrite) UIActivityIndicatorView *activityIndicator;

@end

@implementation RMBYouTubePlayerCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
  if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    self.player = [[YTPlayerView alloc] initWithFrame:CGRectZero];
    self.player.hidden = YES;
    [self.contentView addSubview:self.player];
   
    self.placeholder = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.placeholder.contentMode = UIViewContentModeScaleAspectFit;
    self.placeholder.backgroundColor = [UIColor blackColor];
    [self.contentView addSubview:self.placeholder];

    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:self.activityIndicator];

    [self.placeholder mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.equalTo(@0);
      make.left.equalTo(@0);
      make.width.equalTo(self.contentView.mas_width);
      make.height.equalTo(self.contentView.mas_height);
    }];

    [self.player mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.equalTo(@0);
      make.left.equalTo(@0);
      make.width.equalTo(self.contentView.mas_width);
      make.height.equalTo(self.contentView.mas_height);
    }];
    
    [self.activityIndicator mas_makeConstraints:^(MASConstraintMaker *make) {
      make.center.equalTo(self.contentView);
    }];
  }
  return self;
}

- (void)setVideo:(RMBVideo *)video {
  _video = video;
  
  [self.placeholder sd_setImageWithURL:self.video.imageMediumURL];
  [self.activityIndicator startAnimating];
  [self setNeedsLayout];
}

- (void)onVideoReady {
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    self.placeholder.hidden = YES;
    self.player.hidden = NO;
    [self.activityIndicator stopAnimating];
  });
}

@end
