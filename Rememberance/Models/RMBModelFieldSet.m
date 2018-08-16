//
//  RMBModelFieldSet.m
//  Rememberance
//
//  Created by Aly Ibrahim on 8/4/18.
//  Copyright © 2018 Aly Ibrahim. All rights reserved.
//

#import "RMBModelFieldSet.h"

@interface RMBModelFieldSet ()

@property (strong, nonatomic, readwrite) NSMutableArray *qualifiedFields;

@end

@implementation RMBModelFieldSet

- (instancetype)init {
  if (self = [super init]) {
    _qualifiedFields = [NSMutableArray array];
  }
  return self;
}

+ (RMBModelFieldSet *)summaryFieldSetForModelClass:(Class)modelClass {
  RMBModelFieldSet *fieldSet = [[RMBModelFieldSet alloc] init];
  [fieldSet andSummaryFieldsForModelClass:modelClass];
  return fieldSet;
}

+ (RMBModelFieldSet *)detailFieldSetForModelClass:(Class)modelClass {
  RMBModelFieldSet *fieldSet = [[RMBModelFieldSet alloc] init];
  [fieldSet andDetailFieldsForModelClass:modelClass];
  return fieldSet;
}

+ (RMBModelFieldSet *)fieldSetForPropertyKeys:(NSArray *)propertyKeys forModelClass:(Class)modelClass {
  RMBModelFieldSet *fieldSet = [[RMBModelFieldSet alloc] init];
  [fieldSet andFieldSetForPropertyKeys:propertyKeys forModelClass:modelClass];
  return fieldSet;
}

- (RMBModelFieldSet *)andDetailFieldsForModelClass:(Class)modelClass {
  [self addFieldsForPropertyKeys:[modelClass detailPropertyKeys] forModelClass:modelClass];
  return self;
}

- (RMBModelFieldSet *)andSummaryFieldsForModelClass:(Class)modelClass {
  [self addFieldsForPropertyKeys:[modelClass defaultSummaryPropertyKeys] forModelClass:modelClass];
  return self;
}

- (RMBModelFieldSet *)andFieldSetForPropertyKeys:(NSArray *)propertyKeys forModelClass:(Class)modelClass {
  [self addFieldsForPropertyKeys:propertyKeys forModelClass:modelClass];
  return self;
}

- (void)addFieldsForPropertyKeys:(NSArray *)propertyKeys forModelClass:(Class)modelClass {
  for (NSString *propertyKey in propertyKeys) {
    NSString *JSONKeyPath = [modelClass JSONKeyPathsByPropertyKey][propertyKey];
    if (JSONKeyPath) {
      [self.qualifiedFields addObject:[NSString stringWithFormat:@"%@.%@", [modelClass serverModelName], JSONKeyPath]];
    }
  }
}

- (NSString *)generateFieldsQueryParameterValue {
  return [self.qualifiedFields componentsJoinedByString:@","];
}

@end
