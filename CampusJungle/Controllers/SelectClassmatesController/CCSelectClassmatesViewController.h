//
//  CCSelectClassmatesViewController.h
//  CampusJungle
//
//  Created by Yury Grinenko on 11.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCTableBaseViewController.h"
#import "CCShareItemBlocksDefines.h"
#import "CCTransaction.h"

@class CCClass, CCGroup;

@interface CCSelectClassmatesViewController : CCTableBaseViewController

@property (nonatomic, strong) id<CCTransaction> backTransaction;

- (void)setClass:(CCClass *)classObject;
- (void)setGroup:(CCGroup *)group;
- (void)setSuccessBlock:(ShareItemButtonSuccessBlock)successBlock;
- (void)setCancelBlock:(ShareItemButtonCancelBlock)cancelBlock;

@end
