//
//  CCCommentCell.h
//  CampusJungle
//
//  Created by Yury Grinenko on 17.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCBaseCell.h"

@class CCComment;

@protocol CCCommentCellDelegate <NSObject>

- (void)deleteComment:(CCComment *)comment;

@end

@interface CCCommentCell : CCBaseCell

- (void)setCellObject:(CCComment *)comment;
- (void)setDelegate:(id<CCCommentCellDelegate>)delegate;

@end
