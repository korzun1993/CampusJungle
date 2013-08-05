//
//  CCUpdateClassController.m
//  CampusJungle
//
//  Created by Vlad Korzun on 17.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCUpdateClassController.h"
#import "CCStandardErrorHandler.h"
#import "CCClassesApiProviderProtocol.h"

@interface CCUpdateClassController ()

@property (nonatomic, strong) id<CCClassesApiProviderProtocol> ioc_apiClassesProvider;

@end

@implementation CCUpdateClassController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:@"CCCreateClassController" bundle:nibBundleOrNil];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableDataProvider.arrayOfLessons addObjectsFromArray:[self formatAllTimesToRequairedFormatFromArray:self.currentClass.timetable]];
    [self.tableDataProvider loadItems];
    self.classNameTextField.text = self.currentClass.name;
    self.professorTextField.text = self.currentClass.professor;
    self.subjectTextField.text = self.currentClass.subject;
    self.semesterTextField.text = self.currentClass.semester;
    self.classIdTextField.text = self.currentClass.callNumber;
    [self.thumbView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",CCAPIDefines.baseURL,self.currentClass.classImageURL]] placeholderImage:[UIImage imageNamed:@"avatar_placeholder"]];
    self.title = @"Edit Class";
}

- (NSArray *)formatAllTimesToRequairedFormatFromArray:(NSArray *)array
{
    NSMutableArray *arrayOfTime = [NSMutableArray new];
    for(NSDictionary *time in array){
        NSMutableDictionary *mutableTime = [time mutableCopy];
        [mutableTime setObject:[NSString stringWithFormat:@"%@ %@",time[@"day"],time[@"time"]] forKey:@"timetable"];
        [arrayOfTime addObject:mutableTime];
    }
    return arrayOfTime;
}

- (IBAction)createClass:(id)sender
{
    if (![self isFormValid]) {
        [CCStandardErrorHandler showErrorWithTitle:CCAlertsMessages.error message:CCAlertsMessages.emptyField];
        return;
    }
    CCClass *class = [self prepareClass];
    class.classID = self.currentClass.classID;
    __weak CCUpdateClassController *weakSelf = self;
    [self.ioc_apiClassesProvider updateClass:class successHandler:^(CCClass *newClass) {
        [[NSNotificationCenter defaultCenter] postNotificationName:CCNotificationsNames.reloadSideMenu object:nil];
        [weakSelf.backTransaction performWithObject:newClass];
    } errorHandler:^(NSError *error) {
         [CCStandardErrorHandler showErrorWithError:error];
    }];
}

@end
