//
//  CCQuestionsApiProviderProtocol.h
//  CampusJungle
//
//  Created by Yury Grinenko on 15.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCQuestion.h"
#import "CCTypesDefinition.h"

@protocol CCQuestionsApiProviderProtocol <AppleGuiceInjectable>

- (void)loadQuestionsForClassWithId:(NSString *)classId filterString:(NSString *)filterString pageNumber:(NSInteger)pageNumber successHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler;
- (void)loadQuestionsForGroupWithId:(NSString *)groupId filterString:(NSString *)filterString pageNumber:(NSInteger)pageNumber successHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler;
- (void)postQuestion:(CCQuestion *)question successHandler:(successHandlerWithRKResult)successHandler errorHandler:(errorHandler)errorHandler;
- (void)deleteQuestion:(CCQuestion *)question successHandler:(successHandlerWithRKResult)successHandler errorHandler:(errorHandler)errorHandler;
- (void)postUploadInfoWithImages:(CCQuestion *)uploadInfo withImages:(NSArray *)images successHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler progress:(progressBlock)progressBlock;
- (void)emailAttachmentOfQuestion:(CCQuestion *)question successHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler;
- (void)loadQuestionWithId:(NSString *)questionId successHandler:(successHandlerWithRKResult)successHandler errorHandler:(errorHandler)errorHandler;

@end
