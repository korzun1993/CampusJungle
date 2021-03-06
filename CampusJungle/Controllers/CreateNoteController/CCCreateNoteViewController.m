//
//  CCCreateNoteViewController.m
//  CampusJungle
//
//  Created by Vlad Korzun on 07.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCCreateNoteViewController.h"
#import "CCNoteUploadInfo.h"
#import "NSString+CJStringValidator.h"
#import "CCStandardErrorHandler.h"
#import "CCUserSessionProtocol.h"
#import "CCCollege.h"
#import "CCEducation.h"
#import "CCClassesApiProviderProtocol.h"
#import "MBProgressHUD.h"
#import "ActionSheetCustomPicker.h"
#import "CCActionSheetPickerCollegesDelegate.h"
#import "CCAvatarSelectionProtocol.h"
#import "CCAvatarSelectionActionSheet.h"
#import "CCNotesAPIProviderProtolcol.h"
#import "CCUploadProcessManagerProtocol.h"
#import "NSString+CountString.h"

@interface CCCreateNoteViewController ()<CCCellSelectionProtocol,CCAvatarSelectionProtocol>

@property (nonatomic, weak) IBOutlet UITextField *priceField;
@property (nonatomic, weak) IBOutlet UITextField *fullAccessPriceField;
@property (nonatomic, weak) IBOutlet SSTextView *descriptionField;
@property (nonatomic, weak) IBOutlet UIImageView *thumbView;
@property (nonatomic, weak) IBOutlet UIButton *collegeSelectionButton;
@property (nonatomic, weak) IBOutlet UIButton *classesSelectionButton;
@property (nonatomic, weak) IBOutlet UITextField *nameTextField;
@property (nonatomic, strong) CCAvatarSelectionActionSheet *thumbSelectionSheet;
@property (nonatomic, weak) IBOutlet UIImageView *textViewBackgroundImageView;
@property (nonatomic, strong) CCCollege *selectedCollege;
@property (nonatomic, strong) CCClass *selectedClass;

@property (nonatomic, strong) NSArray *arrayOfColleges;
@property (nonatomic, strong) NSArray *arrayOfClasses;
@property (nonatomic, strong) id <CCUserSessionProtocol> ioc_userSession;
@property (nonatomic, strong) id <CCClassesApiProviderProtocol> ioc_classesAPI;
@property (nonatomic, strong) id <CCNotesAPIProviderProtolcol> ioc_notesAPIProvider;

@property (nonatomic, weak) IBOutlet UIButton *imageDropboxButton;
@property (nonatomic, weak) IBOutlet UIButton *pdfDropboxButton;
@property (nonatomic, weak) IBOutlet UIButton *imageButton;

@property (nonatomic, strong) id <CCUploadProcessManagerProtocol> ioc_uploadingManager;

@property (nonatomic, strong) NSString *pdfURL;
@property (nonatomic, strong) NSArray *arrayOfURLs;
@property (nonatomic, strong) NSArray *arrayOfImages;

@property (nonatomic, strong) NSArray *arrayOfItemsForPicker;

@end

@implementation CCCreateNoteViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"New Note";
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self loadCollegesPickerInfo];
    [self loadClasses];
    [self configAvatarSelectionSheet];
    self.tapRecognizer.enabled = YES;
    self.descriptionField.placeholder = @"Description";
    [self setupImageViews];
}

- (void)setupImageViews
{
    [self.textViewBackgroundImageView setImage:[[UIImage imageNamed:@"text_box"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)]];
}

- (void)showDoneButton
{
    [self setRightNavigationItemWithTitle:@"Done" selector:@selector(upload)];
}

- (void)upload
{
    if([self isFieldsValid]){
        CCNoteUploadInfo *uploadInfo = [self createUploadInfo];
        if(self.arrayOfImages){
            [self uploadWithImagesNote:uploadInfo];
        } else if(self.arrayOfURLs){
            uploadInfo.arrayOfURLs = self.arrayOfURLs;
            [self uploadWithUrls:uploadInfo];
        } else {
            uploadInfo.pdfUrl = self.pdfURL;
            [self uploadWithUrls:uploadInfo];
        }
    }
}

