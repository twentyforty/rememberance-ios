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
#import "Masonry.h"
#import "UIColor+RMBAdditions.h"

@interface RMBTableViewCollectionController ()

@property (strong, nonatomic, readwrite) RMBModelCollection *collection;
@property (strong, nonatomic, readwrite) UITableView *tableView;
@property (strong, nonatomic, readwrite) UIView *placeholderView;
@property (strong, nonatomic, readwrite) UILabel *placeholderLabel;
@property (strong, nonatomic, readwrite) UIActivityIndicatorView *loadingIndicator;

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
  
  self.loadingIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
  self.loadingIndicator.hidesWhenStopped = YES;
  self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.loadingIndicator];

  self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
  self.tableView.dataSource = self;
  self.tableView.delegate = self;
  [self.tableView registerClass:self.tableViewCellClass forCellReuseIdentifier:@"object"];
  [self.view addSubview:self.tableView];
  
  self.navigationController.navigationBar.translucent = NO;
  self.tabBarController.tabBar.translucent = NO;
  
  UIEdgeInsets contentInset = self.tableView.contentInset;
  if (self.tabBarController) {
    contentInset.bottom = 112;
  }
  self.tableView.scrollIndicatorInsets = contentInset;
  self.tableView.contentInset = contentInset;

  self.placeholderView = [[UIView alloc] init];
  self.placeholderView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
  self.placeholderView.hidden = YES;
  [self.tableView addSubview:self.placeholderView];
  
  self.placeholderLabel = [[UILabel alloc] init];
  self.placeholderLabel.textAlignment = NSTextAlignmentCenter;
  self.placeholderLabel.lineBreakMode = NSLineBreakByWordWrapping;
  self.placeholderLabel.numberOfLines = 6;
  self.placeholderLabel.font = [UIFont boldSystemFontOfSize:16];
  self.placeholderLabel.textColor = [UIColor colorWithWhite:0.5 alpha:1];
  [self.placeholderView addSubview:self.placeholderLabel];

  [self.placeholderView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.size.equalTo(self.view);
    make.center.equalTo(self.view);
  }];
  
  [self addInifiniteScroll];
  
  [self loadObjects];
}

- (void)setPlaceholderText:(NSString *)placeholderText {
  self.placeholderLabel.text = placeholderText;
  [self.placeholderLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.size.equalTo(self.placeholderView);
    make.center.equalTo(self.placeholderView);
  }];
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
  self.placeholderView.hidden = self.collection.count > 0;
  [self.tableView.infiniteScrollingView stopAnimating];
  [self.loadingIndicator stopAnimating];
  self.tableView.showsInfiniteScrolling = self.collection.hasMoreObjects;
}

- (void)failure {
  [self.tableView.pullToRefreshView stopAnimating];
}

- (void)loadObjects {
  WEAKSELF_T weakSelf = self;
  [self.loadingIndicator startAnimating];
  [weakSelf.collection loadObjectsWithSuccess:^{
    [weakSelf reloadData];
    [weakSelf.loadingIndicator stopAnimating];
  } failure:^(NSString *message) {
    [weakSelf failure];
    [weakSelf.loadingIndicator stopAnimating];
  }];
}

- (void)loadNextObjects {
  WEAKSELF_T weakSelf = self;
  [self.loadingIndicator startAnimating];
  [weakSelf.collection loadNextObjectsWithSuccess:^{
    [weakSelf reloadData];
    [weakSelf.loadingIndicator stopAnimating];
  } failure:^(NSString *message) {
    [weakSelf failure];
    [weakSelf.loadingIndicator stopAnimating];
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
