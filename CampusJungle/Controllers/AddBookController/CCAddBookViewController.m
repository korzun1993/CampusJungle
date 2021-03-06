//
//  CCAddBookViewController.m
//  CampusJungle
//
//  Created by Vlad Korzun on 06.08.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCAddBookViewController.h"
#import "CCCollege.h"
#import "CCUserSessionProtocol.h"
#import "CCUploadProcessManagerProtocol.h"
#import "CCAvatarSelectionActionSheet.h"
#import "CCEducation.h"
#import "CCBookUploadInfo.h"
#import "CCBooksAPIProviderProtocol.h"
#import "CCActionSheetPickerCollegesDelegate.h"
#import "ActionSheetCustomPicker.h"
#import "NSString+CJStringValidator.h"
#import "NSString+CountString.h"

@interface CCAddBookViewController ()<CCCellSelectionProtocol, CCAvatarSelectionProtocol>

@property (nonatomic, strong) IBOutlet UIImageView *thumbImage;
@property (nonatomic, strong) IBOutlet SSTextView *decriptionField;
@property (nonatomic, strong) IBOutlet UITextField *priceField;
@property (nonatomic, strong) IBOutlet UIButton *collegeSelectionButton;
@property (nonatomic, strong) IBOutlet UITextField *nameField;
@property (nonatomic, strong) IBOutlet UITextField *isbnField;
@property (nonatomic, strong) id <CCBooksAPIProviderProtocol> ioc_BookAPIProvider;
@property (nonatomic, strong) NSArray *arrayOfColleges;
@property (nonatomic, weak) IBOutlet UIImageView *textViewBackgroundImageView;

@property (nonatomic, strong) CCAvatarSelectionActionSheet *thumbSelection;
@property (nonatomic, strong) NSArray *arrayOfURLs;
@property (nonatomic, strong) NSArray *arrayOfImages;

@property (nonatomic, weak) IBOutlet UIButton *imageDropboxButton;
@property (nonatomic, weak) IBOutlet UIButton *imageButton;

@property (nonatomic, strong) CCCollege *selectedCollege;
@property (nonatomic, strong) id <CCUserSessionProtocol> ioc_userSession;
@property (nonatomic, strong) id <CCUploadProcessManagerProtocol> ioc_uploadingManager;


@end

@implementation CCAddBookViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.thumbSelection = [CCAvatarSelectionActionSheet new];
    self.thumbSelection.delegate = self;
    self.tapRecognizer.enabled = YES;
    self.decriptionField.placeholder = @"Description";
    [self loadColleges];
    self.title = @"New Book";
    [self setupImageViews];
}

- (void)setupImageViews
{
    [self.textViewBackgroundImageView setImage:[[UIImage imageNamed:@"text_box"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)]];
}

- (void)setSelectedCollege:(CCCollege *)selectedCollege
{
    _selectedCollege = selectedCollege;
    [self.collegeSelectionButton setTitle:selectedCollege.name forState:UIControlStateNormal];
}

- (void)showDoneButton
{
    [self setRightNavigationItemWithTitle:@"Done" selector:@selector(upload)];
}

- (void)loadColleges
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self.ioc_userSession loadUserEducationsSuccessHandler:^(id educations) {
        self.arrayOfColleges = [CCEducation arrayOfCollegesFromEducations:educations];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if(self.arrayOfColleges.count){
            self.selectedCollege = self.arrayOfColleges[0];
        }
    }];
}

- (void)upload
{
    if([self isFieldsValid]){
        CCBookUploadInfo *uploadInfo = [self createUploadInfo];
        if(self.arrayOfImages){
            [self uploadWithImages];
        } else if(self.arrayOfURLs){
            uploadInfo.arrayOfURLs = self.arrayOfURLs;
            [self uploadWithImages];
        }
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.view endEditing:YES];
}

- (void)uploadWithImages
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Preparing for upload";
    __weak id weakSelf = self;
    CCBookUploadInfo *uploadInfo = [weakSelf createUploadInfo];
    uploadInfo.arrayOfImages = self.arrayOfImages;
    uploadInfo.arrayOfURLs = self.arrayOfURLs;
    id <CCUploadProcessManagerProtocol> uploadManager = self.ioc_uploadingManager;
    [[uploadManager uploadingBooks] addObject:uploadInfo];
    [self.ioc_BookAPIProvider postUploadInfoWithImages:uploadInfo successHandler:^(id result) {
        [[uploadManager uploadingBooks] removeObject:uploadInfo];
        [uploadManager reloadDelegate];
    } errorHandler:^(NSError *error) {
        [[uploadManager uploadingBooks] removeObject:uploadInfo];
        [uploadManager reloadDelegate];
    } progress:^(double finished) {
        [[weakSelf backToListTransaction] perform];
        [weakSelf setBackToListTransaction:nil];
        uploadInfo.uploadProgress = [NSNumber numberWithDouble:finished];
    }];
}

