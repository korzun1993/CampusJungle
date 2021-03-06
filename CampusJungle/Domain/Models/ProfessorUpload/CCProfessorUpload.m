//
//  CCProfessorUpload.m
//  CampusJungle
//
//  Created by Vlad Korzun on 18.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCProfessorUpload.h"
#import "CCRestKitConfigurator.h"

@implementation CCProfessorUpload

- (NSString *)modelType
{
    return CCModelsTypes.professorsUpload;
}

- (NSString *)modelID
{
    return self.uploadId;
}

+ (void)configureMappingWithManager:(RKObjectManager *)objectManager
{
    [self configureProfessorsUploadResponse:objectManager];
    [self configureProfessorsUploadRequest:objectManager];
}

+ (void)configureProfessorsUploadResponse:(RKObjectManager *)objectManager
{
    RKObjectMapping *paginationProfessorUploadResponseMapping = [CCRestKitConfigurator paginationMapping];
    
    RKObjectMapping *professorUploadMapping = [RKObjectMapping mappingForClass:[CCProfessorUpload class]];
    [professorUploadMapping  addAttributeMappingsFromDictionary:[CCProfessorUpload responseMappingDictionary]];
    
    RKRelationshipMapping *relationShipResponseQuestionsMapping = [RKRelationshipMapping relationshipMappingFromKeyPath:CCResponseKeys.items
                                                                                                              toKeyPath:CCResponseKeys.items
                                                                                                            withMapping:professorUploadMapping];
    
    [paginationProfessorUploadResponseMapping addPropertyMapping:relationShipResponseQuestionsMapping];
    
    NSString *pathPattern = [NSString stringWithFormat:CCAPIDefines.loadUploads, @":classID"];
    RKResponseDescriptor *responseQuestionsDescriptor =
    [RKResponseDescriptor responseDescriptorWithMapping:paginationProfessorUploadResponseMapping
                                            pathPattern:pathPattern
                                                keyPath:nil
                                            statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    NSString *uplaodingResponse = [NSString stringWithFormat:CCAPIDefines.postUploads,@":classID"];
    RKResponseDescriptor *responseOnCreation = [RKResponseDescriptor responseDescriptorWithMapping:professorUploadMapping pathPattern:uplaodingResponse keyPath:@"upload" statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    NSString *loadUploadPathPattern = [NSString stringWithFormat:CCAPIDefines.loadProfessorsUpload, @":uploadId"];
    RKResponseDescriptor *loadUploadsDescriptor =
    [RKResponseDescriptor responseDescriptorWithMapping:professorUploadMapping
                                            pathPattern:loadUploadPathPattern
                                                keyPath:@"upload"
                                            statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];

    
    [objectManager addResponseDescriptor:responseOnCreation];
    [objectManager addResponseDescriptor:responseQuestionsDescriptor];
    [objectManager addResponseDescriptor:loadUploadsDescriptor];
}

+ (void)configureProfessorsUploadRequest:(RKObjectManager *)objectManager
{
    RKObjectMapping *questionMapping = [RKObjectMapping mappingForClass:[NSMutableDictionary class]];
    [questionMapping addAttributeMappingsFromDictionary:[CCProfessorUpload requestMappingDictionary]];
    RKRequestDescriptor *questionRequestDescriptor = [RKRequestDescriptor requestDescriptorWithMapping:questionMapping objectClass:[CCProfessorUpload class] rootKeyPath:nil];
    [objectManager addRequestDescriptor:questionRequestDescriptor];
}

+ (NSDictionary *)responseMappingDictionary
{
    return @{
             @"id" : @"uploadId",
             @"text" : @"text",
             @"description" : @"name",
             @"klass_id" : @"classID",
             @"sender_id" : @"ownerID",
             @"attachment" : @"attachment",
             @"answers_count" : @"answersCount",
             @"created_at" : @"createdDate",
             @"owner_first_name" : @"ownerFirstName",
             @"owner_last_name" : @"ownerLastName",
             @"owner_avatar" : @"ownerAvatar",
             
             };
}

+ (NSDictionary *)requestMappingDictionary
{
    return @{
             @"text" : @"text",
             @"name" : @"description",
             @"classID" : @"klass_id",
             @"arrayOfImageUrls" : @"images_urls",
             @"pdfUrl" : @"pdf_url",
             };
}

- (void)setUploadProgress:(NSNumber *)uploadProgress
{
    _uploadProgress = uploadProgress;
    [self.delegate uploadProgressDidUpdate];
}

@end
