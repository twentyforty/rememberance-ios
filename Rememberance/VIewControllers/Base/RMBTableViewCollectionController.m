//
//  RMBTableViewCollectionController.m
//  Rememberance
//
//  Created by Aly Ibrahim on 7/19/18.
//  Copyright © 2018 Aly Ibrahim. All rights reserved.
//

#import "RMBTableViewCollectionController.h"
#import "RMBModelCollection.h"
#import "UIScrollView+SVPullToRefresh.h"
#import "UIScrollView+SVInfiniteScrolling.h"

@interface RMBTableViewCollectionController ()

@property (strong, nonatomic, readwrite) RMBModelCollection *collection;
@property (strong, nonatomic, readwrite) UITableView *tableView;

@end

@implementation RMBTableViewCollectionController

- (instancetype)initWithCollection:(RMBModelCollection *)collection {
  if (self = [super init]) {
    self.collection = collection;
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.view.backgroundColor = [UIColor whiteColor];
  
  self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
  self.tableView.dataSource = self;
  self.tableView.delegate = self;
  [self.tableView registerClass:self.tableViewCellClass forCellReuseIdentifier:@"object"];
  [self.view addSubview:self.tableView];
  
  self.navigationController.navigationBar.translucent = NO;
  self.tabBarController.tabBar.translucent = NO;
  
  UIEdgeInsets contentInset = self.tableView.contentInset;
  if (self.tabBarController) {
//    CGFloat height = self.bottomLayoutGuide.length;
    contentInset.bottom = self.tabBarController.tabBar.frame.size.height;
//    contentInset.top = self.navigationController.navigationBar.frame.size.height;
//    contentInset = UIEdgeInsetsMake(0, 0, height, 0);
  }
//  self.edgesForExtendedLayout = UIRectEdgeNone;
  self.tableView.scrollIndicatorInsets = contentInset;
  self.tableView.contentInset = contentInset;

  [self loadObjects];
}

- (void)addPullToRefresh {
  WEAKSELF_T weakSelf = self;
  [self.tableView addPullToRefreshWithActionHandler:^{
    [weakSelf loadObjects];
  }];
}

- (void)addInifiniteScroll {
  WEAKSELF_T weakSelf = self;
  [self.tableView addInfiniteScrollingWithActionHandler:^{
    [weakSelf loadNextObjects];
  }];
}

- (Class)tableViewCellClass {
  return UITableViewCell.class;
}

- (void)reloadData {
  [self.tableView reloadData];
  [self.tableView.pullToRefreshView stopAnimating];
  self.tableView.showsInfiniteScrolling = self.collection.hasMoreObjects;
}

- (void)failure {
  [self.tableView.pullToRefreshView stopAnimating];
}

- (void)loadObjects {
  WEAKSELF_T weakSelf = self;
  [weakSelf.collection clear];
  [weakSelf.collection loadObjectsWithSuccess:^{
    [weakSelf reloadData];
  } failure:^(NSString *message) {
    [weakSelf failure];
  }];
}

- (void)loadNextObjects {
  WEAKSELF_T weakSelf = self;
  [weakSelf.collection loadNextObjectsWithSuccess:^{
    [weakSelf reloadData];
  } failure:^(NSString *message) {
    [weakSelf failure];
  }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.collection.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"object" forIndexPath:indexPath];
  RMBModel *model = [self modelAtIndexPath:indexPath];
  [self renderCell:cell forModel:model atIndexPath:indexPath];
  return cell;
}

- (id)modelAtIndexPath:(NSIndexPath *)indexPath {
  return [self.collection objectAtIndex:indexPath.row];
}

- (UITableViewCell *)renderCell:(id)cell forModel:(id)model atIndexPath:(NSIndexPath *)indexPath {
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  //  self.navigationController pushViewController:(nonnull UIViewController *) animated:<#(BOOL)#>
}


@end
