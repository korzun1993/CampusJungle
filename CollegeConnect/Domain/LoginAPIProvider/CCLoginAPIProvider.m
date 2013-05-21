//
//  CCLoginAPIProvider.m
//  CollegeConnect
//
//  Created by Vlad Korzun on 21.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCLoginAPIProvider.h"
#import "CCFaceBookAPIProtocol.h"
#import "CCUserSessionProtocol.h"

@interface CCLoginAPIProvider ()

@property (nonatomic, strong) id <CCFaceBookAPIProtocol> ioc_facebookAPI;
@property (nonatomic, strong) id <CCUserSessionProtocol> ioc_userSession;

@end

@implementation CCLoginAPIProvider

-(void)performLoginOperationViaFacebookWithSuccessHandler:(successHandler)successHandler errorHandler:(errorHandler)errorHandler
{
    [self loginFacebookSuccessHandler:successHandler errorHandler:errorHandler];
}

-(void)loginFacebookSuccessHandler:(successHandler)successHandler errorHandler:(errorHandler)errorHandler
{
    [self.ioc_facebookAPI loginWithSuccessHandler:^{
        [self getUserInfoSuccessHandler:successHandler errorHandler:errorHandler];
    } errorHandler:^(NSError *error) {
        errorHandler(error);
    }];
}

-(void)getUserInfoSuccessHandler:(successHandler)successHandler errorHandler:(errorHandler)errorHandler
{
    [self.ioc_facebookAPI getUserInfoSuccessHandler:^(NSDictionary *userDictionary) {
        
        self.ioc_userSession.currentUser = [CCUser userFromFacebookDictionary:userDictionary];
       // [self authorizeUserOnServerSuccessHandler:successHandler errorHandler:errorHandler];
    } errorHandler:^(NSError *error){
        errorHandler(error);
    }];
}


@end
