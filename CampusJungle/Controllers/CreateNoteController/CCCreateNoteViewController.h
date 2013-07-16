//
//  CCCreateNoteViewController.h
//  CampusJungle
//
//  Created by Vlad Korzun on 07.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCViewController.h"
#import "CCTransactionWithObject.h"
#import "CCTransaction.h"

@interface CCCreateNoteViewController : CCViewController

@property (nonatomic, strong) id <CCTransactionWithObject> imagesDropboxUploadTransaction;
@property (nonatomic, strong) id <CCTransactionWithObject> pdfDropboxUploadTransaction;
@property (nonatomic, strong) id <CCTransactionWithObject> imagesUploadTransaction;
@property (nonatomic, strong) id <CCTransaction> backToListTransaction;

- (IBAction)thumbDidPressed;
- (IBAction)collegeSelectionButtonDidPressed;
- (IBAction)classSelectionButtonDidPresed;

@end
