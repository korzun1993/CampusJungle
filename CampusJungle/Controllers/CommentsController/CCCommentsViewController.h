//
//  CCCommentsViewController.h
//  CampusJungle
//
//  Created by Yury Grinenko on 17.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCTableBaseViewController.h"

@class CCAnswer;

@interface CCCommentsViewController : CCTableBaseViewController

- (void)setAnswer:(CCAnswer *)answer;

@end
