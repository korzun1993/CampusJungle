//
//  CCBaseReverseDataProvider.m
//  CampusJungle
//
//  Created by Yury Grinenko on 17.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCBaseReverseDataProvider.h"

@implementation CCBaseReverseDataProvider

- (void)loadItems
{
    self.currentPage = firstPage;
    self.isCurrentlyLoad = YES;
    __weak CCPaginationDataProvider *weakSelf = self;
    [self loadItemsForPageNumber:self.currentPage successHandler:^(id responseObject) {
        NSDictionary *response = [self reverseItemsArrayInPaginationDictionary:responseObject];
        weakSelf.totalNumber = [response[CCResponseKeys.count] longValue];
        weakSelf.arrayOfItems = response[CCResponseKeys.items];
        weakSelf.isEverythingLoaded = [self checkIsComplete];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:CCNotificationsNames.tableViewWillReloadData object:nil];
        [weakSelf.targetTable reloadData];
        [[NSNotificationCenter defaultCenter] postNotificationName:CCNotificationsNames.tableViewDidReloadData object:nil];
        
        weakSelf.isCurrentlyLoad = NO;
    }];
    self.currentPage++;
}

- (void)loadMoreItems
{
    if (!self.isCurrentlyLoad && !self.isEverythingLoaded) {
        self.isCurrentlyLoad = YES;
        __weak CCBaseReverseDataProvider *weakSelf = self;
        [self loadItemsForPageNumber:self.currentPage successHandler:^(id responseObject) {
            NSDictionary *response = responseObject;
            weakSelf.arrayOfItems = [response[CCResponseKeys.items] arrayByAddingObjectsFromArray:weakSelf.arrayOfItems];
            weakSelf.isEverythingLoaded = [self checkIsComplete];
            
            [weakSelf.targetTable reloadData];
            NSIndexPath *firstIndexPath = [NSIndexPath indexPathForRow:[response[CCResponseKeys.items] count] inSection:0];
            NSIndexPath *secondIndexPath = [NSIndexPath indexPathForRow:[response[CCResponseKeys.items] count] - 1 inSection:0];
            [weakSelf.targetTable scrollToRowAtIndexPath:firstIndexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
            [weakSelf.targetTable scrollToRowAtIndexPath:secondIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
            
            weakSelf.isCurrentlyLoad = NO;
        }];
        self.currentPage++;
    }
}

- (void)loadItemsForPageNumber:(long)numberOfPage successHandler:(successWithObject)successHandler
{
    
}

- (NSDictionary *)reverseItemsArrayInPaginationDictionary:(NSDictionary *)sourceDictionary
{
    NSMutableDictionary *mutableResponse = [sourceDictionary mutableCopy];
    NSArray *arrayOfItems = mutableResponse[CCResponseKeys.items];
    NSArray *reversedArray = [[arrayOfItems reverseObjectEnumerator] allObjects];
    [mutableResponse setValue:reversedArray forKey:CCResponseKeys.items];
    return mutableResponse;
}

@end
