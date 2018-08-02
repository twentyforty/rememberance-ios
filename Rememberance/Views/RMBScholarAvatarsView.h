//
//  RMBScholarAvatarsView.h
//  Rememberance
//
//  Created by Aly Ibrahim on 8/1/18.
//  Copyright © 2018 Aly Ibrahim. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RMBScholar.h"

@interface RMBScholarAvatarsView : UIView

- (instancetype)initWithSize:(CGFloat)avatarSize
            interItemSpacing:(CGFloat)interItemSpacing;

+ (CGFloat)widthWithScholars:(NSArray<RMBScholar *> *)scholars
                        size:(CGFloat)avatarSize
            interItemSpacing:(CGFloat)interItemSpacing;

@property (strong, nonatomic, readwrite) NSArray<RMBScholar *> *scholars;

@end