- (void)uploadWithUrls:(CCBookUploadInfo *)uploadInfo
{
    [self.ioc_BookAPIProvider postDropboxUploadInfo:uploadInfo
                                      successHandler:^(id result) {
                                          [self.backToListTransaction perform];
                                      } errorHandler:^(NSError *error) {
                                          [CCStandardErrorHandler showErrorWithError:error];
                                      }];
}


- (IBAction)thumbDidPressed
{
    [self.thumbSelection showWithTitle:@"Select Book Thumbnail" takePhotoButtonTitle:nil takeFromGalleryButtonTitle:nil];
}

- (void)didSelectAvatar:(UIImage *)avatar
{
    self.thumbImage.image = avatar;
}

- (IBAction)collegeSelectionButtonDidPressed
{
    CCActionSheetPickerCollegesDelegate *delegate = [CCActionSheetPickerCollegesDelegate new];
    delegate.arrayOfItems = self.arrayOfColleges;
    delegate.delegate = self;
    [ActionSheetCustomPicker showPickerWithTitle:@"Colleges" delegate:delegate showCancelButton:YES origin:self.view];
}

- (void)didSelectedCellWithObject:(id)cellObject
{
    self.selectedCollege = cellObject;
}

- (IBAction)didPressedDropboxImagesSelectionButton
{
    if([self isFieldsValid]){
        [self.selectFilesFromDropboxTransaction performWithObject:^(NSArray *arrayOfUrls){
            [self.backToSlefTransaction perform];
            [self showDoneButton];
            self.arrayOfURLs = arrayOfUrls;
            [self unableUploadButtons];
        }];
    }
}

- (void)unableUploadButtons
{
    self.imageButton.enabled = NO;
    self.imageDropboxButton.enabled = NO;
}

- (BOOL)isFieldsValid
{
    if(self.nameField.text.isEmpty){
        [CCStandardErrorHandler showErrorWithTitle:CCAlertsTitles.defaultError message:CCValidationMessages.emptyName];
        return NO;
    }
    if ([self.decriptionField.text isEmpty]){
        [CCStandardErrorHandler showErrorWithTitle:CCAlertsTitles.defaultError message:CCValidationMessages.descriptionCantBeBlank];
        return NO;
    }
    if ([self.priceField.text countOccurencesOfString:@"."] > 1){
        [CCStandardErrorHandler showErrorWithTitle:CCAlertsTitles.defaultError message:CCValidationMessages.priceHaveToBeDecemal];
        return NO;
    }
    if ([self.priceField.text isEmpty]){
        [CCStandardErrorHandler showErrorWithTitle:CCAlertsTitles.defaultError message:CCValidationMessages.priceCantBeBlank];
        return NO;
    }
    return YES;
}

- (CCBookUploadInfo *)createUploadInfo
{
    CCBookUploadInfo *uploadInfo = [CCBookUploadInfo new];
    uploadInfo.bookDescription = self.decriptionField.text;
    uploadInfo.collegeName = self.collegeSelectionButton.titleLabel.text;
    uploadInfo.thumbnail = self.thumbImage.image;
    uploadInfo.name = self.nameField.text;
    uploadInfo.price = [NSNumber numberWithInteger: (self.priceField.text.doubleValue * 100)];
    uploadInfo.collegeID = self.selectedCollege.collegeID;
    uploadInfo.isbn = self.isbnField.text;
    return uploadInfo;
}

- (void)didPressedImagesUploadingButton
{
    if([self isFieldsValid]){
        [self.imagesUploadTransaction performWithObject:^(NSArray *arrayOfImages){
            [self.backToSlefTransaction perform];
            [self showDoneButton];
            self.arrayOfImages = arrayOfImages;
            [self unableUploadButtons];
        }];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if(textField == self.priceField){
        [self.view endEditing:YES];
    } else {
        [[self.view viewWithTag:textField.tag+1] becomeFirstResponder];
        return YES;
    }
    return YES;
}


@end
