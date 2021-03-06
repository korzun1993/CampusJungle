//
//  CCMyStuffTransaction.m
//  CampusJungle
//
//  Created by Vlad Korzun on 20.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCMyStuffTransaction.h"
#import "CCMyStuffController.h"
#import "CCCreateStuffTransaction.h"
#import "CCBackToControllerTransaction.h"
#import "CCStuffDetailsTransaction.h"

@implementation CCMyStuffTransaction

- (void)perform
{
    NSParameterAssert(self.navigation);
    CCMyStuffController *myStuffController = [CCMyStuffController new];
    
    CCCreateStuffTransaction *creationStuffTransaction = [CCCreateStuffTransaction new];
    creationStuffTransaction.navigation = self.navigation;
    myStuffController.createStuffTransaction = creationStuffTransaction;

    
    CCBackToControllerTransaction *backToListTransaction = [CCBackToControllerTransaction new];
    backToListTransaction.navigation = self.navigation;
    backToListTransaction.targetController = myStuffController;
    
    creationStuffTransaction.backToListTransaction = backToListTransaction;
    
    CCStuffDetailsTransaction *stuffDetailsTransaction = [CCStuffDetailsTransaction new];
    stuffDetailsTransaction.navigation = self.navigation;
    
    myStuffController.stuffDetailsTransaction = stuffDetailsTransaction;
    
    [self.navigation pushViewController:myStuffController animated:YES];

}

@end
