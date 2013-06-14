//
//  CCFiltersDataProvider.m
//  CampusJungle
//
//  Created by Vlad Korzun on 13.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCFiltersDataProvider.h"
#import "CCClassesApiProviderProtocol.h"
#import "CCStandardErrorHandler.h"
#import "CCClass.h"
#import "CCFilterSection.h"

@interface CCFiltersDataProvider()

@property (nonatomic, strong) id <CCClassesApiProviderProtocol> ioc_classesProviderProtocol;

@end

@implementation CCFiltersDataProvider

- (void)loadItems
{
    [self.ioc_classesProviderProtocol getAllClasesSuccessHandler:^(id result) {
        self.arrayOfItems = [self sectionFromResponse:result];
        [self.targetTable reloadData];
    } errorHandler:^(NSError *error) {
        [CCStandardErrorHandler showErrorWithError:error];
    }];
}

- (NSArray *)sectionFromResponse:(NSArray *)response
{
    NSMutableArray *arrayOfSection = [NSMutableArray new];
    
    for (CCClass *class in response){
        CCFilterSection *section = [self findSection:class.collegeID.integerValue inArray:arrayOfSection];
        if(!section){
           section = [CCFilterSection new];
            section.collegeName  = class.collegeName;
            section.collegeID = class.collegeID.integerValue;
            section.isOpen = YES;
            section.index = arrayOfSection.count;
            [section.classes addObject:[self fakeClassForCollegeID:section.collegeID]];
            [arrayOfSection addObject:section];
        
        }
        [section.classes addObject:class];
    }
    return arrayOfSection;
}

- (CCClass *)fakeClassForCollegeID:(NSInteger)collegeID
{
    CCClass *fakeClass = [CCClass new];
    fakeClass.subject = @"All over college";
    fakeClass.classID = 0;
    fakeClass.collegeID = [NSString stringWithFormat:@"%d",collegeID];
    fakeClass.isSelected = YES;
    return fakeClass;
}

- (CCFilterSection *)findSection:(NSInteger)collegeID inArray:(NSArray *)sections
{
    for(CCFilterSection *section in sections){
        if(section.collegeID == collegeID){
            return section;
        }
    }
    return nil;
}

@end
