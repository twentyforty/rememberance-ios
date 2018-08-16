//
//  RMBModelFieldSet.h
//  Rememberance
//
//  Created by Aly Ibrahim on 8/4/18.
//  Copyright © 2018 Aly Ibrahim. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "RMBModel.h"

@interface RMBModelFieldSet : NSObject

+ (RMBModelFieldSet *)summaryFieldSetForModelClass:(Class)modelClass;

+ (RMBModelFieldSet *)detailFieldSetForModelClass:(Class)modelClass;

+ (RMBModelFieldSet *)fieldSetForPropertyKeys:(NSArray *)propertyKeys forModelClass:(Class)modelClass;

- (RMBModelFieldSet *)andSummaryFieldsForModelClass:(Class)modelClass;

- (RMBModelFieldSet *)andDetailFieldsForModelClass:(Class)modelClass;

- (RMBModelFieldSet *)andFieldSetForPropertyKeys:(NSArray *)propertyKeys forModelClass:(Class)modelClass;

- (NSString *)generateFieldsQueryParameterValue;

@end
