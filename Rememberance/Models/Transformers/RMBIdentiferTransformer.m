//
//  RMBIdentiferTransformer.m
//  Rememberance
//
//  Created by Aly Ibrahim on 7/17/18.
//  Copyright © 2018 Aly Ibrahim. All rights reserved.
//

#import "RMBIdentiferTransformer.h"

@implementation RMBIdentiferTransformer

+ (Class)transformedValueClass {
  return NSString.class;
}

+ (BOOL)allowsReverseTransformation {
  return YES;
}

- (id)transformedValue:(id)value {
  return [value stringValue];
}

@end
