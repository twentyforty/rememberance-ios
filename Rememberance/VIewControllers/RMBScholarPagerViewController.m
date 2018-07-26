//
//  RMBScholarPagerViewController.m
//  Rememberance
//
//  Created by Aly Ibrahim on 7/19/18.
//  Copyright © 2018 Aly Ibrahim. All rights reserved.
//

#import "RMBScholarPagerViewController.h"

#import "GSKStretchyHeaderView.h"
#import "RMBScholarHeaderView.h"
#import "RMBVideosViewController.h"

@interface RMBScholarPagerViewController () <XLPagerTabStripViewControllerDataSource>

@property (strong, nonatomic, readwrite) RMBScholar *scholar;
@property (strong, nonatomic, readwrite) RMBVideosViewController *videosViewController1;
@property (strong, nonatomic, readwrite) RMBVideosViewController *videosViewController2;

@end

@implementation RMBScholarPagerViewController

- (instancetype)initWithScholar:(RMBScholar *)scholar {
  if (self = [super init]) {
    self.scholar = scholar;
    NSString *relativePath = [NSString stringWithFormat:@"scholars/%ld/videos/", scholar.identifier];
    self.videosViewController1 = [[RMBVideosViewController alloc] initWithRelativePath:relativePath];
    self.videosViewController2 = [[RMBVideosViewController alloc] initWithRelativePath:relativePath];
  }
  return self;
}

- (NSArray *)childViewControllersForPagerTabStripViewController:(XLPagerTabStripViewController *)pagerTabStripViewController {
  return @[self.videosViewController1, self.videosViewController2];
}

//- (void)viewDidLoad {
//  self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
//  [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"item"];
//  self.tableView.delegate = self;
//  self.tableView.dataSource = self;
//  [self.view addSubview:self.tableView];
//
//  self.headerView = [[RMBScholarHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 240)];
//  self.tableView.tableHeaderView = self.headerView;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//  return 1;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//  UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"item" forIndexPath:indexPath];
//  cell.textLabel.text =
//
//}

@end
