//
//  CCState.m
//  CampusJungle
//
//  Created by Vlad Korzun on 29.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCState.h"

@implementation CCState

+ (NSDictionary *)responseMappingDictionary
{
    return @{
      @"id" : @"stateID",
      @"name" : @"name"
    };
}

@end