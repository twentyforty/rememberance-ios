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
#import "UIColor+RMBAdditions.h"
#import "RMBScholarAvatarsView.h"
#import "RMBBookmarkView.h"

@interface RMBVideoCell () <MGSwipeTableCellDelegate>

@property (strong, nonatomic, readwrite) UIImageView *videoImageView;
@property (strong, nonatomic, readwrite) UIView *completedIndicator;
@property (strong, nonatomic, readwrite) RMBBookmarkView *bookmarkImageView;
@property (strong, nonatomic, readwrite) UILabel *videoTitleLabel;
@property (strong, nonatomic, readwrite) UIView *durationBackground;
@property (strong, nonatomic, readwrite) UILabel *durationLabel;
@property (strong, nonatomic, readwrite) UIView *progressBarBackground;
@property (strong, nonatomic, readwrite) UIView *progressBar;
@property (strong, nonatomic, readwrite) RMBScholarAvatarsView *scholarAvatarsView;

@end


@implementation RMBVideoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
  if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    self.videoImageView = [[UIImageView alloc] init];
    self.videoImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:self.videoImageView];
    
    [self.videoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
      make.width.equalTo(@(120));
      make.height.equalTo(@(90));
      make.left.equalTo(self.contentView.mas_left).with.offset(16);
      make.top.equalTo(self.contentView.mas_top).with.offset(8);
      make.bottom.equalTo(self.contentView.mas_bottom).with.offset(-8);
    }];
    
    self.progressBarBackground = [[UIView alloc] initWithFrame:CGRectZero];
    self.progressBarBackground.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.9];
    self.progressBarBackground.hidden = YES;
    [self.contentView addSubview:self.progressBarBackground];
    
    [self.progressBarBackground mas_makeConstraints:^(MASConstraintMaker *make) {
      make.width.equalTo(@(120));
      make.height.equalTo(@(4));
      make.left.equalTo(self.contentView.mas_left).with.offset(16);
      make.top.equalTo(self.contentView.mas_bottom).with.offset(-12);
      make.bottom.equalTo(self.contentView.mas_bottom).with.offset(-8);
    }];
    
    self.progressBar = [[UIView alloc] initWithFrame:CGRectZero];
    self.progressBar.backgroundColor = [UIColor redColor];
    [self.progressBarBackground addSubview:self.progressBar];

    self.completedIndicator = [[UIView alloc] init];
    self.completedIndicator.backgroundColor = [UIColor renovatioBackground];
    self.completedIndicator.clipsToBounds = YES;
    self.completedIndicator.layer.cornerRadius = 8;
    [self.contentView addSubview:self.completedIndicator];
    
    [self.completedIndicator mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.equalTo(self.videoImageView);
      make.right.equalTo(self.contentView).offset(-8);
      make.width.equalTo(@16);
      make.height.equalTo(@16);
    }];

    self.bookmarkImageView = [[RMBBookmarkView alloc] initWithSize:16];
    self.bookmarkImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:self.bookmarkImageView];
    [self.bookmarkImageView mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.equalTo(self.completedIndicator.mas_bottom).offset(8);
      make.right.equalTo(self.contentView).offset(-8);
      make.width.equalTo(@(16));
      make.height.equalTo(@(16));
    }];

    self.videoTitleLabel = [[UILabel alloc] init];
    self.videoTitleLabel.font = [UIFont systemFontOfSize:12];
    self.videoTitleLabel.numberOfLines = 3;
    self.videoTitleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [self.contentView addSubview:self.videoTitleLabel];
    
    [self.videoTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.equalTo(self.videoImageView.mas_right).offset(8);
      make.top.equalTo(self.videoImageView);
      make.right.equalTo(self.completedIndicator.mas_left).offset(-8);
    }];
    
    self.scholarAvatarsView = [[RMBScholarAvatarsView alloc] initWithSize:32.0 interItemSpacing:-6.0];
    [self.contentView addSubview:self.scholarAvatarsView];

    self.durationBackground = [[UIView alloc] init];
    self.durationBackground.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.8];
    self.durationBackground.layer.cornerRadius = 3;
    self.durationBackground.clipsToBounds = YES;
    [self.contentView addSubview:self.durationBackground];
    
    self.durationLabel = [[UILabel alloc] init];
    self.durationLabel.textColor = [UIColor whiteColor];
    self.durationLabel.font = [UIFont systemFontOfSize:10];
    [self.durationBackground addSubview:self.durationLabel];
    
    [self.durationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
      make.edges.equalTo(self.durationBackground).with.insets(UIEdgeInsetsMake(3, 4, 3, 4));
    }];
    
    //configure right buttons
    MGSwipeButton *button = [MGSwipeButton buttonWithTitle:@"" icon:[UIImage imageNamed:@"star_unhighlighted"] backgroundColor:[UIColor renovatioBackground]];
    button.imageView.contentMode = UIViewContentModeScaleAspectFit;
    button.buttonWidth = 44;
    self.rightButtons = @[button];
    self.rightSwipeSettings.transition = MGSwipeTransitionDrag;
    self.rightSwipeSettings.keepButtonsSwiped = NO;
    self.delegate = self;
  }
  return self;
}

