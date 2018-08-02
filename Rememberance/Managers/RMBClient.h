//
//  RMBClient.h
//  Rememberance
//
//  Created by Aly Ibrahim on 7/16/18.
//  Copyright © 2018 Aly Ibrahim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "OVCHTTPSessionManager.h"

typedef void (^RMBClientSuccess)(id responseObject);
typedef void (^RMBClientFailure)(NSString *failureReason, NSInteger statusCode);

@interface RMBClient : OVCHTTPSessionManager

@property (strong, nonatomic) NSString *token;

+ (RMBClient *)sharedClient;

@end
