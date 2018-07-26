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

@implementation RMBMainViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  RMBHomeViewController *homeViewController = [[RMBHomeViewController alloc] init];
  UINavigationController *homeNaigationController
      = [[UINavigationController alloc] initWithRootViewController:homeViewController];
  homeNaigationController.title = @"Home";

  RMBDiscoverViewController *discoverViewController = [[RMBDiscoverViewController alloc] init];
  UINavigationController *discoverNavigationController
      = [[UINavigationController alloc] initWithRootViewController:discoverViewController];
  discoverNavigationController.title = @"Discover";

  RMBWorkspaceViewController *workspaceViewController = [[RMBWorkspaceViewController alloc] init];
  UINavigationController *workspaceNavigationController
      = [[UINavigationController alloc] initWithRootViewController:workspaceViewController];
  workspaceNavigationController.title = @"Workspace";

  self.viewControllers = @[homeNaigationController, discoverNavigationController, workspaceNavigationController];
  self.selectedIndex = 0;
}

@end
