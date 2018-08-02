//
//  RMBVideoSeriesViewController.m
//  Rememberance
//
//  Created by Aly Ibrahim on 7/28/18.
//  Copyright © 2018 Aly Ibrahim. All rights reserved.
//

#import "RMBVideoSeriesViewController.h"
#import "RMBVideoSeries.h"
#import "RMBVideosViewController.h"
#import "GSKStretchyHeaderView.h"
#import "RMBVideoSeriesCell.h"

@implementation RMBVideoSeriesViewController

- (instancetype)initWithRelativePath:(NSString *)relativePath {
  RMBModelCollection *collection = [[RMBModelCollection alloc] initWithModelClass:[RMBVideoSeries class]
                                                            andRelativeRemotePath:relativePath];
  return [super initWithCollection:collection];
}

- (Class)tableViewCellClass {
  return RMBVideoSeriesCell.class;
}

- (UITableViewCell *)renderCell:(id)cell forModel:(id)model atIndexPath:(NSIndexPath *)indexPath {
  RMBVideoSeriesCell *videoSeriesCell = cell;
  RMBVideoSeries *videoSeries = model;
  videoSeriesCell.videoSeries = videoSeries;
//  videoSeriesCell.textLabel.text = [NSString stringWithFormat:@"%@ %lu", videoSeries.title, [videoSeries.videoCount integerValue]];
  return videoSeriesCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
  RMBVideoSeries *videoSeries = [self modelAtIndexPath:indexPath];
  NSString *path = [NSString stringWithFormat:@"videoseries/%ld/videos/", videoSeries.identifier];
  RMBVideosViewController *videoController = [[RMBVideosViewController alloc] initWithRelativePath:path];
  videoController.title = videoSeries.title;
  [self.navigationController pushViewController:videoController animated:YES];
}

@end
