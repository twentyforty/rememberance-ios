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
#import "RMBScholar.h"

@implementation RMBVideosViewController

- (instancetype)initWithRelativePath:(NSString *)relativePath {
  RMBModelCollection *collection = [[RMBModelCollection alloc] initWithModelClass:[RMBVideo class]
                                                            andRelativeRemotePath:relativePath];
  collection.fieldSet = [[RMBModelFieldSet summaryFieldSetForModelClass:[RMBVideo class]]
                         andFieldSetForPropertyKeys:@[@"imageURL", @"name"] forModelClass:[RMBScholar class]];
  return [super initWithCollection:collection];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
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
//  videoController.modalPresentationStyle = UIModalPresentationOverFullScreen;
  
  [self.navigationController pushViewController:videoController animated:YES];
//  [self.navigationController pushViewController:videoController animated:YES];
}

@end
