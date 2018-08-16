//
//  RMBVideoInfoCell.h
//  Rememberance
//
//  Created by Aly Ibrahim on 8/3/18.
//  Copyright © 2018 Aly Ibrahim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "RMBVideo.h"

@interface RMBVideoInfoCell : UITableViewCell

@property (strong, nonatomic, readwrite) RMBVideo *video;
@property (assign, nonatomic, readonly) BOOL canExpand;
@property (assign, nonatomic, readonly) BOOL expanded;

- (void)expand;

@end
