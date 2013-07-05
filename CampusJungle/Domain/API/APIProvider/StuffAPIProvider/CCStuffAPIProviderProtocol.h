//
//  CCAPIProviderProtocol.h
//  CampusJungle
//
//  Created by Vlad Korzun on 20.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCTypesDefinition.h"
#import "CCStuffUploadInfo.h"

@protocol CCStuffAPIProviderProtocol <NSObject>

- (void)loadMyStuffNumberOfPage:(NSNumber *)pageNumber query:(NSString *)query successHandler:(successHandlerWithRKResult)successHandler errorHandler:(errorHandler)errorHandler;

- (void)postDropboxUploadInfo:(CCStuffUploadInfo *)stuffInfo successHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler;

- (void)postUploadInfoWithImages:(CCStuffUploadInfo *)uploadInfo successHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler progress:(progressBlock)progressBlock;

@end