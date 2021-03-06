//
//  CCAnswer.h
//  CampusJungle
//
//  Created by Yury Grinenko on 16.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCRestKitMappableModel.h"
#import "CCModelIdAccessorProtocol.h"
#import "CCUploadIndicatorDelegateProtocol.h"

@interface CCAnswer : NSObject <CCRestKitMappableModel, CCModelTypeProtocol>

@property (nonatomic, strong) NSString *answerId;
@property (nonatomic, strong) NSString *questionId;
@property (nonatomic, strong) NSString *ownerId;
@property (nonatomic, strong) NSString *ownerFirstName;
@property (nonatomic, strong) NSString *ownerLastName;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSDate *createdDate;
@property (nonatomic, assign) NSInteger commentsCount;
@property (nonatomic, assign) NSInteger likesCount;
@property (nonatomic, assign) BOOL isLiked;

@property (nonatomic, strong) NSString *attachment;

@property (nonatomic, strong) NSNumber *uploadProgress;
@property (nonatomic, strong) NSArray *arrayOfImageUrls;
@property (nonatomic, strong) NSArray *arrayOfImages;
@property (nonatomic, strong) NSString *pdfUrl;
@property (nonatomic, weak) id<CCUploadIndicatorDelegateProtocol> delegate;

+ (CCAnswer *)answerWithText:(NSString *)text;

@end
