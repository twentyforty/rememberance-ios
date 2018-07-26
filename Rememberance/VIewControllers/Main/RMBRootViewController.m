//
//  RMBRootViewController.m
//  Rememberance
//
//  Created by Aly Ibrahim on 7/15/18.
//  Copyright © 2018 Aly Ibrahim. All rights reserved.
//

#import "RMBRootViewController.h"
#import "AFNetworking.h"
#import "RMBActiveUser.h"
#import "RMBSplashViewController.h"
#import "RMBUnauthViewController.h"
#import "RMBMainViewController.h"

@interface RMBRootViewController ()

@property (strong, nonatomic) RMBUnauthViewController *unauthViewController;
@property (strong, nonatomic) RMBMainViewController *mainViewController;

@property (strong, nonatomic) UIViewController *current;

@end

@implementation RMBRootViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  RMBSplashViewController *splashViewController = [[RMBSplashViewController alloc] init];
  self.current = splashViewController;

  [self addChildViewController:splashViewController];
  splashViewController.view.frame = self.view.bounds;
  [self.view addSubview:splashViewController.view];
  [splashViewController didMoveToParentViewController:self];

  [RMBActiveUser reloadWithSuccess:^{
    [self switchToMainViewController];
  } failure:^(NSString *message) {
    [self switchToUnauthViewContoller];
  }];
}

- (void)switchToUnauthViewContoller {
  RMBUnauthViewController *unauthViewController = [[RMBUnauthViewController alloc] init];
  UINavigationController *navigationController
      = [[UINavigationController alloc] initWithRootViewController:unauthViewController];
  
  [self animateFadeTransitionToViewController:navigationController completion:nil];
//  [self.current willMoveToParentViewController: nil];
//  [self.current.view removeFromSuperview];
//  [self.current removeFromParentViewController];
//
//  [self addChildViewController:navigationController];
//  navigationController.view.frame = self.view.bounds;
//  [self.view addSubview:navigationController.view];
//  [navigationController didMoveToParentViewController:self];
//
//  self.current = navigationController;
}

- (void)switchToMainViewController {
  RMBMainViewController *mainViewController = [[RMBMainViewController alloc] init];
  [self animateFadeTransitionToViewController:mainViewController completion:nil];
}

- (void)animateFadeTransitionToViewController:(UIViewController *)toViewController
                                   completion:(RMBCompletion)completion {
  [self.current willMoveToParentViewController:nil];
  [self addChildViewController:toViewController];
  toViewController.view.alpha = 0;
  [self transitionFromViewController:self.current
                    toViewController:toViewController
                            duration:1
                             options:UIViewAnimationOptionTransitionCrossDissolve | UIViewAnimationCurveEaseOut
                          animations:^{
                            self.current.view.alpha = 0;
                            toViewController.view.alpha = 1;
                          }
                          completion:^(BOOL finished) {
                            [self.current removeFromParentViewController];
                            [toViewController didMoveToParentViewController:self];
                            self.current = toViewController;
                            if (completion) {
                              completion();
                            }
                          }];
}


@end