- (void)uploadWithImagesNote:(CCNoteUploadInfo *)uploadInfo
{
    uploadInfo.arrayOfImages = self.arrayOfImages;
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Preparing for upload";
    __weak id weakSelf = self;
    id <CCUploadProcessManagerProtocol> uploadManager = self.ioc_uploadingManager;
    [[self.ioc_uploadingManager uploadingNotes] addObject:uploadInfo];
    [self.ioc_notesAPIProvider postUploadInfoWithImages:uploadInfo successHandler:^(id result) {
        [[uploadManager uploadingNotes] removeObject:uploadInfo];
        [uploadManager reloadDelegate];
    } errorHandler:^(NSError *error) {
        [[uploadManager uploadingNotes] removeObject:uploadInfo];
        [CCStandardErrorHandler showErrorWithError:error];
        [uploadManager reloadDelegate];
    } progress:^(double finished) {
        [[weakSelf backToListTransaction] perform];
        uploadInfo.uploadProgress = [NSNumber numberWithDouble:finished];
    }];
}

- (void)uploadWithUrls:(CCNoteUploadInfo *)uploadInfo
{
    [self.ioc_notesAPIProvider postDropboxUploadInfo:uploadInfo successHandler:^(id result) {
        [self.backToListTransaction perform];
    } errorHandler:^(NSError *error) {
        [CCStandardErrorHandler showErrorWithError:error];
    }];
}

- (void)configAvatarSelectionSheet
{
    self.thumbSelectionSheet = [CCAvatarSelectionActionSheet new];
    self.thumbSelectionSheet.delegate = self;
}

- (void)loadClasses
{
    [self.ioc_classesAPI getAllClasesSuccessHandler:^(id classes) {
        self.arrayOfClasses = classes;
        [self checkIsEverythingReady];
    } errorHandler:^(NSError *error) {
        [CCStandardErrorHandler showErrorWithError:error];
    }];
}

- (void)loadCollegesPickerInfo
{
    [self.ioc_userSession loadUserEducationsSuccessHandler:^(id educations) {
        self.arrayOfColleges = [CCEducation arrayOfCollegesFromEducations:educations];
        [self checkIsEverythingReady];
        if(self.arrayOfColleges.count){
            self.selectedCollege = self.arrayOfColleges[0];
        }
    }];
}

- (void)checkIsEverythingReady
{
    if(self.arrayOfClasses && self.arrayOfColleges){
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }
}

- (void)setSelectedCollege:(CCCollege *)selectedCollege
{
    _selectedCollege = selectedCollege;
    [self.collegeSelectionButton setTitle:selectedCollege.name forState:UIControlStateNormal];
    self.selectedClass = nil;
    [self.classesSelectionButton setTitle:@"Select Class" forState:UIControlStateNormal];
}

- (void)setSelectedClass:(CCClass *)selectedClass
{
    _selectedClass = selectedClass;
    [self.classesSelectionButton setTitle:selectedClass.name forState:UIControlStateNormal];
}

- (BOOL)isFieldsValid
{
    if(self.nameTextField.text.isEmpty){
        [CCStandardErrorHandler showErrorWithTitle:CCAlertsTitles.defaultError message:CCValidationMessages.emptyName];
        return NO;
    }
    if ([self.descriptionField.text isEmpty]){
        [CCStandardErrorHandler showErrorWithTitle:CCAlertsTitles.defaultError message:CCValidationMessages.descriptionCantBeBlank];
        return NO;
    }
    if ([self.fullAccessPriceField.text countOccurencesOfString:@"."] > 1){
        [CCStandardErrorHandler showErrorWithTitle:CCAlertsTitles.defaultError message:CCValidationMessages.fullPriceHaveToBeDecemal];
        return NO;
    }
    if ([self.fullAccessPriceField.text isEmpty]){
        [CCStandardErrorHandler showErrorWithTitle:CCAlertsTitles.defaultError message:CCValidationMessages.fullPriceCantBeBlank];
        return NO;
    }
    return YES;
}

