//
//  RMBScholarBioCell.h
//  Rememberance
//
//  Created by Aly Ibrahim on 7/21/18.
//  Copyright © 2018 Aly Ibrahim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "RMBScholar.h"

@interface RMBScholarBioCell : UITableViewCell

@property (strong, nonatomic, readwrite) RMBScholar *scholar;
@property (assign, nonatomic, readwrite) BOOL expanded;

@end
