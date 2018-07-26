//
//  RMBVideoViewController.m
//  Rememberance
//
//  Created by Aly Ibrahim on 7/20/18.
//  Copyright © 2018 Aly Ibrahim. All rights reserved.
//

#import "RMBVideoViewController.h"
#import "YTPlayerView.h"
#import "UIView+RMBAdditions.h"
#import "RMBYouTubePlayerCell.h"
#import "RMBVimeoPlayerCell.h"
#import "VIMVideoPlayerView.h"
#import "VIMVideoPlayer.h"

@interface RMBVideoViewController () <UITableViewDelegate, UITableViewDataSource, YTPlayerViewDelegate, VIMVideoPlayerViewDelegate>

@property (strong, nonatomic, readwrite) RMBVideo *video;
@property (strong, nonatomic, readwrite) UITableView *tableView;
@property (strong, nonatomic, readwrite) RMBYouTubePlayerCell *youtubePlayerCell;
@property (strong, nonatomic, readwrite) RMBVimeoPlayerCell *vimeoPlayerCell;

@end

@implementation RMBVideoViewController

- (instancetype)initWithVideo:(RMBVideo *)video {
  if (self = [super init]) {
    _video = video;
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
  self.tableView.delegate = self;
  self.tableView.dataSource = self;
  [self.tableView registerClass:RMBYouTubePlayerCell.class forCellReuseIdentifier:@"youtube"];
  [self.tableView registerClass:RMBVimeoPlayerCell.class forCellReuseIdentifier:@"vimeo"];
  
  [self.view addSubview:self.tableView];
  [self.tableView reloadData];
  
  [[NSNotificationCenter defaultCenter] addObserver: self
                                           selector: @selector(handleEnteredBackground)
                                               name: UIApplicationDidEnterBackgroundNotification
                                             object: nil];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.row == 0) {
    
//    self.vimeoPlayerCell = [self.tableView dequeueReusableCellWithIdentifier:@"vimeo" forIndexPath:indexPath];
//    self.vimeoPlayerCell.video = self.video;
//    self.vimeoPlayerCell.player.delegate = self;
//    [self.vimeoPlayerCell.player.player setURL:[NSURL URLWithString:@"https://vimeo.com/24581381/"]];
//    [self.vimeoPlayerCell.player.player play];
//    return self.vimeoPlayerCell;
    self.youtubePlayerCell = [self.tableView dequeueReusableCellWithIdentifier:@"youtube" forIndexPath:indexPath];
    self.youtubePlayerCell.video = self.video;
    NSMutableDictionary *playerVars = [NSMutableDictionary dictionaryWithDictionary:@{ @"controls" : @1, @"playsinline" : @1, @"autohide" : @1, @"showinfo" : @0, @"autoplay": @0, @"modestbranding" : @1 }];
    if ([self.video.progress integerValue] > -1) {
      playerVars[@"start"] = self.video.progress;
    }
    [self.youtubePlayerCell.player loadWithVideoId:self.video.youtubeId playerVars:playerVars];
    
    self.youtubePlayerCell.player.delegate = self;
    return self.youtubePlayerCell;
  }
  return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.row == 0) {
    return self.view.width / [self.video.aspectRatio doubleValue];
  }
  return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return 1;
}

- (void)playerViewDidBecomeReady:(YTPlayerView *)playerView {
  [self.youtubePlayerCell onVideoReady];
}

//- (void)playerView:(YTPlayerView *)playerView didPlayTime:(float)playTime {
//  long position = (long)playTime;
//  if (position % 100 == 0) {
//    [self.video updateProgressWithPosition:position];
//  }
//}

//- (void)viewWillDisappear:(BOOL)animated {
//  if (self.youtubePlayerCell.player.playerState ==)
//  [self.video updateProgressWithPosition:position];
//}

- (void)playerView:(YTPlayerView *)playerView didChangeToState:(YTPlayerState)state {
  if (state == kYTPlayerStatePaused) {
    NSLog(@"paused");
  }
  if (state == kYTPlayerStateEnded) {
    NSLog(@"ended");
  }
}

- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
  [self updateUserProgress];
}

- (void)handleEnteredBackground {
  [self updateUserProgress];
}

- (void)updateUserProgress {
  if (self.youtubePlayerCell.player.playerState == kYTPlayerStatePlaying ||
      self.youtubePlayerCell.player.playerState == kYTPlayerStatePaused ||
      self.youtubePlayerCell.player.playerState == kYTPlayerStateEnded) {
    long position = (long)self.youtubePlayerCell.player.currentTime;
    [self.video updateProgressWithPosition:position];
  }
}

@end
