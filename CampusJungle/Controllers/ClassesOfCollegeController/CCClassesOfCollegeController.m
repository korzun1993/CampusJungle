//
//  CCClassesOfCollegeController.m
//  CampusJungle
//
//  Created by Yulia Petryshena on 6/5/13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCClassesOfCollegeController.h"
#import "CCClassesApiProviderProtocol.h"
#import "CCClassesDataProvider.h"
#import "CCOrdinaryCell.h"
#import "CCStandardErrorHandler.h"
#import "CCNavigationBarViewHelper.h"
#import "CCClass.h"

@interface CCClassesOfCollegeController ()

@property (nonatomic, strong) NSString *collegeID;
@property (nonatomic, strong) CCClassesDataProvider *dataProvider;
@property (nonatomic, strong) id<CCClassesApiProviderProtocol> ioc_apiClassesProvider;

@end

@implementation CCClassesOfCollegeController

- (id)initWithCollegeID:(NSString *)collegeID
{
    self = [super init];
    if (self) {
        self.collegeID = collegeID;
        [self setTitle:@"Join Class"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addButton];
    [self.ioc_apiClassesProvider getClassesOfCollege:self.collegeID successHandler:^(id response) {
        self.dataProvider = [CCClassesDataProvider new];
        self.dataProvider.arrayOfClasses = response;
        [self configTableWithProvider:self.dataProvider cellClass:[CCOrdinaryCell class]];
    } errorHandler:^(NSError *error) {
        [CCStandardErrorHandler showErrorWithError:error];
    }];
}

- (void)addButton
{
    self.navigationItem.rightBarButtonItem = [CCNavigationBarViewHelper plusButtonWithTarget:self action:@selector(addNewClass)];
}

- (void)addNewClass
{
    [self.addNewClassTransaction performWithObject:self.collegeID];
    
}

- (void)didSelectedCellWithObject:(id)cellObject
{
    __weak CCClassesOfCollegeController *weakSelf = self;
    [self.ioc_apiClassesProvider joinClass:[(CCClass *)cellObject classID] SuccessHandler:^(id response) {
        [[NSNotificationCenter defaultCenter] postNotificationName:CCNotificationsNames.reloadSideMenu object:nil];
        [weakSelf.classAddedTransaction performWithObject:cellObject];
    } errorHandler:^(NSError *error) {
        [CCStandardErrorHandler showErrorWithError:error];
    }];
}

@end