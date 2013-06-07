//
//  CCDropboxFileSelectionTransaction.h
//  CampusJungle
//
//  Created by Vlad Korzun on 04.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCTransactionWithObject.h"
#import "JASidePanelController.h"

@interface CCDropboxFileSelectionTransaction : NSObject <CCTransactionWithObject>

@property (nonatomic, strong) JASidePanelController *menuController;

@end
