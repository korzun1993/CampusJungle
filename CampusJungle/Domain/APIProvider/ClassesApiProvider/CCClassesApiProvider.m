//
//  CCClassesApiProvider.m
//  CampusJungle
//
//  Created by Yulia Petryshena on 6/4/13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCClassesApiProvider.h"
#import "CCDefines.h"

@implementation CCClassesApiProvider

- (void)createClass:(CCClass *)class successHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler
{
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    [self setAuthorizationToken];
    
    NSDictionary *parametersArray =  @{@"professor":class.professor,@"subject":class.subject,@"timetable":class.timetable,@"semester":@"summer", @"call_number":class.callNumber,};

    [objectManager postObject:nil
                         path:[NSString stringWithFormat:CCAPIDefines.createClass,class.collegeID]
                   parameters:parametersArray
                      success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                          successHandler(mappingResult.firstObject);
                      }
                      failure:^(RKObjectRequestOperation *operation, NSError *error) {
                          errorHandler(error);
                      }];
}

- (void)getClassesOfCollege:(NSString*)collegeID successHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler
{
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    [self setAuthorizationToken];
    NSString *path = [NSString stringWithFormat:CCAPIDefines.classesOfCollege,collegeID];
    NSLog(@"");
    [objectManager getObjectsAtPath:path
                         parameters:nil
                            success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                successHandler([mappingResult array]);
                            } failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                errorHandler(error);
                            }];
}


- (void)getAllClasesSuccessHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler
{
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    [self setAuthorizationToken];
    
    [objectManager getObjectsAtPath:CCAPIDefines.allClasses
                         parameters:nil
                            success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                successHandler([mappingResult array]);
                            } failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                errorHandler(error);
                            }];
}

- (void)joinClass:(NSString*)classID SuccessHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler
{
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    [self setAuthorizationToken];
    NSString *path = [NSString stringWithFormat:CCAPIDefines.addClass,classID];
    [objectManager putObject:nil
                        path:path
                  parameters:nil
                     success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                          successHandler([mappingResult array]);
                     } failure:^(RKObjectRequestOperation *operation, NSError *error) {
                             errorHandler(error);
                     }];
}



@end
