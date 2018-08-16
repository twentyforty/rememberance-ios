//
//  RMBMainViewController.m
//  Rememberance
//
//  Created by Aly Ibrahim on 7/16/18.
//  Copyright © 2018 Aly Ibrahim. All rights reserved.
//

#import "RMBMainViewController.h"
#import "RMBHomeViewController.h"
#import "RMBDiscoverViewController.h"
#import "RMBWorkspaceViewController.h"
#import "UIImage+RMBAdditions.h"

@implementation RMBMainViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  RMBHomeViewController *homeViewController = [[RMBHomeViewController alloc] init];
  UINavigationController *homeNaigationController
      = [[UINavigationController alloc] initWithRootViewController:homeViewController];
  homeNaigationController.title = @"Home";
  UIImage *homeImage = [UIImage imageNamed:@"home"];
  homeNaigationController.tabBarItem.image = [UIImage imageWithImage:homeImage scaledToSize:CGSizeMake(30, 30)];
  
  RMBDiscoverViewController *discoverViewController = [[RMBDiscoverViewController alloc] init];
  UINavigationController *discoverNavigationController
      = [[UINavigationController alloc] initWithRootViewController:discoverViewController];
  discoverNavigationController.title = @"Discover";
  UIImage *discoverImage = [UIImage imageNamed:@"discover"];
  discoverNavigationController.tabBarItem.image = [UIImage imageWithImage:discoverImage scaledToSize:CGSizeMake(30, 30)];

  RMBWorkspaceViewController *workspaceViewController = [[RMBWorkspaceViewController alloc] init];
  UINavigationController *workspaceNavigationController
      = [[UINavigationController alloc] initWithRootViewController:workspaceViewController];
  workspaceNavigationController.title = @"Discover";
  UIImage *workspaceImage = [UIImage imageNamed:@"star_unhighlighted"];
  workspaceNavigationController.tabBarItem.image = [UIImage imageWithImage:workspaceImage scaledToSize:CGSizeMake(30, 30)];
  workspaceNavigationController.title = @"Bookmarks";

  self.viewControllers = @[homeNaigationController, discoverNavigationController, workspaceNavigationController];
  self.selectedIndex = 0;
}

@end
