//
//  RMBScholarHeaderView.m
//  Rememberance
//
//  Created by Aly Ibrahim on 7/19/18.
//  Copyright © 2018 Aly Ibrahim. All rights reserved.
//

#import "RMBScholarHeaderView.h"
#import "UIView+RMBAdditions.h"
#import <Masonry/Masonry.h>
#import <GSKStretchyHeaderView/GSKGeometry.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "UIColor+RMBAdditions.h"
#import "RMBBookmarkView.h"
#import "UIImage+RMBAdditions.h"

static const CGSize kUserImageSize = {.width = 100, .height = 100};

@interface RMBScholarHeaderView ()

@property (nonatomic) UIImageView *backgroundImageView;
@property (nonatomic) UIImageView *scholarImageView;
@property (nonatomic) UILabel *scholarNameLabel;
@property (nonatomic) UIImageView *navBarImageView;
@property (nonatomic) UILabel *navBarTitle;
@property (nonatomic) UIButton *backButton;
@property (nonatomic) RMBBookmarkView *bookmarkView;

@end

@implementation RMBScholarHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    self.minimumContentHeight = 64;
    self.maximumContentHeight = 200;
    [self setupViews];
    [self setupViewConstraints];
  }
  return self;
}

- (void)setScholar:(RMBScholar *)scholar {
  _scholar = scholar;
  [self.scholarImageView sd_setImageWithURL:scholar.imageURL];
  [self.navBarImageView sd_setImageWithURL:scholar.imageURL];
  self.scholarNameLabel.text = scholar.name;
  self.navBarTitle.text = scholar.name;
  self.bookmarkView.bookmarked = [scholar.bookmarkedByMe boolValue];
}

- (void)setupViews {
  UIImage *backgroundImage = nil; //[UIImage imageNamed:@"islamic_background"];
  self.backgroundImageView = [[UIImageView alloc] initWithImage:backgroundImage];
  self.backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
  self.backgroundImageView.backgroundColor = [UIColor renovatioBackground];
  [self.contentView addSubview:self.backgroundImageView];
  
  self.scholarImageView = [[UIImageView alloc] init];
  self.scholarImageView.clipsToBounds = YES;
  self.scholarImageView.layer.cornerRadius = kUserImageSize.width / 2;
  self.scholarImageView.layer.borderColor = [UIColor renovatioRed].CGColor;
  self.scholarImageView.layer.borderWidth = 4;
  self.scholarImageView.contentMode = UIViewContentModeScaleAspectFill;
  [self.contentView addSubview:self.scholarImageView];
  
  self.navBarImageView = [[UIImageView alloc] init];
  self.navBarImageView.clipsToBounds = YES;
  self.navBarImageView.layer.borderColor = [UIColor renovatioRed].CGColor;
  self.navBarImageView.layer.borderWidth = 2;
  self.navBarImageView.layer.cornerRadius = 18;
  self.scholarImageView.contentMode = UIViewContentModeScaleAspectFill;
  [self.contentView addSubview:self.navBarImageView];

  self.scholarNameLabel = [[UILabel alloc] init];
  self.scholarNameLabel.text = @"Scholar";
  self.scholarNameLabel.textColor = [UIColor renovatioRed];
  self.scholarNameLabel.font = [UIFont boldSystemFontOfSize:20];
  [self.contentView addSubview:self.scholarNameLabel];
  
  self.backButton = [[UIButton alloc] init];
  self.backButton.imageView.contentMode = UIViewContentModeScaleAspectFill;
  [self.backButton setImage:[[UIImage imageNamed:@"back_button"] imageTintedWithColor:[UIColor renovatioRed]]
                   forState:UIControlStateNormal];
  [self.backButton addTarget:self
                      action:@selector(didTapBackButton:)
            forControlEvents:UIControlEventTouchUpInside];
  [self.contentView addSubview:self.backButton];
  
  self.navBarTitle = [[UILabel alloc] init];
  self.navBarTitle.text = @"Scholar";
  self.navBarTitle.textColor = [UIColor renovatioRed];
  self.navBarTitle.font = [UIFont systemFontOfSize:17 weight:UIFontWeightSemibold];
  [self.contentView addSubview:self.navBarTitle];

  self.bookmarkView = [[RMBBookmarkView alloc] initWithSize:24 permanent:YES];
  [self.contentView addSubview:self.bookmarkView];
   
  [self.bookmarkView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bookmarkViewTapped)]];
}

- (void)setupViewConstraints {
  [self.backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(@0);
    make.left.equalTo(@0);
    make.width.equalTo(self.contentView.mas_width);
    make.height.equalTo(self.contentView.mas_height);
  }];
  
  [self.scholarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerX.equalTo(self.contentView.mas_centerX);
    make.centerY.equalTo(self.contentView.mas_centerY).offset(-10);
    make.width.equalTo(@(kUserImageSize.width));
    make.height.equalTo(@(kUserImageSize.height));
  }];
  
  [self.scholarNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerX.equalTo(self.contentView.mas_centerX);
    make.top.equalTo(self.scholarImageView.mas_bottom).offset(10);
  }];
  
  [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
    make.width.equalTo(@26);
    make.height.equalTo(@26);
    make.top.equalTo(self.contentView).offset(30);
    make.left.equalTo(self.contentView).offset(4);
  }];
  
  [self.navBarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.width.equalTo(@(36));
    make.height.equalTo(@(36));
    make.left.equalTo(self.backButton.mas_right).with.offset(8);
    make.top.equalTo(self.contentView).with.offset(24);
  }];

  [self.navBarTitle mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.navBarImageView.mas_right).offset(8);
    make.right.equalTo(self.contentView.mas_right).offset(-4);
    make.centerY.equalTo(self.contentView).offset(10);
  }];

  [self.bookmarkView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.contentView).offset(30);
    make.right.equalTo(self.contentView).offset(-16);
    make.width.equalTo(@(24));
    make.height.equalTo(@(24));
  }];
}

- (void)didChangeStretchFactor:(CGFloat)stretchFactor {
  CGFloat alpha = 1;
  CGFloat navBarAlpha = 0;
  if (stretchFactor > 1) {
    alpha = CGFloatTranslateRange(stretchFactor, 1, 1.5, 1, 0);
  } else if (stretchFactor < 0.8) {
    alpha = CGFloatTranslateRange(stretchFactor, 0.1, 0.8, 0, 1);
    navBarAlpha = CGFloatTranslateRange(stretchFactor, 0, 0.2, 1, 0);
  }
  
  alpha = MAX(0, alpha);
  self.scholarImageView.alpha = alpha;
  self.scholarNameLabel.alpha = alpha;
  self.navBarTitle.alpha = navBarAlpha;
  self.navBarImageView.alpha = navBarAlpha;
}

- (void)didTapBackButton:(id)sender {
  if ([self.delegate respondsToSelector:@selector(backButtonPressed)]) {
    [self.delegate backButtonPressed];
  }
}

- (void)bookmarkViewTapped {
  if ([self.delegate respondsToSelector:@selector(bookmarkViewPressed)]) {
    [self.delegate bookmarkViewPressed];
  }
  if ([self.scholar.bookmarkedByMe boolValue]) {
    [self.scholar unbookmark];
  } else {
    [self.scholar bookmark];
  }
  [self.bookmarkView setBookmarked:[self.scholar.bookmarkedByMe boolValue] animated:YES];
}

@end
