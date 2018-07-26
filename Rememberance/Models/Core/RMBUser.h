//
//  RMBUser.h
//  Rememberance
//
//  Created by Aly Ibrahim on 7/16/18.
//  Copyright © 2018 Aly Ibrahim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RMBModel.h"

@interface RMBUser : RMBModel

@property (copy, nonatomic) NSString *email;
@property (copy, nonatomic) NSString *username;
@property (copy, nonatomic) NSString *bio;

@end
