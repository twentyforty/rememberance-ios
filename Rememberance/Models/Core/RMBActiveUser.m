//
//  RMBActiveUser.m
//  Rememberance
//
//  Created by Aly Ibrahim on 7/16/18.
//  Copyright © 2018 Aly Ibrahim. All rights reserved.
//

#import "RMBActiveUser.h"
#import "RMBClient.h"

@implementation RMBActiveUser

static RMBActiveUser *sharedUser = nil;

+ (RMBActiveUser *)sharedUser {
  static dispatch_once_t once;
  dispatch_once(&once, ^{
    sharedUser = [[RMBActiveUser alloc] init];
  });
  return sharedUser;
}

+ (void)authorizeWithUsername:(NSString *)username
                     password:(NSString *)password
                      success:(RMBCompletion)success
                      failure:(RMBFailure)failure {
  [[RMBClient sharedClient] POST:@"auth/token/"
                      parameters:@{@"username": username, @"password": password}
                        progress:nil
                         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                           NSString *token = responseObject[@"token"];
                           [[self class] saveTokenToDisk:token];
                           [[self class] reloadFromServerWithSuccess:nil failure:failure];
                           if (success) {
                             success();
                           }
                      } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                        RMBClient.sharedClient.token = nil;
                        NSLog(@"failure");
                      }];
}

+ (void)reloadWithSuccess:(RMBCompletion)success failure:(RMBFailure)failure {
  if (sharedUser != nil && [RMBClient sharedClient].token != nil) {
    if (success) {
      success();
    }
  } else if ([RMBClient sharedClient].token != nil || [self loadTokenFromDisk]) {
    if ([self loadActiveUserFromDisk]) {
      if (success) {
        success(); // succeed early and refresh active user model as it may have changed
      }
      [[self class] reloadFromServerWithSuccess:nil failure:failure];
    } else {
      [[self class] reloadFromServerWithSuccess:success failure:failure];
    }
  } else {
    failure(@"first sign in");
  }
}

+ (void)reloadFromServerWithSuccess:(RMBCompletion)success failure:(RMBFailure)failure {
  [[RMBClient sharedClient] GET:@"users/me/"
                     parameters:nil
                       progress:nil
                        success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                          [[self class] setActiveUserWithDictionary:responseObject success:success failure:failure];
                        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                          failure(@"failed");
                        }];
}

+ (void)setActiveUserWithDictionary:(NSDictionary *)dictionary
                            success:(RMBCompletion)success
                            failure:(RMBFailure)failure {
  NSError *error;
  RMBActiveUser *activeUser =
    [MTLJSONAdapter modelOfClass:RMBActiveUser.class
              fromJSONDictionary:dictionary
                           error:&error];
  if (error && failure) {
    failure(@"error deserializing");
  } else {
    [[self class] setActiveUser:activeUser];
    [[self class] saveActiveUserToDisk];
    if (success) {
      success();
    }
  }
}

+ (void)setActiveUser:(RMBActiveUser *)activeUser {
  sharedUser = activeUser;
}

+ (BOOL)loadActiveUserFromDisk {
  NSData *activeUserDataFromDisk = [[NSUserDefaults standardUserDefaults] objectForKey:@"activeuser"];
  RMBActiveUser *activeUserFromDisk = [NSKeyedUnarchiver unarchiveObjectWithData:activeUserDataFromDisk];
  if (activeUserFromDisk) {
    [[self class] setActiveUser:activeUserFromDisk];
    return YES;
  } else {
    return NO;
  }
}

+ (void)saveActiveUserToDisk {
  NSData *data = [NSKeyedArchiver archivedDataWithRootObject:sharedUser];
  [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"activeuser"];
}

+ (BOOL)loadTokenFromDisk {
  NSString *storedToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"usertoken"];
//  storedToken = @"afa9596783857941a4ff367f00d445ab1f363610";
  storedToken = @"95cca5ea679c8c22e1de51ef621acc729fff0f18";
  if (storedToken != nil) {
    [RMBClient sharedClient].token = storedToken;
    return YES;
  }
  return NO;
}

+ (void)saveTokenToDisk:(NSString *)token {
  [RMBClient sharedClient].token = token;
  [[NSUserDefaults standardUserDefaults] setObject:token forKey:@"usertoken"];
}

@end
