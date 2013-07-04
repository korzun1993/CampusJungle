//
//  CCPhoto.m
//  CampusJungle
//
//  Created by Vlad Korzun on 21.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCPhoto.h"

@implementation CCPhoto

+ (NSDictionary *)responseMappingDictionary
{
    return @{
      @"thumbnail" : @"thumbnail",
      @"thumbnail_retina" : @"thumbnailRetina",
      @"normalized" : @"normal"
    };
}

@end
