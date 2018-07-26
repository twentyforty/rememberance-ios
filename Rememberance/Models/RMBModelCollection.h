//
//  RMBModelCollection.h
//  Rememberance
//
//  Created by Aly Ibrahim on 7/17/18.
//  Copyright © 2018 Aly Ibrahim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RMBModel.h"

//@protocol RMBModelCollectionDelegate
//
//- (void)collectionDidChange;
//
//@end

@interface RMBModelCollection <__covariant ObjectType:RMBModel *> : NSObject

//@property (weak, nonatomic) id<RMBModelCollectionDelegate> delegate;
@property (strong, nonatomic) NSDictionary *additionalParameters;

- (instancetype)initWithModelClass:(Class)modelClass
             andRelativeRemotePath:(NSString *)relativeRemotePath;

- (NSUInteger)count;
- (ObjectType)objectAtIndex:(NSUInteger)index;


- (void)loadObjectsWithSuccess:(RMBCompletion)success failure:(RMBFailure)failure;
- (void)loadNextObjectsWithSuccess:(RMBCompletion)success failure:(RMBFailure)failure;

- (BOOL)hasMoreObjects;

- (void)clear;



@end
