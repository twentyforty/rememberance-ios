//
//  RMBScholarsViewController.m
//  Rememberance
//
//  Created by Aly Ibrahim on 7/19/18.
//  Copyright © 2018 Aly Ibrahim. All rights reserved.
//

#import "RMBScholarsViewController.h"
#import "Masonry.h"
#import "RMBModelCollection.h"
#import "RMBScholar.h"
#import "RMBScholarCell.h"
#import "RMBScholarPagerViewController.h"
#import "RMBScholarProfileViewController.h"

@implementation RMBScholarsViewController

- (instancetype)init {
  RMBModelCollection *collection = [[RMBModelCollection alloc] initWithModelClass:[RMBScholar class] andRelativeRemotePath:@"scholars/"];
  self = [super initWithCollection:collection];
  self.title = @"Scholars";
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
//  [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
}

- (Class)tableViewCellClass {
  return RMBScholarCell.class;
}

- (UITableViewCell *)renderCell:(id)cell forModel:(id)model atIndexPath:(NSIndexPath *)indexPath {
  RMBScholarCell *scholarCell = cell;
  RMBScholar *scholar = model;
  scholarCell.scholar = scholar;
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
  RMBScholarProfileViewController *controller = [[RMBScholarProfileViewController alloc] initWithScholar:[self modelAtIndexPath:indexPath]];
  [self.navigationController pushViewController:controller animated:YES];
}

@end
