//
//  CCPhotoCell.m
//  CampusJungle
//
//  Created by Vlad Korzun on 21.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCPhotoCell.h"
#import "CCPhoto.h"
#import "CCDefines.h"

@interface CCPhotoCell()

@property (nonatomic, strong) IBOutlet UIImageView *thumb;

@end

@implementation CCPhotoCell

- (id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]){
        self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class])
                                              owner:self
                                            options:nil] objectAtIndex:0];
    }
    return self;
}

- (void)setCellObject:(id)cellObject
{
    _cellObject = cellObject;
    CCPhoto *currentPhoto = cellObject;
   
    NSString *thumbPath;
    if (self.frame.size.height < 200){
        thumbPath = [CCAPIDefines.baseURL stringByAppendingString: currentPhoto.thumbnailRetina];
    } else {
        thumbPath = [CCAPIDefines.baseURL stringByAppendingString: currentPhoto.normal];
    }
    
    [self.thumb setImageWithURL:[NSURL URLWithString:thumbPath]];
}

@end
