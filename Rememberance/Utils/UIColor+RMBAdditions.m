//
//  UIColor+RMBAdditions.m
//  Rememberance
//
//  Created by Aly Ibrahim on 7/21/18.
//  Copyright © 2018 Aly Ibrahim. All rights reserved.
//

#import "UIColor+RMBAdditions.h"

@implementation UIColor (RMBAdditions)

+ (UIColor *)colorWithR:(CGFloat)red G:(CGFloat)green B:(CGFloat)blue A:(CGFloat)alpha {
  return [UIColor colorWithRed:(red/255.0) green:(green/255.0) blue:(blue/255.0) alpha:alpha];
}

+ (UIColor *)renovatioRed {
  return [UIColor colorWithR:129 G:38 B:35 A:1];
}

+ (UIColor *)renovatioBackground {
  return [UIColor colorWithR:226 G:220 B:198 A:1];
}
@end
