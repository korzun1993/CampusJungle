//
//  CCAddProfessorUploadsTransaction.h
//  CampusJungle
//
//  Created by Vlad Korzun on 18.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCTransactionWithObject.h"

@interface CCAddProfessorUploadsTransaction : NSObject<CCTransactionWithObject>

@property (nonatomic, strong) UINavigationController *navigation;

@end