//
//  CCCitySelectionTransaction.h
//  CampusJungle
//
//  Created by Vlad Korzun on 29.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCTransactionWithObject.h"

@interface CCCitySelectionTransaction : NSObject<CCTransactionWithObject>

@property (nonatomic, weak) UINavigationController* navigation;
@property (nonatomic, strong)NSMutableArray *arrayOfColleges;

@end
