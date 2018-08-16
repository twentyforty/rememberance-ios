//
//  RMBYouTubePlayerCell.h
//  Rememberance
//
//  Created by Aly Ibrahim on 7/20/18.
//  Copyright © 2018 Aly Ibrahim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "YTPlayerView.h"

#import "RMBVideo.h"

@interface RMBYouTubePlayerCell : UITableViewCell

@property (strong, nonatomic, readwrite) RMBVideo *video;
@property (strong, nonatomic, readonly) YTPlayerView *player;
@property (strong, nonatomic, readonly) UIView *dimView;

- (void)onVideoReady;

@end
