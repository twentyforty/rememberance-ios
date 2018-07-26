//
//  RMBModelCollection.m
//  Rememberance
//
//  Created by Aly Ibrahim on 7/17/18.
//  Copyright © 2018 Aly Ibrahim. All rights reserved.
//

#import "RMBModelCollection.h"
#import "RMBClient.h"

@interface RMBModelCollection ()

@property (strong, nonatomic) NSMutableArray<RMBModel *> *objects;
@property (strong, nonatomic) NSString *relativeRemotePath;
@property (assign, nonatomic) Class modelClass;
@property (copy, nonatomic) NSString *limit;
@property (copy, nonatomic) NSString *offset;
@property (strong, nonatomic) NSURLSessionDataTask *currentTask;

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
  self.currentTask =
      [[RMBClient sharedClient] GET:self.relativeRemotePath
                         parameters:[self parametersForRequest]
                           progress:nil
                            success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                              if (self.currentTask == task) {
                                [self parseNextParameterFromResponseObject:responseObject];
                                [self deserializeResults:responseObject completion:success];
                              }
                            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                              if (failure) {
                                failure(@"error");
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
    [self loadObjectsWithSuccess:success failure:failure];
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
