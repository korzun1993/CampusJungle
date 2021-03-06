//
//  CCReportsApiProviderProtocol.h
//  CampusJungle
//
//  Created by Yury Grinenko on 31.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCTypesDefinition.h"

@class CCReport;

@protocol CCReportsApiProviderProtocol <AppleGuiceInjectable>

- (void)checkIfAvailableReport:(CCReport *)report successHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler;
- (void)postReport:(CCReport *)report successHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler;

@end
