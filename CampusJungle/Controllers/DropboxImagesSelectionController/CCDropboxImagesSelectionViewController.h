//
//  CCDropboxSelectionViewController.h
//  CampusJungle
//
//  Created by Vlad Korzun on 04.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCTableBaseViewController.h"
#import "CCTransactionWithObject.h"
#import "CCNoteUploadInfo.h"
#import "CCDropboxDataProvider.h"
#import "CCTransaction.h"
#import "CCDropboxAPIProviderProtocol.h"

@interface CCDropboxImagesSelectionViewController : CCTableBaseViewController

@property (nonatomic, strong) id <CCDropboxAPIProviderProtocol> ioc_dropboxAPI;
@property (nonatomic, strong) CCDropboxDataProvider *dropboxDataProvider;
@property (nonatomic, strong) NSString *dropboxPath;
@property (nonatomic, strong) id <CCTransactionWithObject> dropboxFileSystemTransaction;
@property (nonatomic, strong) id <CCTransaction> backToListTransaction;
@property (nonatomic, strong) id <CCTransactionWithObject> imageSortingTransaction;
@property (nonatomic, strong) NSMutableArray *arrayOfSelectedFiles;
@property (nonatomic, strong) CCNoteUploadInfo *uploadInfo;
@property (nonatomic, copy) DropboxUploadingBlock uploadingBlock;

- (void)removeFrom:(NSMutableArray *)array infoWithPath:(NSString *)path;
- (BOOL)is:(NSArray *)array containPath:(NSString *)path;
- (void)setDoneButtonIfNeeded;

@end
