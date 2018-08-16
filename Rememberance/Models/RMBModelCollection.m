//
//  RMBModelCollection.m
//  Rememberance
//
//  Created by Aly Ibrahim on 7/17/18.
//  Copyright © 2018 Aly Ibrahim. All rights reserved.
//

#import "RMBModelCollection.h"
#import "RMBClient.h"
#import "OVCResponse.h"

@interface RMBModelCollection ()

@property (strong, nonatomic) NSMutableArray<RMBModel *> *objects;
@property (strong, nonatomic) NSString *relativeRemotePath;
@property (assign, nonatomic) Class modelClass;
@property (copy, nonatomic) NSString *limit;
@property (copy, nonatomic) NSString *offset;

@end

@implementation RMBModelCollection

- (instancetype)initWithModelClass:(Class)modelClass
             andRelativeRemotePath:(NSString *)relativeRemotePath {
  if (self = [super init]) {
    self.relativeRemotePath = relativeRemotePath;
    self.modelClass = modelClass;
    self.limit = @"20";
    self.objects = [NSMutableArray array];
  }
  return self;
}

- (RMBModel *)objectAtIndex:(NSUInteger)index {
  return self.objects[index];
}

- (NSUInteger)count {
  return self.objects.count;
}

- (void)loadObjectsWithSuccess:(RMBCompletion)success failure:(RMBFailure)failure {
  self.offset = nil;
  [self loadObjectsWithSuccess:success failure:failure reload:YES];
}

- (void)loadObjectsWithSuccess:(RMBCompletion)success failure:(RMBFailure)failure reload:(BOOL)reload {
  if (self.loading) {
    return;
  }
  self.loading = YES;
  NSDictionary *paramters = [self parametersForRequest];
  [[RMBClient sharedClient] GET:self.relativeRemotePath
                     parameters:paramters
                     completion:^(OVCResponse * _Nullable response, NSError * _Nullable error) {
                       self.loading = NO;
                       if (error) {
                         failure(@"error");
                       } else {
                         if (reload) {
                           [self.objects removeAllObjects];
                         }
                         [self.objects addObjectsFromArray:response.result];
                         [self parseNextParameterFromResponseObject:response.rawResult];
                         if (success) {
                           success();
                         }
                       }
                     }];
}

- (NSDictionary *)parametersForRequest {
  NSMutableDictionary *requestParamters = [NSMutableDictionary dictionaryWithDictionary:self.additionalParameters];
  if (self.limit) {
    requestParamters[@"limit"] = self.limit;
  }
  if (self.offset) {
    requestParamters[@"offset"] = self.offset;
  }
  if (self.fieldSet) {
    requestParamters[@"fields"] = [self.fieldSet generateFieldsQueryParameterValue];
  }
  return requestParamters;
}

- (void)parseNextParameterFromResponseObject:(id)responseObject {
  NSString *next = responseObject[@"next"];
  if (next != nil && ![next isEqual:[NSNull null]]) {
    NSURLComponents *components = [NSURLComponents componentsWithString:next];
    for (NSURLQueryItem *item in [components queryItems]) {
      if ([item.name isEqualToString:@"offset"]) {
        self.offset = item.value;
      }
      if ([item.name isEqualToString:@"limit"]) {
        self.limit = item.value;
      }
    }
  } else {
    self.offset = nil;
  }
}

- (void)deserializeResults:(id)responseObject completion:(RMBCompletion)completion {
  NSError *error;
  [self.objects addObjectsFromArray:[MTLJSONAdapter modelsOfClass:self.modelClass fromJSONArray:responseObject[@"results"] error:&error]];
  if (completion) {
    completion();
  }
}

- (void)loadNextObjectsWithSuccess:(RMBCompletion)success failure:(RMBFailure)failure {
  if (self.offset) {
    [self loadObjectsWithSuccess:success failure:failure reload:NO];
  }
}

- (BOOL)hasMoreObjects {
  return self.offset != nil;
}

- (void)clear {
  self.offset = nil;
  [self.objects removeAllObjects];
}

@end
