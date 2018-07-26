//
//  RMBVimeoPlayerCell.m
//  Rememberance
//
//  Created by Aly Ibrahim on 7/20/18.
//  Copyright © 2018 Aly Ibrahim. All rights reserved.
//

#import "RMBVimeoPlayerCell.h"

#import "VIMVideoPlayerView.h"
#import "Masonry.h"

@interface RMBVimeoPlayerCell ()

@property (strong, nonatomic, readwrite) VIMVideoPlayerView *player;

@end

@implementation RMBVimeoPlayerCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
  if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    self.player = [[VIMVideoPlayerView alloc] init];
    [self.contentView addSubview:self.player];
    self.player.backgroundColor = [UIColor redColor];
    
    [self.player mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.equalTo(@0);
      make.left.equalTo(@0);
      make.width.equalTo(self.contentView.mas_width);
      make.height.equalTo(self.contentView.mas_height);
    }];
  }
  return self;
}

- (void)setVideo:(RMBVideo *)video {
  _video = video;
//  [self.player loadWithVideoId:@"M7lc1UVf-VE"];
//  [self.player loadVideoByURL:[self.video.url absoluteString]
//                 startSeconds:0
//             suggestedQuality:kYTPlaybackQualityAuto];
}

@end
