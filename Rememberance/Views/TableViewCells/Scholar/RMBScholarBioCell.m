//
//  RMBScholarBioCell.m
//  Rememberance
//
//  Created by Aly Ibrahim on 7/21/18.
//  Copyright © 2018 Aly Ibrahim. All rights reserved.
//

#import "RMBScholarBioCell.h"

#import "Masonry.h"

@interface RMBScholarBioCell ()

@property (strong, nonatomic, readwrite) UILabel *bioLabel;

@end

@implementation RMBScholarBioCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
  if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    self.bioLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.bioLabel.font = [UIFont systemFontOfSize:14];
//    self.bioLabel.font = [UIFont fontWithName:@"Cardo" size:14];
    self.bioLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.bioLabel.numberOfLines = 0;
    [self.contentView addSubview:self.bioLabel];

    [self.bioLabel mas_makeConstraints:^(MASConstraintMaker *make) {
      make.edges.equalTo(self.contentView).with.insets(UIEdgeInsetsMake(16, 16, 16, 16));
      make.height.lessThanOrEqualTo(@(200));
    }];
  }
  return self;
}


- (void)updateConstraints {
  [self.bioLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.edges.equalTo(self.contentView).with.insets(UIEdgeInsetsMake(16, 16, 16, 16));
    if (!self.expanded) {
      make.height.lessThanOrEqualTo(@(200));
    }
  }];
  
  [super updateConstraints];
}

- (void)setScholar:(RMBScholar *)scholar {
//  self.bioLabel.text = scholar.bio;
  
  NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:scholar.bio];
  NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
  [paragraphStyle setLineSpacing:4];
  [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [scholar.bio length])];
  self.bioLabel.attributedText = attributedString ;
  
  [self setNeedsLayout];
}

- (void)setExpanded:(BOOL)expanded {
  _expanded = expanded;
  [self setNeedsUpdateConstraints];
}

@end
