//
//  CCReportDelegateProtocol.h
//  CampusJungle
//
//  Created by Vlad Korzun on 01.08.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCModelIdAccessorProtocol.h"

@protocol CCReportDelegateProtocol <NSObject>

- (void)postReportOnContent:(id<CCModelTypeProtocol>)content;

@end
