//
//  CCInitialUserInfoTransaction.h
//  CollegeConnect
//
//  Created by Vlad Korzun on 23.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCTransaction.h"
#import "CCMenuController.h"

@interface CCInitialUserProfileTransaction : NSObject <CCTransaction>

@property (nonatomic, strong) id<CCTransaction> loginTransaction;
@property (nonatomic, strong) CCMenuController *baseViewController;


@end