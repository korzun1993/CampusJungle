//
//  CCState.h
//  CampusJungle
//
//  Created by Vlad Korzun on 29.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCRestKitMappableModel.h"

@interface CCState : NSObject <CCRestKitMappableModel>

@property (nonatomic, strong) NSNumber *stateID;
@property (nonatomic, strong) NSString *name;

@end
