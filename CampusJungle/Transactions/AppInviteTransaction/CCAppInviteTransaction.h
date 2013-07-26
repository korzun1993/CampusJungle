//
//  CCAppInviteTransaction.h
//  CampusJungle
//
//  Created by Yury Grinenko on 26.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCTransactionWithObject.h"

@interface CCAppInviteTransaction : NSObject <CCTransactionWithObject>

@property (nonatomic, strong) UINavigationController *navigation;

@end