- (void)setVideo:(RMBVideo *)video {
  _video = video;
  self.videoTitleLabel.text = video.title;
  self.completedIndicator.backgroundColor = [self.video.progress.completed boolValue] ? [UIColor renovatioRed] : [UIColor renovatioBackground];
  self.durationLabel.text = self.video.lengthString;
  self.scholarAvatarsView.scholars = self.video.scholars;
  [self.scholarAvatarsView mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.height.equalTo(@32);
    CGFloat width = [RMBScholarAvatarsView widthWithScholars:self.video.scholars
                                                        size:32.0
                                            interItemSpacing:-6.0];
    make.width.equalTo(@(width > 10 ? width : 0));
    make.right.equalTo(self.completedIndicator.mas_left).offset(-8);
    make.top.greaterThanOrEqualTo(self.videoTitleLabel.mas_bottom).offset(10);
    make.bottom.equalTo(self.contentView).offset(-8);
  }];
  self.bookmarkImageView.bookmarked = [video.bookmarkedByMe boolValue];

  [self.videoImageView sd_setImageWithURL:video.imageSmallURL placeholderImage:[UIImage imageNamed:@"gray_placeholder"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
  }];
  [self updateProgressBar];
}

- (void)updateProgressBar {
  if (self.video.progressPercentage > 0) {
    self.progressBarBackground.hidden = NO;
    self.progressBar.frame = CGRectMake(0, 0, self.video.progressPercentage * 120, 4);
  } else {
    self.progressBarBackground.hidden = YES;
  }
  
  [self.durationBackground mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.right.equalTo(self.videoImageView.mas_right).offset(-2);
    if (self.progressBarBackground.hidden) {
      make.bottom.equalTo(self.videoImageView.mas_bottom).offset(-2);
    } else {
      make.bottom.equalTo(self.progressBarBackground.mas_top).offset(-2);
    }
  }];

  [self setNeedsLayout];
}

- (void)swipeTableCellWillEndSwiping:(MGSwipeTableCell *)cell {
  if ([self.video.bookmarkedByMe boolValue]) {
    [self.video unbookmark];
  } else {
    [self.video bookmark];
  }
  [self.bookmarkImageView setBookmarked:[self.video.bookmarkedByMe boolValue] animated:YES];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
  UIColor *progressBarColor = self.progressBar.backgroundColor;
  UIColor *progressBarBackgroundColor = self.progressBarBackground.backgroundColor;
  UIColor *durationBackgroundColor = self.durationBackground.backgroundColor;
  UIColor *completedIndicatorBackgroundColor = self.completedIndicator.backgroundColor;
  [super setSelected:selected animated:animated];
  
  if (selected) {
    self.progressBar.backgroundColor = progressBarColor;
    self.progressBarBackground.backgroundColor = progressBarBackgroundColor;
    self.durationBackground.backgroundColor = durationBackgroundColor;
    self.completedIndicator.backgroundColor = completedIndicatorBackgroundColor;
  }
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
  UIColor *progressBarColor = self.progressBar.backgroundColor;
  UIColor *progressBarBackgroundColor = self.progressBarBackground.backgroundColor;
  UIColor *durationBackgroundColor = self.durationBackground.backgroundColor;
  UIColor *completedIndicatorBackgroundColor = self.completedIndicator.backgroundColor;
  [super setHighlighted:highlighted animated:animated];
  
  if (highlighted) {
    self.progressBar.backgroundColor = progressBarColor;
    self.progressBarBackground.backgroundColor = progressBarBackgroundColor;
    self.durationBackground.backgroundColor = durationBackgroundColor;
    self.completedIndicator.backgroundColor = completedIndicatorBackgroundColor;
  }
}

@end
