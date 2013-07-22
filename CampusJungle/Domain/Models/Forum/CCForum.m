//
//  CCForum.m
//  CampusJungle
//
//  Created by Yury Grinenko on 15.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCForum.h"
#import "CCRestKitConfigurator.h"

@implementation CCForum

+ (void)configureMappingWithManager:(RKObjectManager *)objectManager
{
    [self configureForumsRequest:objectManager];
    [self configureForumsResponse:objectManager];
}

+ (void)configureForumsResponse:(RKObjectManager *)objectManager
{
    RKObjectMapping *paginationForumsResponseMapping = [CCRestKitConfigurator paginationMapping];
    RKObjectMapping *forumsResponseMapping = [RKObjectMapping mappingForClass:[CCForum class]];
    [forumsResponseMapping addAttributeMappingsFromDictionary:[CCForum responseMappingDictionary]];
    RKRelationshipMapping *relationshipResponseForumsMapping = [RKRelationshipMapping relationshipMappingFromKeyPath:CCResponseKeys.items
                                                                                                           toKeyPath:CCResponseKeys.items
                                                                                                         withMapping:forumsResponseMapping];
    
    
    [paginationForumsResponseMapping addPropertyMapping:relationshipResponseForumsMapping];
    
    NSString *classPathPattern = [NSString stringWithFormat:CCAPIDefines.loadClassForums, @":classID"];
    RKResponseDescriptor *classForumsResponseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:paginationForumsResponseMapping
                                                                                                  pathPattern:classPathPattern
                                                                                                      keyPath:nil
                                                                                                  statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    NSString *groupPathPattern = [NSString stringWithFormat:CCAPIDefines.loadGroupForums, @":groupID"];
    RKResponseDescriptor *groupForumsResponseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:paginationForumsResponseMapping
                                                                                                  pathPattern:groupPathPattern
                                                                                                      keyPath:nil
                                                                                                  statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    [objectManager addResponseDescriptor:classForumsResponseDescriptor];
    [objectManager addResponseDescriptor:groupForumsResponseDescriptor];
}

+ (void)configureForumsRequest:(RKObjectManager *)objectManager
{
    RKObjectMapping *forumMapping = [RKObjectMapping mappingForClass:[NSMutableDictionary class]];
    [forumMapping addAttributeMappingsFromDictionary:[CCForum requestMappingDictionary]];
    RKRequestDescriptor *forumRequestDescriptor = [RKRequestDescriptor requestDescriptorWithMapping:forumMapping objectClass:[CCForum class] rootKeyPath:nil];
    [objectManager addRequestDescriptor:forumRequestDescriptor];
}

+ (NSDictionary *)responseMappingDictionary
{
    return @{
             @"id" : @"forumId",
             @"description" : @"description",
             @"name" : @"name",
             @"owner_id" : @"ownerId",
             @"class_id" : @"classId",
             @"questions_count" : @"questionsCount",
             };
}

+ (NSDictionary *)requestMappingDictionary
{
    return @{
             @"description" : @"description",
             @"name" : @"name",
             };
}

@end
