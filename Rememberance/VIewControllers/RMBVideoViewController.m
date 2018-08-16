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
#import "UIImage+RMBAdditions.h"
#import "UIColor+RMBAdditions.h"
#import "RMBVideoInfoCell.h"
#import "RMBScholarCell.h"
#import "RMBVideoSeries.h"
#import "RMBVideoCell.h"
#import "RMBVideoSeriesCell.h"
#import "RMBClient.h"
#import "RMBVideosViewController.h"
#import "RMBScholarProfileViewController.h"

typedef NS_ENUM(NSInteger, RMBVideoCellType) {
  RMBVideoCellTypePlayer,
  RMBVideoCellTypeInfo,
  RMBVideoCellTypeScholar,
  RMBVideoCellTypeVideoSeries,
  RMBVideoCellTypeOtherVideo
};

@interface RMBVideoViewController () <UITableViewDelegate, UITableViewDataSource, YTPlayerViewDelegate, UIScrollViewDelegate>

@property (strong, nonatomic, readwrite) RMBVideo *video;
@property (strong, nonatomic, readwrite) UITableView *tableView;
@property (strong, nonatomic, readwrite) RMBYouTubePlayerCell *youtubePlayerCell;
@property (strong, nonatomic, readwrite) UIImageView *closeButton;
@property (strong, nonatomic, readwrite) NSArray *cellTypes;
@property (assign, nonatomic, readwrite) BOOL dismissing;
@property (strong, nonatomic, readwrite) UIActivityIndicatorView *loadingIndicator;

@end

@implementation RMBVideoViewController

- (instancetype)initWithVideo:(RMBVideo *)video {
  if (self = [super init]) {
    _video = video;
    [self setupCellTypes];
  }
  return self;
}

- (void)setupCellTypes {
  NSMutableArray *cellTypes = [NSMutableArray array];
  [cellTypes addObject:@[@(RMBVideoCellTypePlayer), @(0)]];
  [cellTypes addObject:@[@(RMBVideoCellTypeInfo), @(0)]];
    for (int i = 0; i < self.video.scholars.count; i++) {
      [cellTypes addObject:@[@(RMBVideoCellTypeScholar), @(i)]];
    }
  if (self.video.series) {
    [cellTypes addObject:@[@(RMBVideoCellTypeVideoSeries), @(0)]];
  }
  //    for (int i = 0; i < video.series.videoSummaries.count; i++) {
  //      [cellTypes addObject:@[@(RMBVideoCellTypeOtherVideo), @(i)]];
  //    }
  _cellTypes = cellTypes;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.loadingIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
  self.loadingIndicator.hidesWhenStopped = YES;
  self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.loadingIndicator];
  
  [self.loadingIndicator startAnimating];
  [self.video loadDetailsWithSuccess:^{
    [self setupCellTypes];
    [self.tableView reloadData];
    [self.loadingIndicator stopAnimating];
  }];
  
  self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
  self.tableView.delegate = self;
  self.tableView.dataSource = self;
  [self.tableView registerClass:RMBYouTubePlayerCell.class forCellReuseIdentifier:@"youtube"];
  [self.tableView registerClass:RMBVideoInfoCell.class forCellReuseIdentifier:@"info"];
  [self.tableView registerClass:RMBScholarCell.class forCellReuseIdentifier:@"scholar"];
  [self.tableView registerClass:RMBVideoSeriesCell.class forCellReuseIdentifier:@"series"];
  [self.tableView registerClass:RMBVideoCell.class forCellReuseIdentifier:@"video"];

  [self.view addSubview:self.tableView];
  [self.tableView reloadData];
  
  [[NSNotificationCenter defaultCenter] addObserver: self
                                           selector: @selector(handleEnteredBackground)
                                               name: UIApplicationDidEnterBackgroundNotification
                                             object: nil];
  
  self.closeButton = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"close_icon"] imageTintedWithColor:[UIColor renovatioRed]]];
  [self.view addSubview:self.closeButton];
  
  self.closeButton.frame = CGRectMake(8, 8, 32, 32);
  self.closeButton.hidden = YES;
  
  self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 112, 0);
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  
  [self setNeedsStatusBarAppearanceUpdate];
}
- (RMBVideoCellType)cellTypeAtIndexPath:(NSIndexPath *)indexPath {
  NSNumber *type = [self cellTypes][indexPath.row][0];
  return [type integerValue];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.cellTypes.count;
}