- (IBAction)imagesFromDropBoxButtonDidPressed
{
    if([self isFieldsValid]){
        [self.imagesDropboxUploadTransaction performWithObject:^(NSArray *arrayOfUrls){
            [self.backToSelfController perform];
            [self showDoneButton];
            self.arrayOfURLs = arrayOfUrls;
            [self unableUploadButtons];
        }];
    }
}

- (IBAction)pdfFromDropboxButtonDidPressed
{
    if([self isFieldsValid]){
        [self.pdfDropboxUploadTransaction performWithObject:^(NSArray *arrayOfUrls){
            [self.backToSelfController perform];
            [self showDoneButton];
            self.pdfURL = arrayOfUrls.lastObject;
            [self unableUploadButtons];
        }];
    }
}

- (IBAction)UploadPhotosDidPressed
{
    if([self isFieldsValid]){
        [self.imagesUploadTransaction performWithObject:^(NSArray *arrayOfImages){
            [self.backToSelfController perform];
            [self showDoneButton];
            self.arrayOfImages = arrayOfImages;
            [self unableUploadButtons];
        }];
    }
}

- (CCNoteUploadInfo *)createUploadInfo
{
    CCNoteUploadInfo *noteInfo = [CCNoteUploadInfo new];
    noteInfo.noteDescription = self.descriptionField.text;
    noteInfo.price = @0;
    noteInfo.fullPrice = [NSNumber numberWithInteger:(self.fullAccessPriceField.text.doubleValue * 100)];
    noteInfo.collegeID = self.selectedCollege.collegeID;
    noteInfo.classID = [NSNumber numberWithInteger: self.selectedClass.classID.integerValue];
    noteInfo.thumbnail = self.thumbView.image;
    noteInfo.name = self.nameTextField.text;
    return noteInfo;
}

- (IBAction)thumbDidPressed
{
    [self.thumbSelectionSheet showWithTitle:@"Select Note Thumbnail" takePhotoButtonTitle:nil takeFromGalleryButtonTitle:nil];
}

- (void)didSelectAvatar:(UIImage *)avatar
{
    self.thumbView.image = avatar;
}

- (IBAction)collegeSelectionButtonDidPressed
{
    CCActionSheetPickerCollegesDelegate *delegate = [CCActionSheetPickerCollegesDelegate new];
    delegate.arrayOfItems = self.arrayOfColleges;
    delegate.delegate = self;
    [ActionSheetCustomPicker showPickerWithTitle:@"Colleges" delegate:delegate showCancelButton:YES origin:self.view];
}

- (IBAction)classSelectionButtonDidPresed
{
    NSArray *classesInSelectedCollege = [self filterArrayOfClasses:self.arrayOfClasses];
    if (classesInSelectedCollege.count){
        CCActionSheetPickerCollegesDelegate *delegate = [CCActionSheetPickerCollegesDelegate new];
        delegate.arrayOfItems = classesInSelectedCollege;
        delegate.delegate = self;
        [ActionSheetCustomPicker showPickerWithTitle:@"Classes" delegate:delegate showCancelButton:YES origin:self.view];
    } else {
        [CCStandardErrorHandler showErrorWithTitle:nil message:CCAlertsMessages.haveNoClassesInSelectedCollege];
    }
}

- (void)unableUploadButtons
{
    self.imageButton.enabled = NO;
    self.imageDropboxButton.enabled = NO;
    self.pdfDropboxButton.enabled = NO;
}

- (NSArray *)filterArrayOfClasses:(NSArray *)classes
{
    NSMutableArray *arrayOfClasses = [NSMutableArray new];
    for (CCClass *currentClass in classes){
        if([self.selectedCollege.collegeID isEqualToString: currentClass.collegeID]){
            [arrayOfClasses addObject:currentClass];
        }
    }
    return arrayOfClasses;
}

- (void)didSelectedCellWithObject:(id)cellObject
{
    if([cellObject isKindOfClass:[CCCollege class]]){
        self.selectedCollege = cellObject;
    } else {
        self.selectedClass = cellObject;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if(textField == self.fullAccessPriceField){
        [self.view endEditing:YES];
    } else {
        [[self.view viewWithTag:textField.tag+1] becomeFirstResponder];
        return YES;
    }
    return YES;
}


@end
