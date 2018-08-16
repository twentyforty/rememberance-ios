//
//  RMBClient.m
//  Rememberance
//
//  Created by Aly Ibrahim on 7/16/18.
//  Copyright © 2018 Aly Ibrahim. All rights reserved.
//

#import "RMBClient.h"
#import "RMBVideoSeries.h"
#import "RMBVideo.h"
#import "RMBScholar.h"
#import "RMBListResponse.h"
#import "RMBActiveUser.h"
#import "RMBTokenResponse.h"
#import "RMBActiveUserResponse.h"
#import "RMBSignupResponse.h"

#define DEV

@interface RMBClient ()

@end

@implementation RMBClient

static RMBClient *sharedClient = nil;

+ (RMBClient *)sharedClient {
  static dispatch_once_t once;
  dispatch_once(&once, ^{
#ifdef DEV
    NSURL *baseURL = [NSURL URLWithString:@"http://127.0.0.1:8000/api/v1/"];
#else
    NSURL *baseURL = [NSURL URLWithString:@"http://renovatio.herokuapp.com/api/v1/"];
#endif
    sharedClient = [[RMBClient alloc] initWithBaseURL:baseURL];
    sharedClient.securityPolicy = [RMBClient unsecureSecurityPolicy];
  });
  return sharedClient;
}

- (void)setToken:(NSString *)token {
  _token = token;
  if (token) {
    NSString *headerValue = [NSString stringWithFormat:@"Token %@", token];
    [self.requestSerializer setValue:headerValue forHTTPHeaderField:@"Authorization"];
  } else {
    [self.requestSerializer setValue:nil forHTTPHeaderField:@"Authorization"];
  }
}

+ (AFSecurityPolicy *)unsecureSecurityPolicy {
  AFSecurityPolicy *policy = [AFSecurityPolicy defaultPolicy];
  [policy setAllowInvalidCertificates:YES];
  [policy setValidatesDomainName:NO];
  return policy;
}

+ (NSDictionary<NSString *,id> *)responseClassesByResourcePath {
  return @{@"videos/*": [OVCResponse class],
           @"scholars/*": [OVCResponse class],
           @"auth/token": [RMBTokenResponse class],
           @"users/me": [RMBActiveUserResponse class],
           @"users/register": [RMBSignupResponse class],
           @"videos/continue": [RMBListResponse class],
           @"videos/bookmarked": [RMBListResponse class],
           @"**": [RMBListResponse class]};
}

+ (NSDictionary<NSString *,id> *)modelClassesByResourcePath {
  return @{
           @"videos/continue": [RMBVideo class],
           @"videos/bookmarked": [RMBVideo class],
           @"users/me": [RMBActiveUser class],
           @"videoseries": [RMBVideoSeries class],
           @"videoseries/*": [RMBVideoSeries class],
           @"videoseries/*/videos": [RMBVideo class],
           @"videos/*": [RMBVideo class],
           @"scholars": [RMBScholar class],
           @"scholars/*": [RMBScholar class],
           @"scholars/*/videos": [RMBVideo class],
           @"scholars/*/videoseries": [RMBVideoSeries class],
           };
}

@end
