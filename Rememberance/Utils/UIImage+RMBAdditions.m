//
//  UIImage+RMBAdditions.m
//  Rememberance
//
//  Created by Aly Ibrahim on 8/2/18.
//  Copyright © 2018 Aly Ibrahim. All rights reserved.
//

#import "UIImage+RMBAdditions.h"

@implementation UIImage (RMBAdditions)

- (UIImage *)imageTintedWithColor:(UIColor *)color {
  UIImage *image;
  if (color) {
    // Construct new image the same size as this one.
    UIGraphicsBeginImageContextWithOptions([self size], NO, 0.0); // 0.0 for scale means "scale for device's main screen".
    CGRect rect = CGRectZero;
    rect.size = [self size];
    
    // tint the image
    [self drawInRect:rect];
    [color set];
    UIRectFillUsingBlendMode(rect, kCGBlendModeScreen);
    
    // restore alpha channel
    [self drawInRect:rect blendMode:kCGBlendModeDestinationIn alpha:1.0f];
    
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
  }
  return image;
}

+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
  //UIGraphicsBeginImageContext(newSize);
  // In next line, pass 0.0 to use the current device's pixel scaling factor (and thus account for Retina resolution).
  // Pass 1.0 to force exact pixel size.
  UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
  [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
  UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  return newImage;
}

@end
