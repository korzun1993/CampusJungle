//
//  CCEducationCell.h
//  CampusJungle
//
//  Created by Vlad Korzun on 30.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCTableCellProtocol.h"
#import "CCBaseCell.h"

@interface CCEducationCell : CCBaseCell<CCTableCellProtocol>

@property (nonatomic, strong) id cellObject;

@end