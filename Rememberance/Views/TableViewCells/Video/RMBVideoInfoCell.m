//
//  RMBVideoInfoCell.m
//  Rememberance
//
//  Created by Aly Ibrahim on 8/3/18.
//  Copyright © 2018 Aly Ibrahim. All rights reserved.
//

#import "RMBVideoInfoCell.h"
#import "Masonry.h"
#import "RMBBookmarkView.h"
#import "UIImage+RMBAdditions.h"

@interface RMBVideoInfoCell ()

@property (strong, nonatomic, readwrite) UILabel *titleLabel;
@property (strong, nonatomic, readwrite) UILabel *descriptionLabel;
@property (strong, nonatomic, readwrite) UIImageView *expandImageView;
@property (strong, nonatomic) RMBBookmarkView *bookmarkView;
@property (assign, nonatomic, readwrite) BOOL canExpand;
@property (assign, nonatomic, readwrite) BOOL expanded;

@end

@implementation RMBVideoInfoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
  if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    self.titleLabel.numberOfLines = 3;
    self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [self.contentView addSubview:self.titleLabel];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.equalTo(self.contentView).offset(16);
      make.top.equalTo(self.contentView).offset(16);
      make.right.equalTo(self.contentView).offset(-56);
    }];
    
    self.bookmarkView = [[RMBBookmarkView alloc] initWithSize:24 permanent:YES];
    [self.contentView addSubview:self.bookmarkView];
    
    [self.bookmarkView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bookmarkViewTapped)]];
    
    [self.bookmarkView mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.equalTo(self.contentView).offset(16);
      make.right.equalTo(self.contentView).offset(-16);
      make.width.equalTo(@(24));
      make.height.equalTo(@(24));
    }];
    
    self.descriptionLabel = [[UILabel alloc] init];
    self.descriptionLabel.font = [UIFont systemFontOfSize:12];
    self.descriptionLabel.textColor = [UIColor darkGrayColor];
    self.descriptionLabel.numberOfLines = 0;
    self.descriptionLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [self.contentView addSubview:self.descriptionLabel];

    [self.descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.equalTo(self.contentView).offset(16);
      make.top.greaterThanOrEqualTo(self.bookmarkView.mas_bottom).offset(8);
      make.top.greaterThanOrEqualTo(self.titleLabel.mas_bottom).offset(8);
      make.right.equalTo(self.contentView).offset(-16);
      make.bottom.equalTo(self.contentView).offset(-16);
      make.height.lessThanOrEqualTo(@(80));
    }];
    
    self.expandImageView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"expand"] imageTintedWithColor:[UIColor lightGrayColor]]];
    self.expandImageView.hidden = YES;
    [self.contentView addSubview:self.expandImageView];
  }
  return self;
}

- (void)updateConstraints {
  [self.descriptionLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.contentView).offset(16);
    make.top.greaterThanOrEqualTo(self.bookmarkView.mas_bottom).offset(8);
    make.top.greaterThanOrEqualTo(self.titleLabel.mas_bottom).offset(8);
    make.right.equalTo(self.contentView).offset(-16);
    if (self.canExpand) {
      if (self.expanded) {
        make.bottom.equalTo(self.contentView).offset(-16);
      } else {
        make.height.lessThanOrEqualTo(@(80));
      }
    } else {
      make.bottom.equalTo(self.contentView).offset(-16);
    }
  }];
  
  if ([self.expandImageView superview] == self.contentView && self.canExpand && !self.expanded) {
    [self.expandImageView mas_makeConstraints:^(MASConstraintMaker *make) {
      make.width.equalTo(@(18));
      make.height.equalTo(@(18));
      make.top.equalTo(self.descriptionLabel.mas_bottom).offset(4);
      make.bottom.equalTo(self.contentView).offset(-8);
      make.right.equalTo(self.contentView).offset(-16);
    }];
  }

  [super updateConstraints];
}

- (void)expand {
  if (!self.canExpand) {
    return;
  }
  self.expanded = YES;
  [self.expandImageView removeFromSuperview];
  [self setNeedsUpdateConstraints];
}

- (void)bookmarkViewTapped {
  if ([self.video.bookmarkedByMe boolValue]) {
    [self.video unbookmark];
  } else {
    [self.video bookmark];
  }
  [self.bookmarkView setBookmarked:[self.video.bookmarkedByMe boolValue] animated:YES];
}

- (void)setVideo:(RMBVideo *)video {
  _video = video;
  self.titleLabel.text = video.title;
  self.descriptionLabel.text = video.videoDescription;
  self.bookmarkView.bookmarked = [self.video.bookmarkedByMe boolValue];
  
  if ([self.descriptionLabel sizeThatFits:CGSizeMake(self.descriptionLabel.frame.size.width, 10000)].height > 80) {
    self.canExpand = YES;
    self.expandImageView.hidden = NO;
  }
  
  [self setNeedsUpdateConstraints];
}

@end
