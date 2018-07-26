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

static const CGSize kUserImageSize = {.width = 100, .height = 100};

@interface RMBScholarHeaderView ()

@property (nonatomic) UIImageView *backgroundImageView;
@property (nonatomic) UIImageView *scholarImageView;
@property (nonatomic) UILabel *scholarNameLabel;
@property (nonatomic) UIImageView *navBarImageView;
@property (nonatomic) UILabel *navBarTitle;
@property (nonatomic) UIButton *backButton;

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
  [self.contentView addSubview:self.navBarImageView];

  self.scholarNameLabel = [[UILabel alloc] init];
  self.scholarNameLabel.text = @"Scholar";
  self.scholarNameLabel.textColor = [UIColor renovatioRed];
  self.scholarNameLabel.font = [UIFont boldSystemFontOfSize:20];
  [self.contentView addSubview:self.scholarNameLabel];
  
  self.backButton = [[UIButton alloc] init];
  self.backButton.imageView.contentMode = UIViewContentModeCenter;
  [self.backButton setImage:[UIImage imageNamed:@"back_button"] forState:UIControlStateNormal];
  [self.backButton addTarget:self
                      action:@selector(didTapBackButton:)
            forControlEvents:UIControlEventTouchUpInside];
  [self.contentView addSubview:self.backButton];
  
  self.navBarTitle = [[UILabel alloc] init];
  self.navBarTitle.text = @"Scholar";
  self.navBarTitle.textColor = [UIColor renovatioRed];
  self.navBarTitle.font = [UIFont systemFontOfSize:17 weight:UIFontWeightSemibold];
  [self.contentView addSubview:self.navBarTitle];
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
    make.width.equalTo(@14);
    make.height.equalTo(@22);
    make.top.equalTo(self.contentView).offset(30);
    make.left.equalTo(self.contentView).offset(8);
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
//  self.backgroundImageView.alpha = blurAlpha;
//  self.blurredBackgroundImageView.alpha = blurAlpha;
  self.scholarImageView.alpha = alpha;
  self.scholarNameLabel.alpha = alpha;
//  self.followButton.alpha = alpha;
  self.navBarTitle.alpha = navBarAlpha;
  self.navBarImageView.alpha = navBarAlpha;
//  self.backButton.alpha = navBarAlpha;
}

- (void)didTapBackButton:(id)sender {
  if ([self.delegate respondsToSelector:@selector(backButtonPressed)]) {
    [self.delegate backButtonPressed];
  }
}

@end
