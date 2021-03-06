//
//  Student.m
//  NoveoHomeworkOne
//
//  Created by Wadim on 7/14/14.
//  Copyright (c) 2014 Smirnov Electronics. All rights reserved.
//

#import "Student.h"

@implementation Student

@synthesize degree = _degree, averagePoints = _averagePoints, lecturerList = _lecturerList, chief = _chief;
@synthesize delegate = _delegate;

static NSString *const defaultStudentFirstName = @"Unknown Student Firstname";
static NSString *const defaultStudentLastName = @"Unknown Student Lastname";
static NSString *const defaultStudentNickName = @"Unknown Student Nickname";

static const int defaultStudentAge = 17;
static const float defaultStudentAveragePoints = 4.1;
static const MemberDegree defaultStudentDegree = memberDegreeStudentDegree;


#pragma mark -
#pragma mark Initializers

// Designated initializer
- (instancetype) initSudentWithFirstName:(NSString *) newFirstName
                                lastName:(NSString *) newLastName
                                nickName:(NSString *) newNickName
                                     age:(NSNumber *) newAge
                                  gender:(HumanGenderId) newGenderId
                           averagePoints:(NSNumber *) newAveragePoints {
    // Start initializer
    if (self = [super initWithFirstName:newFirstName
                               lastName:newLastName
                               nickName:newNickName
                                    age:newAge
                                 gender:newGenderId]) {
        _averagePoints = newAveragePoints;
        _degree = defaultStudentDegree;
        _lecturerList = [[NSMutableArray alloc]init];
        _chief = nil;
    }
    return self;
}

- (instancetype) initStudenttWithFirstName:(NSString *) newFirstName
                                  lastName:(NSString *) newLastName
                                       age:(NSNumber *) newAge {
    // Return
    return [self initSudentWithFirstName:newFirstName
                                lastName:newLastName
                                nickName:defaultStudentNickName
                                     age:newAge
                                  gender:humanGenderIsNotDefined
                           averagePoints:@(defaultStudentAveragePoints)];
}
    
- (instancetype) init {
    return [self initStudenttWithFirstName:defaultStudentFirstName
                                  lastName:defaultStudentLastName
                                       age:@(defaultStudentAge)];
}

#pragma mark -
#pragma mark Protocol EducationMember Implementation
    
- (void) setChief:(id<EducationMember>)chief {
    if (_chief) {
        [_chief removeFromSubordunateList:self];
    }
    if (chief) {
        [chief addSubordinate:self];
    }
    _chief = chief;
}


- (void) setSubordinatesList:(NSArray *)subordinateList{
    NSLog(@"Adding subordinate list error: Student can't have a subordinates");
}

- (NSArray *) getSubordinatesList{
    // NSLog(@"Getting subordinate list error: Student can't have a subordinates"); 
    return nil;
}

- (void) addSubordinate:(id)subordinate{
    NSLog(@"Adding subordinate error: Student can't have a subordinates");
}

- (void) removeFromSubordunateList:(id)member {
    NSLog(@"Removing subordinate list error: Student can't have a subordinates");
}

- (void) removeChief {
    [self setChief:nil];
}

- (NSString *) universityName {
    return [_chief universityName];
}

- (NSString *) departmentName {
    return [_chief departmentName];
}

- (void) setAveragePoints:(NSNumber *)averagePoints {
    _averagePoints = averagePoints;
        if ([_delegate respondsToSelector:@selector(recalculatePoints:)]) {
            [_delegate recalculatePoints:self];
        }
}

    

@end
