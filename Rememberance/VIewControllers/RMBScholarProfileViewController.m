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
#import "RMBVideoSeriesViewController.h"

typedef NS_ENUM(NSInteger, RMBScholarCellType) {
  RMBScholarCellTypeBio,
  RMBScholarCellTypeVideos,
  RMBScholarCellTypeVideoSeries
};

@interface RMBScholarProfileViewController () <UITableViewDelegate, UITableViewDataSource, SFSafariViewControllerDelegate, RMBHeaderViewDelegate>

@property (strong, nonatomic, readwrite) RMBScholarHeaderView *headerView;
@property (strong, nonatomic, readwrite) RMBScholar *scholar;
@property (strong, nonatomic, readwrite) UITableView *tableView;
@property (strong, nonatomic, readwrite) RMBScholarBioCell *bioCell;
@property (strong, nonatomic, readwrite) NSArray *cellTypes;
@end

@implementation RMBScholarProfileViewController

- (instancetype)initWithScholar:(RMBScholar *)scholar {
  if (self = [super init]) {
    _scholar = scholar;
    [self setupCellTypes];
  }
  return self;
}

- (void)setupCellTypes {
  NSMutableArray *cellTypes = [NSMutableArray array];
  if (self.scholar.bio) {
    [cellTypes addObject:@(RMBScholarCellTypeBio)];
  }
  if ([self.scholar.videoCount integerValue] > 0) {
    [cellTypes addObject:@(RMBScholarCellTypeVideos)];
  }
  if ([self.scholar.videoSeriesCount integerValue] > 0) {
    [cellTypes addObject:@(RMBScholarCellTypeVideoSeries)];
  }
  _cellTypes = cellTypes;
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
  
  [self.scholar loadDetailsWithSuccess:^{
    [self setupCellTypes];
    [self.tableView reloadData];
  }];

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
  self.tableView.contentInset = contentInset;
  [self.tableView addSubview:self.headerView];
}

- (RMBScholarCellType)cellTypeAtIndexPath:(NSIndexPath *)indexPath {
//  if (indexPath.row >= [self cellTypes].count) {
//    return RMBScholarCellTypeNone;
//  }
  NSNumber *type = [self cellTypes][indexPath.row];
  return [type integerValue];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.cellTypes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  RMBScholarCellType cellType = [self cellTypeAtIndexPath:indexPath];
  if (cellType == RMBScholarCellTypeBio) {
    self.bioCell = [self.tableView dequeueReusableCellWithIdentifier:@"bio" forIndexPath:indexPath];
    self.bioCell.scholar = self.scholar;
    return self.bioCell;
  } else if (cellType == RMBScholarCellTypeVideos) {
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"Videos (%@)", self.scholar.videoCount];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
  } else if (cellType == RMBScholarCellTypeVideoSeries) {
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"Video Series (%@)", self.scholar.videoSeriesCount];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
  }
  return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
  RMBScholarCellType cellType = [self cellTypeAtIndexPath:indexPath];
  if (cellType == RMBScholarCellTypeBio) {
    if (!self.bioCell.expanded) {
      self.bioCell.expanded = YES;
      self.bioCell.selectionStyle = UITableViewCellSelectionStyleNone;
      [self.tableView beginUpdates];
      [self.tableView endUpdates];
    }
  } else if (cellType == RMBScholarCellTypeVideos) {
    NSString *remotePath = [NSString stringWithFormat:@"scholars/%ld/videos/", self.scholar.identifier];
    RMBVideosViewController *controller = [[RMBVideosViewController alloc] initWithRelativePath:remotePath];
    controller.title = @"Videos";
    [self.navigationController pushViewController:controller animated:YES];
  } else if (cellType == RMBScholarCellTypeVideoSeries) {
    NSString *remotePath = [NSString stringWithFormat:@"scholars/%ld/videoseries/", self.scholar.identifier];
    RMBVideoSeriesViewController *controller = [[RMBVideoSeriesViewController alloc] initWithRelativePath:remotePath];
    controller.title = @"Video Series";
    [self.navigationController pushViewController:controller animated:YES];
  }
}

- (void)backButtonPressed {
  [self.navigationController popViewControllerAnimated:YES];
}

@end
