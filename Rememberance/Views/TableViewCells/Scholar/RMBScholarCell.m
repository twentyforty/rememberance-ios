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
#import "RMBBookmarkView.h"
#import "UIImage+RMBAdditions.h"

@interface RMBScholarCell () <MGSwipeTableCellDelegate>

@property (strong, nonatomic, readwrite) UIImageView *scholarImageView;
@property (strong, nonatomic, readwrite) UILabel *scholarNameLabel;
@property (strong, nonatomic, readwrite) RMBBookmarkView *bookmarkView;

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
    
    self.bookmarkView = [[RMBBookmarkView alloc] initWithSize:16 permanent:NO];
    [self.contentView addSubview:self.bookmarkView];
    [self.bookmarkView mas_makeConstraints:^(MASConstraintMaker *make) {
      make.centerY.equalTo(self.contentView);
      make.right.equalTo(self.contentView).offset(-16);
      make.width.equalTo(@(16));
      make.height.equalTo(@(16));
    }];
    
    MGSwipeButton *button = [MGSwipeButton buttonWithTitle:@"" icon:[[UIImage imageNamed:@"star_unhighlighted"] imageTintedWithColor:[UIColor renovatioRed]]
                                           backgroundColor:[UIColor renovatioBackground]];
    button.imageView.contentMode = UIViewContentModeScaleAspectFit;
    button.buttonWidth = 44;
    self.rightButtons = @[button];
    self.rightSwipeSettings.transition = MGSwipeTransitionDrag;
    self.rightSwipeSettings.keepButtonsSwiped = NO;
    self.delegate = self;
  }
  return self;
}

- (void)swipeTableCellWillEndSwiping:(MGSwipeTableCell *)cell {
  if ([self.scholar.bookmarkedByMe boolValue]) {
    [self.scholar unbookmark];
  } else {
    [self.scholar bookmark];
  }
  [self.bookmarkView setBookmarked:[self.scholar.bookmarkedByMe boolValue] animated:YES];
}

- (void)layoutSubviews {
  [super layoutSubviews];
}

- (void)setScholar:(RMBScholar *)scholar {
  _scholar = scholar;
  self.scholarNameLabel.text = scholar.name;
  [self.scholarImageView sd_setImageWithURL:scholar.imageURL placeholderImage:[UIImage imageNamed:@"gray_placeholder"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
    [self setNeedsLayout];
  }];
  self.bookmarkView.bookmarked = [self.scholar.bookmarkedByMe boolValue];
}

@end
