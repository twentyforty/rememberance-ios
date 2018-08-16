//
//  RMBSinupViewController.h
//  Rememberance
//
//  Created by Aly Ibrahim on 8/16/18.
//  Copyright © 2018 Aly Ibrahim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RMBUnauthViewController.h"

@interface RMBSignupViewController : UIViewController

@property (weak, nonatomic, readwrite) id<RMBUnauthViewControllerDelegate> delegate;

@end
