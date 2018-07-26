//
//  RMBVimeoPlayerCell.h
//  Rememberance
//
//  Created by Aly Ibrahim on 7/20/18.
//  Copyright © 2018 Aly Ibrahim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "VIMVideoPlayerView.h"
#import "RMBVideo.h"

@interface RMBVimeoPlayerCell : UITableViewCell

@property (strong, nonatomic, readonly) VIMVideoPlayerView *player;

@property (strong, nonatomic, readwrite) RMBVideo *video;

@end
