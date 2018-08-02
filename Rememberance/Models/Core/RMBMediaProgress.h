//
//  RMBMediaProgress.h
//  Rememberance
//
//  Created by Aly Ibrahim on 7/30/18.
//  Copyright © 2018 Aly Ibrahim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Mantle.h"

@interface RMBMediaProgress : MTLModel <MTLJSONSerializing>

@property (copy, nonatomic) NSNumber *completed;
@property (copy, nonatomic) NSNumber *position;

@end
