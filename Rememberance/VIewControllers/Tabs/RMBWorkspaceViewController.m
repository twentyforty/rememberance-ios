//
//  RMBWorkspaceViewController.m
//  Rememberance
//
//  Created by Aly Ibrahim on 7/16/18.
//  Copyright © 2018 Aly Ibrahim. All rights reserved.
//

#import "RMBWorkspaceViewController.h"
#import "Masonry.h"

@interface RMBWorkspaceViewController ()

@end

@implementation RMBWorkspaceViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.view.backgroundColor = [UIColor whiteColor];
  UILabel *titleLabel = [[UILabel alloc] init];
  titleLabel.text = @"Workspace";
  titleLabel.font = [UIFont fontWithName:@"Quadraat" size:18];
  [titleLabel sizeToFit];
  [self.view addSubview:titleLabel];
  
  [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.center.equalTo(self.view);
  }];
}
@end
