//
//  RMBScholar.h
//  Rememberance
//
//  Created by Aly Ibrahim on 7/16/18.
//  Copyright © 2018 Aly Ibrahim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RMBModel.h"
#import "RMBModelCollection.h"
#import "RMBVideo.h"

@interface RMBScholar : RMBModel

@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *bio;
@property (strong, nonatomic) NSURL *imageURL;

@end
