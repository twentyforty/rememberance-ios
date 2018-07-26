//
//  UINavigationController+RMBAdditions.m
//  Rememberance
//
//  Created by Aly Ibrahim on 7/19/18.
//  Copyright © 2018 Aly Ibrahim. All rights reserved.
//

#import "UINavigationController+RMBAdditions.h"

@implementation UINavigationController (RMBAdditions)

- (void)gsk_setNavigationBarTransparent:(BOOL)transparent
                               animated:(BOOL)animated {
  [UIView animateWithDuration:animated ? 0.33 : 0 animations:^{
    if (transparent) {
      [self.navigationBar setBackgroundImage:[UIImage new]
                               forBarMetrics:UIBarMetricsDefault];
      self.navigationBar.shadowImage = [UIImage new];
      self.navigationBar.translucent = YES;
      self.view.backgroundColor = [UIColor clearColor];
      self.navigationBar.backgroundColor = [UIColor clearColor];
    } else {
      [self.navigationBar setBackgroundImage:nil
                               forBarMetrics:UIBarMetricsDefault];
    }
  }];
}

@end
