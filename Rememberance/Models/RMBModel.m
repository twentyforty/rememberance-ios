//
//  RMBModel.m
//  Rememberance
//
//  Created by Aly Ibrahim on 7/17/18.
//  Copyright © 2018 Aly Ibrahim. All rights reserved.
//

#import "RMBModel.h"
#import "RMBClient.h"
#import "RMBModelFieldSet.h"
#import "OVCResponse.h"

@implementation RMBModel

+ (NSString *)serverModelName {
  [[NSException exceptionWithName:NSInternalInconsistencyException reason:@"subclasses must implement this method" userInfo:nil] raise];
  return nil;
}

+ (NSArray<NSString *> *)defaultSummaryPropertyKeys {
  return @[@"identifier"];
}

+ (NSArray<NSString *> *)detailPropertyKeys {
  return @[@"identifier"];
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
  return @{@"identifier": @"id"};
}

+ (NSString *)resourcePathFormat {
  [[NSException exceptionWithName:NSInternalInconsistencyException reason:@"implement this" userInfo:nil] raise];
  return nil;
}

- (void)loadDetailsWithSuccess:(RMBCompletion)completion {
  NSString *path = [NSString stringWithFormat:[[self class] resourcePathFormat], self.identifier];
  NSDictionary *paramters = @{@"fields": [[RMBModelFieldSet detailFieldSetForModelClass:[self class]] generateFieldsQueryParameterValue]};
  [[RMBClient sharedClient] GET:path parameters:paramters completion:^(OVCResponse * _Nullable response, NSError * _Nullable error) {
    [self mergeValuesForKeysFromModel:response.result];
    if (completion) {
      completion();
    }
  }];
}
@end
