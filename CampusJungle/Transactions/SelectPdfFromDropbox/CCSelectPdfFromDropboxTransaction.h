//
//  CCSelectPdfFromDropboxTransaction.h
//  CampusJungle
//
//  Created by Vlad Korzun on 08.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCDropboxImagesSelectionTransaction.h"
#import "CCTransactionWithObject.h"

@interface CCSelectPdfFromDropboxTransaction : CCDropboxImagesSelectionTransaction

@property (nonatomic, weak) UINavigationController *navigation;

@end
