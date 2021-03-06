//
//  CCMoneyForInvitePushProcessingBehaviour.m
//  CampusJungle
//
//  Created by Yury Grinenko on 02.08.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCMoneyForInvitePushProcessingBehaviour.h"
#import "CCAlertHelper.h"

@implementation CCMoneyForInvitePushProcessingBehaviour

- (void)processWhenAppNotRunningWithUserInfo:(NSDictionary *)userInfo
{
    [self showAlertWithUserInfo:userInfo];
}

- (void)processWhenAppInBackgroundWithUserInfo:(NSDictionary *)userInfo
{
    [self showAlertWithUserInfo:userInfo];
}

- (void)processWhenAppActiveWithUserInfo:(NSDictionary *)userInfo
{
    [self showAlertWithUserInfo:userInfo];
}

- (void)showAlertWithUserInfo:(NSDictionary *)userInfo
{
    NSString *message = [[userInfo objectForKey:@"aps"] objectForKey:@"alert"];
    [CCAlertHelper showNotificationWithTitle:CCAlertsTitles.pushNotification message:message];
}

@end
