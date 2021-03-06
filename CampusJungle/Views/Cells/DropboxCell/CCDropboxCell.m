//
//  CCDropboxCell.m
//  CampusJungle
//
//  Created by Vlad Korzun on 5/30/13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCDropboxCell.h"
#import <DropboxSDK/DropboxSDK.h>
#import "CCDropboxFileInfo.h"
#import "CCDropboxAPIProviderProtocol.h"

@interface CCDropboxCell()<DBRestClientDelegate>

@property (nonatomic, weak) IBOutlet UILabel *fileName;
@property (nonatomic, weak) IBOutlet UIImageView *fileIcon;
@property (nonatomic, weak) IBOutlet UIImageView *checkMark;
@property (nonatomic, strong) id <CCDropboxAPIProviderProtocol> ioc_dropboxAPIProvider;

@end

@implementation CCDropboxCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"CCDropboxCell"
                                              owner:self
                                            options:nil] objectAtIndex:0];

    }
    return self;
}

- (void)setCellObject:(id)cellObject
{
    _cellObject = cellObject;
    CCDropboxFileInfo *fileInfo = (CCDropboxFileInfo *)cellObject;
    self.fileName.text = fileInfo.fileData.filename;
    self.fileIcon.image = fileInfo.thumb;
    
    [self becomeSelected:fileInfo.isSelected];
    if(!fileInfo.fileData.isDirectory && !fileInfo.directLink){
       [self.ioc_dropboxAPIProvider loadDirectURLforPath:fileInfo.fileData.path successHandler:^(id result) {
           fileInfo.directLink = result;
       } errorHanler:^(NSError *error) {
           
       }];
        
    }
    
    if(fileInfo.fileData.thumbnailExists && !fileInfo.thumb){
        [self.ioc_dropboxAPIProvider loadThumbnailForPath:fileInfo.fileData.path successHandler:^(NSDictionary *result) {
            if ([[[(CCDropboxFileInfo *)self.cellObject fileData] path] isEqual:result[@"path"]]){
                self.fileIcon.image = result[@"image"];
            }
            fileInfo.thumb = result[@"image"];
        } errorHanler:^(NSError *error) {
            
        }];
    }
    
    if(!fileInfo.fileData.thumbnailExists){
        fileInfo.thumb = [UIImage imageNamed:fileInfo.fileData.icon];
        self.fileIcon.image = fileInfo.thumb;
    }
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{

    if(highlighted){
        CCDropboxFileInfo *fileInfo = (CCDropboxFileInfo *)self.cellObject;
        if(!fileInfo.fileData.isDirectory){
            fileInfo.isSelected = !fileInfo.isSelected;
        }
        [self becomeSelected:fileInfo.isSelected];
    }
    [super setHighlighted:highlighted animated:animated];
}

- (void)becomeSelected:(BOOL)selected
{
    if(selected){
        self.checkMark.hidden = NO;
    } else {
        self.checkMark.hidden = YES;
    }
}



@end
