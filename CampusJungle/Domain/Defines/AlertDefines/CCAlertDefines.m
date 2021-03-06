//
//  CCAlertDefines.m
//  CollegeConnect
//
//  Created by Vlad Korzun on 15.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCAlertDefines.h"

const struct CCAlertsMessages CCAlertsMessages = {
    .connectToTheInternet = @"You must be connected to the internet to use this app",
    .serverUnavailable = @"Server is temporarily unavailable. Please try again later",
    .noInternetConnection = @"There is no Internet connection",
    .formNotValid = @"Form is not valid",
    .error = @"Error",
    .success = @"Success",
    .facebookError = @"Facebook authorization failed",
    .wrongEmailOfPassword = @"Wrong email or password",
    .authorizationFaild = @"Authorization failed",
    .confimAlert = @"Are you sure?",
    .emailNotValid = @"Email isn't valid",
    .firstNameNotValid = @"First name can't be empty",
    .lastNameNotValid = @"Last name can't be empty",
    .createCollege = @"In order to join class you should select your college first",
    .dropboxLinkingFaild = @"Dropbox linking failed",
    .emptyField = @"You should fill all mandatory fields",
    .setEmailFirst = @"Set your email in user profile first",
    .confirmation = @"Confirmation",
    .confirmationMessage = @"Are you sure?",
    .checkYourMail = @"Check your email box",
    .noteNotReadyForView = @"This note isn't ready for review. Try again later.",
    .haveNoClassesInSelectedCollege = @"You haven't classes in selected college",
    .incorrectAddress = @"Please enter correct address",
    .notAccurateAddress = @"Please enter more accurate address",
    .emptyLocationAddress = @"Please enter correct location address",
    .emptyLocationName = @"Please enter location name",
    .emptyLocationDescription = @"Please enter location description",
    .educationRemoving = @"All classes from deleted colleges will be deleted. Continue?",
    .noSelectedItems = @"Select some items first",
    .leaveGroup = @"Are you sure that you want to leave group?",
    .deleteGroup = @"Are you sure that you want to delete group?",
    .deleteMessage = @"Are you sure you want to delete message?",
    .deleteNote = @"Are you sure you want to delete note?",
    .deleteStuff = @"Are you sure you want to delete stuff?",
    .deleteBook = @"Are you sure you want to delete book?",
    .emailSendingError = @"An error occured during sending email. Please try again",
    .unableToSendEmail = @"Your device isn't able to send email. Check your settings",
    .unableToSendSms = @"Your device isn't able to send sms. Check your settings",
    .unableToImportContacts = @"There is no ability to get your address book. Check privacy settings of your device",
    .sendFacebookInviteError = @"Some error occured during sending invite. Please try again",
    .currentLocationError = @"Can't detect current location. Please try again",
};

const struct CCAlertsButtons CCAlertsButtons = {
    .okButton = @"Ok",
    .cancelButton= @"Cancel",
    .yesButton = @"Yes",
    .noButton = @"No",
    .show = @"See now",
    .later = @"See later",
};

const struct CCAlertsTitles CCAlertsTitles = {
    .requestError = @"Request failed",
    .defaultError = @"Error",
    .logOut = @"Log Out",
    .pushNotification = @"Push Notification",
};

const struct CCValidationMessages CCValidationMessages = {
    .emptyEmail = @"Email can't be blank",
    .emptyPassword = @"Password can't be blank",
    .emailNotValid = @"Email is not valid",
    .passNotValid = @"Password is to short",
    .firstNameCantBeBlank = @"First name can't be blank",
    .lastNameCantBeBlank = @"Last name can't be blank",
    .priceCantBeBlank = @"Price can't be blank",
    .fullPriceCantBeBlank = @"Full access price can't be blank",
    .priceHaveToBeDecemal = @"Price have to be decimal value",
    .fullPriceHaveToBeDecemal = @"Full price have to be decimal value",
    .fullPriceCantBeLowerThenPriceForReview = @"Full access price can't be lower than price for review",
    .descriptionCantBeBlank = @"Description can't be blank",
    .filterCanNotBeEmpty = @"Filter can't be blank",
    .emptyName = @"Name can't be blank",
    .emptyDescription = @"Description can't be blank",
    .emptyQuestionText = @"Question text can't be blank",
    .emptyAnswerText = @"Answer text can't be blank",
    .emptyCommentText = @"Comment text can't be blank",
    .emptyUploadText = @"Please enter upload message",
    .emptyUploadName = @"Please enter upload name",
    .emptyMessageText = @"Message can't be blank",
    .emptyTopic = @"Please enter topic",
    .noUsersSelected = @"Select some users first",
    .emptyReportText = @"Report text can't be blank",
    .passwordAndConfirmationDoNotMatched = @"New password and password confirmation don't match",
};
