//
//  RMBActiveUser.h
//  Rememberance
//
//  Created by Aly Ibrahim on 7/16/18.
//  Copyright © 2018 Aly Ibrahim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RMBUser.h"
#import "RMBUtils.h"

@interface RMBActiveUser : RMBUser

+ (RMBActiveUser *)sharedUser;

+ (void)authorizeWithUsername:(NSString *)username
                     password:(NSString *)password
                      success:(RMBCompletion)success
                      failure:(RMBFailure)failure;

+ (void)registerWithUsername:(NSString *)username
                    password:(NSString *)password
                       email:(NSString *)email
                     success:(RMBCompletion)success
                     failure:(RMBFailure)failure;

+ (void)reloadWithSuccess:(RMBCompletion)success failure:(RMBFailure)failure;

+ (void)logout;

@end
