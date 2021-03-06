//
//  CCReportsApiProvider.m
//  CampusJungle
//
//  Created by Yury Grinenko on 31.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCReportsApiProvider.h"
#import "CCReport.h"

@implementation CCReportsApiProvider

- (void)checkIfAvailableReport:(CCReport *)report successHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler;
{
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    [self setAuthorizationToken];
    NSString *path = CCAPIDefines.checkAvailablityOfReport;
    NSDictionary *params = @{@"item_id" : report.itemId, @"item_type" : report.itemType};
    [objectManager getObject:nil path:path parameters:params success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        successHandler(mappingResult);
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        errorHandler(error);
    }];
}

- (void)postReport:(CCReport *)report successHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler
{
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    [self setAuthorizationToken];
    NSString *path = CCAPIDefines.postReport;
    [objectManager postObject:report path:path parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        successHandler(mappingResult);
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        errorHandler(error);
    }];
}

@end
