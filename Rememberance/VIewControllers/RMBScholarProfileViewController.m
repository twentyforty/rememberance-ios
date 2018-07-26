//
//  RMBScholarProfileViewController.m
//  Rememberance
//
//  Created by Aly Ibrahim on 7/19/18.
//  Copyright © 2018 Aly Ibrahim. All rights reserved.
//

#import "RMBScholarProfileViewController.h"

#import "RMBScholarHeaderView.h"
#import "GSKStretchyHeaderView.h"
#import "UINavigationController+RMBAdditions.h"
#import "UIView+RMBAdditions.h"
#import "RMBVideoCell.h"
#import <SafariServices/SafariServices.h>
#import "RMBVideoViewController.h"
#import "RMBScholarBioCell.h"
#import "RMBVideosViewController.h"

@interface RMBScholarProfileViewController () <UITableViewDelegate, UITableViewDataSource, SFSafariViewControllerDelegate, RMBHeaderViewDelegate>

@property (strong, nonatomic, readwrite) RMBScholarHeaderView *headerView;
@property (strong, nonatomic, readwrite) RMBScholar *scholar;
@property (strong, nonatomic, readwrite) UITableView *tableView;
@property (strong, nonatomic, readwrite) RMBScholarBioCell *bioCell;

@end

@implementation RMBScholarProfileViewController

- (instancetype)initWithScholar:(RMBScholar *)scholar {
  if (self = [super init]) {
    _scholar = scholar;
  }
  return self;
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [self.navigationController setNavigationBarHidden:YES
                                           animated:NO];
  
//  [self.navigationController gsk_setNavigationBarTransparent:YES animated:NO];
//  self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
//  self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}

- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
  [self.navigationController setNavigationBarHidden:NO
                                           animated:NO];
}

- (void)viewDidLoad {
  [super viewDidLoad];

  self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
  [self.tableView registerClass:[RMBScholarBioCell class] forCellReuseIdentifier:@"bio"];
  [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
  self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
  self.tableView.dataSource = self;
  self.tableView.delegate = self;
  self.tableView.separatorInset = UIEdgeInsetsZero;

  [self.view addSubview:self.tableView];

  self.headerView = [[RMBScholarHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.width, 240)];
  self.headerView.scholar = self.scholar;
  self.headerView.delegate = self;

  UIEdgeInsets contentInset = self.tableView.contentInset;
  if (self.navigationController) {
    contentInset.top = 64;
  }
  if (self.tabBarController) {
    contentInset.bottom = 44;
  }
  self.tableView.backgroundColor = [UIColor lightGrayColor];
  self.tableView.contentInset = contentInset;
//  UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.width, self.tableView.height - 200)];
//  footer.backgroundColor = [UIColor lightGrayColor];
//  self.tableView.tableFooterView = footer;

  [self.tableView addSubview:self.headerView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.row == 0) {
    self.bioCell = [self.tableView dequeueReusableCellWithIdentifier:@"bio" forIndexPath:indexPath];
    self.bioCell.scholar = self.scholar;
    return self.bioCell;
  } else if (indexPath.row == 1) {
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = @"Video";
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
  } else if (indexPath.row == 2) {
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = @"Audio";
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
  } else if (indexPath.row == 3) {
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = @"Publication";
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
  } else {
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = @"";
    cell.accessoryType = UITableViewCellAccessoryNone;
    return cell;
  }
  return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
  if (indexPath.row == 0) {
    if (!self.bioCell.expanded) {
      self.bioCell.expanded = YES;
      self.bioCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
  } else if (indexPath.row == 1) {
    NSString *remotePath = [NSString stringWithFormat:@"scholars/%ld/videos/", self.scholar.identifier];
    RMBVideosViewController *controller = [[RMBVideosViewController alloc] initWithRelativePath:remotePath];
    [self.navigationController pushViewController:controller animated:YES];
  }
}

- (void)backButtonPressed {
  [self.navigationController popViewControllerAnimated:YES];
}

@end

