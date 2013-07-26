//
//  CCPushToClassControllerTransaction.m
//  CampusJungle
//
//  Created by Vlad Korzun on 25.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCPushToClassControllerTransaction.h"
#import "CCClassController.h"
#import "CCShowNotesForClassTransaction.h"
#import "CCOtherUserProfileTransaction.h"
#import "CCShowLocationsTransaction.h"
#import "CCAddLocationTransaction.h"
#import "CCAddForumTransaction.h"
#import "CCForumDetailsTransaction.h"
#import "CCEditClassTransaction.h"
#import "CCProfessorUploadsTransaction.h"
#import "CCTimetableTransaction.h"
#import "CCGroupTransaction.h"
#import "CCAddGroupTransaction.h"
#import "CCAnnouncementTransaction.h"
#import "CCAppInviteTransaction.h"

@implementation CCPushToClassControllerTransaction

- (void)performWithObject:(id)object
{
    NSParameterAssert(self.navigation);
    NSParameterAssert(self.inboxTransaction);
    
    CCClassController *classController = [[CCClassController alloc] initWithClass:object];
    [self.navigation pushViewController:classController animated:YES];
    
    CCEditClassTransaction *editTransaction = [CCEditClassTransaction new];
    editTransaction.navigation = self.navigation;
    editTransaction.classDataController = classController;
    classController.editClassTransaction = editTransaction;
    
    CCAnnouncementTransaction *announcement = [CCAnnouncementTransaction new];
    announcement.navigation = self.navigation;
    classController.announcementTransaction = announcement;
    
    CCShowNotesForClassTransaction *classNotesTransaction = [CCShowNotesForClassTransaction new];
    classController.classMarketTransaction =classNotesTransaction;
    classNotesTransaction.navigation = self.navigation;
    
    CCProfessorUploadsTransaction *professorUploadsTransaction = [CCProfessorUploadsTransaction new];
    professorUploadsTransaction.navigation = self.navigation;
    classController.professorUploadsTransaction = professorUploadsTransaction;
    
    CCShowLocationsTransaction *locationsTransactions = [CCShowLocationsTransaction new];
    locationsTransactions.navigation = self.navigation;
    classController.locationTransaction = locationsTransactions;
    
    CCAddLocationTransaction *addLocationTransaction = [CCAddLocationTransaction new];
    addLocationTransaction.navigation = self.navigation;
    
    CCOtherUserProfileTransaction *otherUserProfileTransaction = [CCOtherUserProfileTransaction new];
    otherUserProfileTransaction.navigation = self.navigation;
    
    CCAddForumTransaction *addForumTransaction = [CCAddForumTransaction new];
    addForumTransaction.navigation = self.navigation;
    
    CCForumDetailsTransaction *forumDetailsTransaction = [CCForumDetailsTransaction new];
    forumDetailsTransaction.navigation = self.navigation;
    
    CCTimetableTransaction *timetableTransaction = [CCTimetableTransaction new];
    timetableTransaction.navigation = self.navigation;
    
    CCGroupTransaction *groupDetailsTransaction = [CCGroupTransaction new];
    groupDetailsTransaction.navigation = self.navigation;
    
    CCAddGroupTransaction *addGroupTransaction = [CCAddGroupTransaction new];
    addGroupTransaction.navigation = self.navigation;
    
    CCAppInviteTransaction *appInviteTransaction = [CCAppInviteTransaction new];
    appInviteTransaction.navigation = self.navigation;
    
    classController.otherUserProfileTransaction = otherUserProfileTransaction;
    classController.newsFeedTransaction = self.inboxTransaction;
    classController.locationTransaction = locationsTransactions;
    classController.addLocationTransaction = addLocationTransaction;
    classController.addForumTransaction = addForumTransaction;
    classController.forumDetailsTransaction = forumDetailsTransaction;
    classController.timetableTransaction = timetableTransaction;
    classController.groupDetailsTransaction = groupDetailsTransaction;
    classController.addGroupTransaction = addGroupTransaction;
    classController.sendInviteTransaction = appInviteTransaction;
    
    UIViewController *viewController = [[self.navigation viewControllers] lastObject];
    [self.navigation setViewControllers:@[viewController]];
}

@end