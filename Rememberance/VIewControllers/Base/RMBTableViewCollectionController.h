//
//  RMBTableViewCollectionController.h
//  Rememberance
//
//  Created by Aly Ibrahim on 7/19/18.
//  Copyright © 2018 Aly Ibrahim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "RMBModelCollection.h"
#import "UIScrollView+SVPullToRefresh.h"
#import "UIScrollView+SVInfiniteScrolling.h"


@interface RMBTableViewCollectionController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic, readonly) RMBModelCollection *collection;
@property (strong, nonatomic, readonly) UITableView *tableView;

- (instancetype)initWithCollection:(RMBModelCollection *)collection;
- (UITableViewCell *)renderCell:(id)cell forModel:(id)model atIndexPath:(NSIndexPath *)indexPath;
- (id)modelAtIndexPath:(NSIndexPath *)indexPath;
- (Class)tableViewCellClass;

- (void)loadObjects;
- (void)addPullToRefresh;
- (void)addInifiniteScroll;
@end
