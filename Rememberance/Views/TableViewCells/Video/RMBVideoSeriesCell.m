//
//  RMBVIdeoSeriesCell.m
//  Rememberance
//
//  Created by Aly Ibrahim on 7/19/18.
//  Copyright © 2018 Aly Ibrahim. All rights reserved.
//

#import "RMBVideoSeriesCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "Masonry.h"
#import "RMBScholarAvatarsView.h"
#import "RMBSeriesProgressView.h"
#import "UIColor+RMBAdditions.h"
#import "RMBBookmarkView.h"
#import "UIImage+RMBAdditions.h"

@interface RMBVideoSeriesCell () <MGSwipeTableCellDelegate>

@property (strong, nonatomic, readwrite) UILabel *headerLabel;
@property (strong, nonatomic, readwrite) UIImageView *videoImageView;
@property (strong, nonatomic, readwrite) RMBBookmarkView *bookmarkView;
@property (strong, nonatomic, readwrite) UILabel *videoSeriesTitleLabel;
@property (strong, nonatomic, readwrite) UILabel *currentVideoLabel;
@property (strong, nonatomic, readwrite) RMBSeriesProgressView *progressView;
@property (strong, nonatomic, readwrite) RMBScholarAvatarsView *scholarAvatarsView;

@end


@implementation RMBVideoSeriesCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
  if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    self.videoImageView = [[UIImageView alloc] init];
    self.videoImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:self.videoImageView];
    
    [self.videoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
      make.width.equalTo(@(120));
      make.height.equalTo(@(90));
      make.left.equalTo(self.contentView.mas_left).with.offset(16);
      make.top.equalTo(self.contentView.mas_top).with.offset(8);
      make.bottom.lessThanOrEqualTo(self.contentView.mas_bottom).with.offset(-8);
    }];
    
    self.bookmarkView = [[RMBBookmarkView alloc] initWithSize:16 permanent:NO];
    [self.contentView addSubview:self.bookmarkView];
    [self.bookmarkView mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.equalTo(self.videoImageView);
      make.right.equalTo(self.contentView).offset(-16);
      make.width.equalTo(@(16));
      make.height.equalTo(@(16));
    }];
    
    self.videoSeriesTitleLabel = [[UILabel alloc] init];
    self.videoSeriesTitleLabel.font = [UIFont systemFontOfSize:12];
    self.videoSeriesTitleLabel.numberOfLines = 3;
    self.videoSeriesTitleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [self.contentView addSubview:self.videoSeriesTitleLabel];
    
    [self.videoSeriesTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.equalTo(self.videoImageView.mas_right).offset(8);
      make.top.equalTo(self.videoImageView);
      make.right.equalTo(self.bookmarkView.mas_left).offset(-8);
    }];
    
    self.currentVideoLabel = [[UILabel alloc] init];
    self.currentVideoLabel.textColor = [UIColor darkGrayColor];
    self.currentVideoLabel.font = [UIFont systemFontOfSize:10];
    self.currentVideoLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    [self.contentView addSubview:self.currentVideoLabel];
    
    [self.currentVideoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.equalTo(self.videoSeriesTitleLabel);
      make.top.equalTo(self.videoSeriesTitleLabel.mas_bottom).offset(4);
      make.right.equalTo(self.contentView).offset(-8);
    }];
    
    self.progressView = [[RMBSeriesProgressView alloc] initWithSize:10.0 interItemSpacing:4.0];
    [self.contentView addSubview:self.progressView];
    [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
      make.height.equalTo(@(10));
      make.left.equalTo(self.currentVideoLabel);
      make.top.equalTo(self.currentVideoLabel.mas_bottom).offset(6);
      make.right.equalTo(self.contentView).offset(-8);
    }];
    
    self.scholarAvatarsView = [[RMBScholarAvatarsView alloc] initWithSize:32.0 interItemSpacing:-6.0];
    [self.contentView addSubview:self.scholarAvatarsView];
    [self.scholarAvatarsView mas_makeConstraints:^(MASConstraintMaker *make) {
      make.height.equalTo(@32);
      make.right.equalTo(self.contentView).offset(-8);
      make.left.equalTo(self.videoImageView.mas_right).offset(8);
      make.top.greaterThanOrEqualTo(self.progressView.mas_bottom).offset(10);
      make.bottom.equalTo(self.contentView).offset(-8);
    }];

    MGSwipeButton *button = [MGSwipeButton buttonWithTitle:@"" icon:[[UIImage imageNamed:@"star_unhighlighted"] imageTintedWithColor:[UIColor renovatioRed]] backgroundColor:[UIColor renovatioBackground]];
    button.imageView.contentMode = UIViewContentModeScaleAspectFit;
    button.buttonWidth = 44;
    self.rightButtons = @[button];
    self.rightSwipeSettings.transition = MGSwipeTransitionDrag;
    self.rightSwipeSettings.keepButtonsSwiped = NO;
    self.delegate = self;
  }
  return self;
}

- (void)setVideoSeries:(RMBVideoSeries *)videoSeries {
  _videoSeries = videoSeries;
  self.videoSeriesTitleLabel.text = videoSeries.title;
  
  self.currentVideoLabel.text = videoSeries.progressTitle;
  self.progressView.totalCount = [videoSeries.videoCount integerValue];
  for (NSNumber *index in videoSeries.completedVideoIndexes) {
    [self.progressView selectBubbleAtIndex:[index integerValue] selected:YES];
  }
  self.bookmarkView.bookmarked = [self.videoSeries.bookmarkedByMe boolValue];

  [self.videoImageView sd_setImageWithURL:videoSeries.imageURL placeholderImage:[UIImage imageNamed:@"gray_placeholder"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
    [self updateProgressBar];
  }];
  
  self.scholarAvatarsView.scholars = self.videoSeries.scholars;
}

- (void)swipeTableCellWillEndSwiping:(MGSwipeTableCell *)cell {
  if ([self.videoSeries.bookmarkedByMe boolValue]) {
    [self.videoSeries unbookmark];
  } else {
    [self.videoSeries bookmark];
  }
  [self.bookmarkView setBookmarked:[self.videoSeries.bookmarkedByMe boolValue] animated:YES];
}

- (void)updateProgressBar {
//  if (self.video.progressPercentage > 0) {
//    self.progressBarBackground.hidden = NO;
//    self.progressBar.frame = CGRectMake(0, 0, self.video.progressPercentage * 120, 4);
//  } else {
//    self.progressBarBackground.hidden = YES;
//  }
  [self setNeedsLayout];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
  [super setSelected:selected animated:animated];
  [self.progressView resetBackgroundColors];
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
  [super setHighlighted:highlighted animated:animated];
  [self.progressView resetBackgroundColors];
}

@end
