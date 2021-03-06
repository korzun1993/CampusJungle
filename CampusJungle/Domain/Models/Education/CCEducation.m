//
//  CCEducation.m
//  CampusJungle
//
//  Created by Vlad Korzun on 30.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCEducation.h"
#import "CCCollege.h"

@implementation CCEducation

- (BOOL)isEqualToEducation:(CCEducation *)education
{
    if(![self.graduationDate isEqualToString:education.graduationDate] && (self.graduationDate || education.graduationDate) ){
        return NO;
    }
    if(![self.collegeName isEqualToString:education.collegeName]){
        return NO;
    }
    if(![self.collegeID isEqualToString:education.collegeID]){
        return NO;
    }
    return YES;
}

+ (NSArray *)arrayOfCollegesIDFromEducations:(NSArray *)educations
{
    NSMutableArray *colleges = [NSMutableArray new];
    for(CCEducation *education in educations){
        if(![CCEducation isID:education.collegeID alreadyExistIn:colleges]){
            [colleges addObject:education.collegeID];
        }
    }
    return colleges;
}

+ (NSArray *)arrayOfCollegesFromEducations:(NSArray *)educations
{
    NSMutableArray *arrayOfColleges = [NSMutableArray new];
    for(CCEducation *education in educations){
        if(![CCEducation isArrayOfColleges:arrayOfColleges containCollegeWithID:education.collegeID]){
            CCCollege *newCollege = [CCCollege new];
            newCollege.collegeID = education.collegeID;
            newCollege.name = education.collegeName;
            [arrayOfColleges addObject:newCollege];
        }
    }
    return arrayOfColleges;
}

+ (BOOL)isArrayOfColleges:(NSArray *)arrayOfColleges containCollegeWithID:(NSString *)newCollegeID
{
    for(CCCollege *college in arrayOfColleges){
        if([college.collegeID isEqualToString:newCollegeID]){
            return YES;
        }
    }
    
    return NO;
}

+ (BOOL)isID:(NSString *)collegeID alreadyExistIn:(NSArray *)collegeIds
{
    for (NSString *existCollegeID in collegeIds){
        if ([existCollegeID isEqualToString:collegeID]){
            return YES;
        }
    }
    return NO;
}

+ (NSDictionary *)responseMappingDictionary
{
    return @{
      @"graduation_date" : @"graduationDate",
      @"college_name" : @"collegeName",
      @"user_status" : @"status",
      @"college_id" : @"collegeID",
      };
}

@end
