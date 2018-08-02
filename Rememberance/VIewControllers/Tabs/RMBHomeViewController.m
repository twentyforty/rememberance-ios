//
//  RMBHomeViewController.m
//  Rememberance
//
//  Created by Aly Ibrahim on 7/16/18.
//  Copyright © 2018 Aly Ibrahim. All rights reserved.
//

#import "RMBHomeViewController.h"
#import "Masonry.h"
#import "RMBScholarsViewController.h"
#import "RMBVideoSeriesViewController.h"

@interface RMBHomeViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;

@end

@implementation RMBHomeViewController

- (instancetype)init {
  if (self = [super init]) {
    self.title = @"Remembrance";
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
    cell.textLabel.text = @"Scholars";
  } else if (indexPath.row == 1) {
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
