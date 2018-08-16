//
//  RMBModel.h
//  Rememberance
//
//  Created by Aly Ibrahim on 7/17/18.
//  Copyright © 2018 Aly Ibrahim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Mantle.h"
#import "RMBUtils.h"
#import "NSDictionary+MTLManipulationAdditions.h"

@class RMBModelFieldSet;

@interface RMBModel : MTLModel <MTLJSONSerializing>

@property (assign, nonatomic) NSInteger identifier;

+ (NSString *)serverModelName;
+ (NSArray <NSString *>*)defaultSummaryPropertyKeys;
+ (NSArray <NSString *>*)detailPropertyKeys;

+ (NSString *)resourcePathFormat;
- (void)loadDetailsWithSuccess:(RMBCompletion)completion;

@end
