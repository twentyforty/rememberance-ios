//
//  RMBUnauthViewController.h
//  Rememberance
//
//  Created by Aly Ibrahim on 7/16/18.
//  Copyright © 2018 Aly Ibrahim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol RMBUnauthViewControllerDelegate

- (void)userLoggedIn;

@end

@interface RMBUnauthViewController : UIViewController

@property (weak, nonatomic, readwrite) id<RMBUnauthViewControllerDelegate> delegate;

@end
