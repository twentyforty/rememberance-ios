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
#import "RMBVideo.h"
#import "RMBVideoCell.h"
#import "RMBScholar.h"
#import "UIColor+RMBAdditions.h"
#import "RMBVideoViewController.h"
#import "UIView+RMBAdditions.h"

@interface RMBHomeViewController ()

@end

@implementation RMBHomeViewController

- (instancetype)init {
  RMBModelCollection *collection =
      [[RMBModelCollection alloc] initWithModelClass:RMBVideo.class andRelativeRemotePath:@"videos/continue/"];
  collection.fieldSet = [[RMBModelFieldSet summaryFieldSetForModelClass:[RMBVideo class]]
                         andFieldSetForPropertyKeys:@[@"imageURL", @"name"] forModelClass:[RMBScholar class]];
  if (self = [super initWithCollection:collection]) {
    self.title = @"Remembrance";
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  [self addPullToRefresh];
//  [self addInifiniteScroll];
  [self setPlaceholderText:@"Discover content by tapping on the\r\nDiscover tab."];
  
//  self.navigationController.navigationItem.backBarButtonItem.title = @"ASD";
//
  UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
  [backButtonItem setBackgroundImage:[UIImage imageNamed:@"back_button"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
  self.navigationItem.backBarButtonItem = backButtonItem;
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [self.navigationController setNavigationBarHidden:NO
                                           animated:NO];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  
  [self.tableView reloadData];
  
  if (self.tableView.contentOffset.y == 0) {
    [self loadObjects];
  }
}

- (Class)tableViewCellClass {
  return RMBVideoCell.class;
}

- (UITableViewCell *)renderCell:(id)cell forModel:(id)model atIndexPath:(NSIndexPath *)indexPath {
  RMBVideoCell *videoCell = cell;
  RMBVideo *video = model;
  videoCell.video = video;
  return videoCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
  RMBVideo *video = [self modelAtIndexPath:indexPath];
  RMBVideoViewController *videoController = [[RMBVideoViewController alloc] initWithVideo:video];
  
  [self.navigationController pushViewController:videoController animated:YES];
}

@end
