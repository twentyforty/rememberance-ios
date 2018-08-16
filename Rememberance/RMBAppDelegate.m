//
//  AppDelegate.m
//  Rememberance
//
//  Created by Aly Ibrahim on 7/15/18.
//  Copyright © 2018 Aly Ibrahim. All rights reserved.
//

#import "RMBAppDelegate.h"
#import "RMBRootViewController.h"
#import "RMBActiveUser.h"
#import "UIColor+RMBAdditions.h"


@interface RMBAppDelegate ()

@property (strong, nonatomic, readwrite) RMBRootViewController *rootViewController;

@end

@implementation RMBAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  self.rootViewController = [RMBRootViewController sharedController];
  self.window.rootViewController = self.rootViewController;
  [self.window makeKeyAndVisible];
  
  [[UINavigationBar appearance] setTintColor:[UIColor renovatioRed]];
  [[UINavigationBar appearance] setBarTintColor:[UIColor renovatioBackground]];
  [[UINavigationBar appearance] setTitleTextAttributes:
      @{NSForegroundColorAttributeName : [UIColor renovatioRed]}];
  [UINavigationBar appearance].translucent = NO;

  [[UITabBar appearance] setTintColor:[UIColor renovatioRed]];
  [[UITabBar appearance] setBarTintColor:[UIColor renovatioBackground]];
//  [[UITabBar appearance] setTitleTextAttributes:
//   @{NSForegroundColorAttributeName : [UIColor renovatioRed]}];
  [UITabBar appearance].translucent = NO;
  
  [UITableView appearance].separatorInset = UIEdgeInsetsZero;
  
  [UINavigationBar.appearance setBackIndicatorImage:[UIImage imageNamed:@"back_button"]];

  if(@available(iOS 11, *)) {
    [[UIBarButtonItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor clearColor]} forState:UIControlStateNormal];
    [[UIBarButtonItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor clearColor]} forState:UIControlStateHighlighted];
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(-300, 0) forBarMetrics:UIBarMetricsDefault];
  } else {
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(-300, 0) forBarMetrics:UIBarMetricsDefault];
  }

  for (NSString* family in [[UIFont familyNames] sortedArrayUsingSelector:@selector(compare:)])
  {
    NSLog(@"%@", family);

    for (NSString* name in [UIFont fontNamesForFamilyName: family])
    {
      NSLog(@"  %@", name);
    }
  }
  
  return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
  
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
