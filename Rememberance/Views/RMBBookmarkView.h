//
//  RMBBookmarkView.h
//  Rememberance
//
//  Created by Aly Ibrahim on 8/2/18.
//  Copyright © 2018 Aly Ibrahim. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RMBBookmarkView : UIView

@property (assign, nonatomic, readwrite) BOOL bookmarked;

- (instancetype)initWithSize:(CGFloat)size permanent:(BOOL)permanent;
- (void)setBookmarked:(BOOL)bookmarked animated:(BOOL)animated;

@end
