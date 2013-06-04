//
//  CCAllClassesTransaction.m
//  CampusJungle
//
//  Created by Yulia Petryshena on 5/31/13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCAllClassesTransaction.h"
#import "CCClassesController.h"
#import "CCClassTransaction.h"
#import "CCAddClassTransaction.h"

@implementation CCAllClassesTransaction

- (void)perform
{
    NSParameterAssert(self.menuController);
    CCClassesController *classesController = [CCClassesController new];
    
    
    classesController.addClassTransaction = [CCAddClassTransaction new];
    
    
    
    UINavigationController *centralNavigation = [[UINavigationController alloc] initWithRootViewController:classesController];
    CCClassTransaction *classTransaction = [CCClassTransaction new];
    classTransaction.navigation = centralNavigation;
    classesController.classTransaction = classTransaction;
    
    self.menuController.centerPanel = centralNavigation;
}

@end
