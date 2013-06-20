//
//  CCNoteCell.m
//  CampusJungle
//
//  Created by Vlad Korzun on 6/8/13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCNoteCell.h"
#import "CCNote.h"
#import "CCDefines.h"

@interface CCNoteCell()

@property (nonatomic, weak) IBOutlet UILabel *noteDescription;
@property (nonatomic, weak) IBOutlet UIImageView *thumbImage;
@property (nonatomic, weak) IBOutlet UIImageView *pandingImage;

@end

@implementation CCNoteCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"CCNoteCell"
                                              owner:self
                                            options:nil] objectAtIndex:0];
            
    }
    return self;
}

- (void)setCellObject:(id)cellObject
{
    _cellObject = cellObject;
    CCNote *note = (CCNote *)cellObject;
   
    self.noteDescription.text = note.noteDescription;
    if(note.link.length){
        self.pandingImage.hidden = YES;
    } else {
        self.pandingImage.hidden = NO;
    }
    if(note.thumbnailRetina.length){
        NSString *thumbURL = [NSString stringWithFormat:@"%@%@",CCAPIDefines.baseURL,note.thumbnailRetina];
        [self.thumbImage setImageWithURL:[NSURL URLWithString:thumbURL]];
    } else {
        self.thumbImage.image = [UIImage imageNamed:@"book"];
    }

}

@end