- (RMBScholar *)scholarAtIndexPath:(NSIndexPath *)indexPath {
  NSArray *scholarCellType = self.cellTypes[indexPath.row];
  int scholarIndex = [scholarCellType[1] intValue];
  return self.video.scholars[scholarIndex];
}
//
//- (RMBVideo *)videoSeriesVideoAtIndexPath:(NSIndexPath *)indexPath {
//  NSArray *videoCellType = self.cellTypes[indexPath.row];
//  int videoIndex = [videoCellType[1] intValue];
//  return self.video.series.videoSummaries[videoIndex];
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  RMBVideoCellType cellType = [self cellTypeAtIndexPath:indexPath];
  if (cellType == RMBVideoCellTypePlayer) {
    if (self.youtubePlayerCell) {
      return self.youtubePlayerCell;
    }
    self.youtubePlayerCell = [self.tableView dequeueReusableCellWithIdentifier:@"youtube" forIndexPath:indexPath];
    self.youtubePlayerCell.video = self.video;
    NSMutableDictionary *playerVars = [NSMutableDictionary dictionaryWithDictionary:@{ @"controls" : @1, @"playsinline" : @1, @"autohide" : @1, @"showinfo" : @0, @"autoplay": @0, @"modestbranding" : @1 }];
    if ([self.video.progress.position integerValue]> -1) {
      playerVars[@"start"] = self.video.progress.position;
    }
    [self.youtubePlayerCell.player loadWithVideoId:self.video.youtubeId playerVars:playerVars];
    
    self.youtubePlayerCell.player.delegate = self;
    [self.youtubePlayerCell addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(videoTapped)]];
    return self.youtubePlayerCell;
  } else if (cellType == RMBVideoCellTypeInfo) {
    RMBVideoInfoCell *infoCell = [self.tableView dequeueReusableCellWithIdentifier:@"info" forIndexPath:indexPath];
    infoCell.video = self.video;
    return infoCell;
  } else if (cellType == RMBVideoCellTypeScholar) {
    RMBScholarCell *scholarCell = [self.tableView dequeueReusableCellWithIdentifier:@"scholar" forIndexPath:indexPath];
    scholarCell.scholar = [self scholarAtIndexPath:indexPath];
    return scholarCell;
  } else if (cellType == RMBVideoCellTypeVideoSeries) {
    RMBVideoSeriesCell *seriesCell = [self.tableView dequeueReusableCellWithIdentifier:@"series" forIndexPath:indexPath];
    seriesCell.videoSeries = self.video.series;
    return seriesCell;
  } else if (cellType == RMBVideoCellTypeOtherVideo) {
//    RMBVideoCell *videoCell = [self.tableView dequeueReusableCellWithIdentifier:@"video" forIndexPath:indexPath];
//    videoCell.video = [self videoSeriesVideoAtIndexPath:indexPath];
//    return videoCell;
  }
  return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
  RMBVideoCellType cellType = [self cellTypeAtIndexPath:indexPath];
  if (cellType == RMBVideoCellTypeVideoSeries) {
    RMBVideoSeries *videoSeries = self.video.series;
    NSString *path = [NSString stringWithFormat:@"videoseries/%ld/videos/", videoSeries.identifier];
    RMBVideosViewController *videoController = [[RMBVideosViewController alloc] initWithRelativePath:path];
    videoController.title = videoSeries.title;
    [self.navigationController pushViewController:videoController animated:YES];
  } else if (cellType == RMBVideoCellTypeScholar) {
    RMBScholar *scholar = [self scholarAtIndexPath:indexPath];
    RMBScholarProfileViewController *scholarViewController = [[RMBScholarProfileViewController alloc] initWithScholar:scholar];
    [self.navigationController pushViewController:scholarViewController animated:YES];
  } else if (cellType == RMBVideoCellTypeInfo) {
    RMBVideoInfoCell *infoCell = [self.tableView cellForRowAtIndexPath:indexPath];
    if (!infoCell.expanded) {
      [infoCell expand];
      infoCell.selectionStyle = UITableViewCellSelectionStyleNone;

      [self.tableView beginUpdates];
      [self.tableView endUpdates];
    }
  }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.row == 0) {
    CGFloat videoHeight = self.tableView.width / [self.video.aspectRatio doubleValue];
    return videoHeight;
  }
  return UITableViewAutomaticDimension;
}

- (void)videoTapped {
  self.closeButton.hidden = !self.closeButton.hidden;
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
    [self updateUserProgress];
  }
  if (state == kYTPlayerStateEnded) {
    [self.video markComplete];
  }
}

- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
  [self updateUserProgress];
}

- (void)handleEnteredBackground {
  [self updateUserProgress];
}

- (BOOL)prefersStatusBarHidden {
  return YES;
}

- (void)updateUserProgress {
  if (self.youtubePlayerCell.player.playerState == kYTPlayerStatePlaying ||
      self.youtubePlayerCell.player.playerState == kYTPlayerStatePaused) {
    long position = (long)self.youtubePlayerCell.player.currentTime;
    [self.video updateProgressWithPosition:position];
  }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  if (self.tableView.contentOffset.y < -150 && !self.dismissing) {
    self.dismissing = YES;
    [self dismissViewControllerAnimated:YES completion:^{
      
    }];
  }
}

@end
