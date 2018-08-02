//
//  RMBVideosViewController.m
//  Rememberance
//
//  Created by Aly Ibrahim on 7/19/18.
//  Copyright © 2018 Aly Ibrahim. All rights reserved.
//

#import "RMBVideosViewController.h"
#import "RMBVideo.h"
#import "RMBVideoCell.h"
#import "RMBVideoViewController.h"
#import "GSKStretchyHeaderView.h"

@implementation RMBVideosViewController

- (instancetype)initWithRelativePath:(NSString *)relativePath {
  RMBModelCollection *collection = [[RMBModelCollection alloc] initWithModelClass:[RMBVideo class]
                                                            andRelativeRemotePath:relativePath];
  return [super initWithCollection:collection];
}

- (void)viewDidLoad {
  [super viewDidLoad];
//  [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
}

- (void)viewDidAppear:(BOOL)animated {
  [self.tableView reloadData];
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
