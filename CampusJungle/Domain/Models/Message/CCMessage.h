//
//  CCMessage.h
//  CampusJungle
//
//  Created by Vlad Korzun on 10.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCRestKitMappableModel.h"
#import "CCModelIdAccessorProtocol.h"

@interface CCMessage : NSObject <CCRestKitMappableModel, CCModelTypeProtocol>

@property (nonatomic, strong) NSString *messageID;
@property (nonatomic, strong) NSString *receiverID;
@property (nonatomic, strong) NSString *receiverType;
@property (nonatomic, strong) NSString *senderID;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSString *created;
@property (nonatomic, strong) NSDate *createdAt;
@property (nonatomic, strong) NSString *userFirstName;
@property (nonatomic, strong) NSString *userLastName;
@property (nonatomic, strong) NSString *userAvatar;
@property (nonatomic, strong) NSString *dialogID;

+ (NSDictionary *)responseMappingDictionary;

@end


