//
//  RMBDiscoverViewController.m
//  Rememberance
//
//  Created by Aly Ibrahim on 7/16/18.
//  Copyright © 2018 Aly Ibrahim. All rights reserved.
//

#import "RMBDiscoverViewController.h"
#import "Masonry.h"
#import "RMBScholarsViewController.h"
#import "RMBVideoSeriesViewController.h"
#import "UIImage+RMBAdditions.h"
#import "UIColor+RMBAdditions.h"

@interface RMBDiscoverViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;

@end

@implementation RMBDiscoverViewController

- (instancetype)init {
  if (self = [super init]) {
    self.title = @"Discover";
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.view.backgroundColor = [UIColor whiteColor];
  self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
  self.tableView.dataSource = self;
  self.tableView.delegate = self;
  [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"item"];
  [self.view addSubview:self.tableView];
  
  [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"item" forIndexPath:indexPath];
  if (indexPath.row == 0) {
    cell.imageView.image = [UIImage imageWithImage:[UIImage imageNamed:@"scholar_icon"] scaledToSize:CGSizeMake(30, 30)];
    cell.textLabel.text = @"Scholars";
  } else if (indexPath.row == 1) {
    cell.imageView.image = [UIImage imageWithImage:[UIImage imageNamed:@"series_icon"] scaledToSize:CGSizeMake(30, 30)];
    cell.textLabel.text = @"Video Series";
  }
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
  if (indexPath.row == 0) {
    RMBScholarsViewController *controller = [[RMBScholarsViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
  } else if (indexPath.row == 1) {
    RMBVideoSeriesViewController *controller = [[RMBVideoSeriesViewController alloc] initWithRelativePath:@"videoseries/"];
    [self.navigationController pushViewController:controller animated:YES];
  }
}

@end
