//
//  CCBackToUserProfileTransaction.h
//  CampusJungle
//
//  Created by Vlad Korzun on 30.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCTransactionWithObject.h"

@interface CCBackToUserProfileTransaction : NSObject <CCTransactionWithObject>

@property (nonatomic, strong)UINavigationController *navigation;
@property (nonatomic, strong)NSMutableArray *arrayOfColleges;

@end
