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

@interface RMBHomeViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;

@end

@implementation RMBHomeViewController

- (instancetype)init {
  if (self = [super init]) {
    self.title = @"Renovatio";
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
  return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"item" forIndexPath:indexPath];
  if (indexPath.row == 0) {
    cell.textLabel.text = @"Scholars";
  }
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
  if (indexPath.row == 0) {
    RMBScholarsViewController *controller = [[RMBScholarsViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
  }
}

@end
