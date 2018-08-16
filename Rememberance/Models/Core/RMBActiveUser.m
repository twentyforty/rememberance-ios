//
//  RMBActiveUser.m
//  Rememberance
//
//  Created by Aly Ibrahim on 7/16/18.
//  Copyright © 2018 Aly Ibrahim. All rights reserved.
//

#import "RMBActiveUser.h"
#import "RMBClient.h"
#import "OVCResponse.h"

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
                      parameters:@{@"username": username, @"password": password} completion:^(OVCResponse * _Nullable response, NSError * _Nullable error) {
                        if (error) {
                          NSLog(@"failure");
                          if (failure) {
                            failure(@"failed");
                          }
                        } else {
                          [self saveTokenToDisk:response.result];
                          [self reloadFromServerWithSuccess:success failure:failure];
                        }
                      }];
}

+ (void)registerWithUsername:(NSString *)username
                    password:(NSString *)password
                       email:(NSString *)email
                     success:(RMBCompletion)success
                     failure:(RMBFailure)failure {
  [self saveTokenToDisk:nil];
  [[RMBClient sharedClient] POST:@"users/register/"
                      parameters:@{@"username": username, @"password": password, @"email": email}
                      completion:^(OVCResponse * _Nullable response, NSError * _Nullable error) {
                        if (error) {
                          if (failure) {
                            failure(error.localizedDescription);
                          }
                        } else {
                          if (response.result[@"registered"]) {
                            [self authorizeWithUsername:username password:password success:success failure:failure];
                          } else if ([response.result[@"errors"] count] > 0) {
                            if (failure) {
                              failure([response.result[@"errors"] componentsJoinedByString:@"\r\n"]);
                            }
                          } else {
                            if (failure) {
                              failure(@"Unknown failure.");
                            }
                          }
                        }
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
    [self saveTokenToDisk:nil];
    failure(@"first sign in");
  }
}

+ (void)reloadFromServerWithSuccess:(RMBCompletion)success failure:(RMBFailure)failure {
  [[RMBClient sharedClient] GET:@"users/me/"
                     parameters:nil
                     completion:^(OVCResponse * _Nullable response, NSError * _Nullable error) {
                       if (error) {
                         [self saveTokenToDisk:nil];
                         if (failure) {
                           failure(@"failed");
                         }
                       } else {
                         [[self class] setActiveUser:response.result];
                         [[self class] saveActiveUserToDisk];
                         if (success) {
                           success();
                         }
                       }
                     }];
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
  if (storedToken != nil) {
    [RMBClient sharedClient].token = storedToken;
    return YES;
  }
  return NO;
}

+ (void)saveTokenToDisk:(NSString *)token {
  [RMBClient sharedClient].token = token;
  if (token) {
    [[NSUserDefaults standardUserDefaults] setObject:token forKey:@"usertoken"];
  } else {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"usertoken"];
  }
}

+ (void)logout {
  [self saveTokenToDisk:nil];
  [self setActiveUser:nil];
  [self saveActiveUserToDisk];
}

@end
