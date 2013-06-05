//
//  CCCreateClassController.h
//  CampusJungle
//
//  Created by Yulia Petryshena on 6/4/13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCViewController.h"
#import "CCTransaction.h"

@interface CCCreateClassController : CCViewController

- (id)initWithCollegeID:(NSString*)collegeID;
@property (nonatomic, strong) id <CCTransaction> classAddedTransaction;


@end
