//
//  CCStoreObserver.h
//  CampusJungle
//
//  Created by Vlad Korzun on 31.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>
#import "CCStoreObserverDelegateProtocol.h"
#import "CCStoreObserverProtocol.h"

@interface CCStoreObserver : NSObject<CCStoreObserverProtocol>

@property (nonatomic, weak) id <CCStoreObserverDelegateProtocol> delegate;

@end
