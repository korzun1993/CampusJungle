//
//  CCCommonDataSource.m
//  CampusJungle
//
//  Created by Vlad Korzun on 29.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCCommonDataSource.h"
#import "CCTableCellProtocol.h"
#import "CCDefines.h"
#import "CCBaseCell.h"

@implementation CCCommonDataSource

- (id)init
{
    if(self = [super init]){
        self.registeredCellClasses = [NSMutableDictionary new];
    }
    return self;
}

- (void)dealloc
{
    NSLog(@"DEALLOCED");
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataProvider.arrayOfItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id <CCTableCellProtocol> cell = [tableView dequeueReusableCellWithIdentifier:self.currentCellReuseIdentifier];
    [cell setCellObject:self.dataProvider.arrayOfItems[indexPath.row]];
    if ([cell respondsToSelector:@selector(setDelegate:)]) {
        [cell performSelector:@selector(setDelegate:) withObject:self.delegate];
    }
    if ([cell respondsToSelector:@selector(setReportDelegate:)]) {
        [cell performSelector:@selector(setReportDelegate:) withObject:self.dataProvider.reportDelegate];
    }
    if([cell respondsToSelector:@selector(setIsEven:)]){
        cell.isEven = indexPath.row % 2;
    }
    
    return (UITableViewCell *)cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [[(UIViewController *)self.delegate view] endEditing:YES];
    if(scrollView.contentOffset.y > scrollView.contentSize.height - scrollView.frame.size.height - IntervalBeforeLoading){
        [self.dataProvider loadMoreItems];
    }
}

- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.delegate didSelectedCellWithObject:self.dataProvider.arrayOfItems[indexPath.row]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.delegate respondsToSelector:@selector(isNeedToLeftSelected)] && ![self.delegate isNeedToLeftSelected]){
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Class cellClass = self.registeredCellClasses[self.currentCellReuseIdentifier];
    return [cellClass heightForCellWithObject:self.dataProvider.arrayOfItems[indexPath.row]];
}

@end
