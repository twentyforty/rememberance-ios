//
//  RMBHomeViewController.m
//  Rememberance
//
//  Created by Aly Ibrahim on 7/16/18.
//  Copyright © 2018 Aly Ibrahim. All rights reserved.
//

#import "RMBWorkspaceViewController.h"
#import "Masonry.h"
#import "RMBScholarsViewController.h"
#import "RMBVideoSeriesViewController.h"
#import "RMBVideo.h"
#import "RMBVideoCell.h"
#import "RMBScholar.h"
#import "UIColor+RMBAdditions.h"
#import "RMBVideoViewController.h"
#import "RMBActiveUser.h"
#import "RMBRootViewController.h"
#import "UIImage+RMBAdditions.h"

@interface RMBWorkspaceViewController ()

@end

@implementation RMBWorkspaceViewController

- (instancetype)init {
  RMBModelCollection *collection =
  [[RMBModelCollection alloc] initWithModelClass:RMBVideo.class andRelativeRemotePath:@"videos/bookmarked/"];
  collection.fieldSet = [[RMBModelFieldSet summaryFieldSetForModelClass:[RMBVideo class]]
                         andFieldSetForPropertyKeys:@[@"imageURL", @"name"] forModelClass:[RMBScholar class]];
  if (self = [super initWithCollection:collection]) {
    self.title = @"Bookmarks";
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  [self setPlaceholderText:@"Videos you've bookmarked live here."];

  [self addPullToRefresh];
  [self addInifiniteScroll];

  UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageWithImage:[UIImage imageNamed:@"logout"] scaledToSize:CGSizeMake(24, 24)] style:UIBarButtonItemStylePlain target:self action:@selector(logout)];
  self.navigationItem.rightBarButtonItem = anotherButton;
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

- (void)logout {
  [[RMBActiveUser class] logout];
  [RMBRootViewController switchToUnauthViewContoller];
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
