//
//  Specialist.m
//  NoveoHomeworkOne
//
//  Created by Wadim on 7/14/14.
//  Copyright (c) 2014 Smirnov Electronics. All rights reserved.
//

#import "Specialist.h"

@implementation Specialist

@synthesize salary = _salary, degree = _degree, universityName = _universityName, departmentName = _departmentName;
@synthesize subordinatesList = _subordinatesList;

static NSString *const defaultSpecialistFirstName = @"Unknown Specialist Firstname";
static NSString *const defaultSpecialistLastName = @"Unknown Specialist Lastname";
static NSString *const defaultSpecialistNickName = @"Unknown Specialist Nickname";

static const int defaultSpecialistAge = 35;
static const int defaultSpecialistSalary = 50000;
static const MemberDegree defaultSpecialistDegree = memberDegreePostgraduateDegree;

#pragma mark -
#pragma mark Initializers

// Designated initializer
- (instancetype) initSpecialistWithFirstName:(NSString *) newFirstName
                                    lastName:(NSString *) newLastName
                                    nickName:(NSString *) newNickName
                                         age:(NSNumber *) newAge
                                      gender:(HumanGenderId) newGenderId
                                  university:(NSString *) newUniversity
                                  department:(NSString *) newDepartment
                                      salary:(NSNumber *) newSalary
                                      degree:(MemberDegree) newDegree {
    if (self = [super initWithFirstName:newFirstName
                               lastName:newLastName
                               nickName:newNickName
                                    age:newAge
                                 gender:newGenderId]) {
        _universityName = newUniversity;
        _departmentName = newDepartment;
        _salary = newSalary;
        _degree = newDegree;
        _subordinatesList = [[NSMutableArray alloc]init];
        _chief = nil;
    }
    return self;
}

- (instancetype) initSpecialistWithFirstName:(NSString *) newFirstName
                                    lastName:(NSString *) newLastName
                                      degree:(MemberDegree) newDegree
                                  department:(NSString *)newDepartment{
    // Return
    return [self initSpecialistWithFirstName:newFirstName
                                    lastName:newLastName
                                    nickName:defaultSpecialistNickName
                                         age:@(defaultSpecialistAge)
                                      gender:humanGenderIsNotDefined
                                  university:nil
                                  department:newDepartment
                                      salary:@(defaultSpecialistSalary)
                                      degree:defaultSpecialistDegree];
}

- (instancetype) init {
    return [self initSpecialistWithFirstName:defaultSpecialistFirstName
                                    lastName:defaultSpecialistLastName
                                      degree:defaultSpecialistDegree
                                  department:nil];
}

#pragma mark -
#pragma mark Protocol EducationMember Implementation

- (void) setChief:(id<EducationMember>)chief {
    if (_chief) {
        [_chief removeFromSubordunateList:self];
    }
    if (chief) {
        if (![[chief getSubordinatesList]containsObject:self]) { // Protect from duplicate addition to list
            [chief addSubordinate:self];
        }
    }
    _chief = chief;
}

- (void) setSubordinatesList:(NSArray *)subordinateList{
    [_subordinatesList removeAllObjects];
    [_subordinatesList addObjectsFromArray:subordinateList];
}

- (NSArray *) getSubordinatesList{
    return [NSArray arrayWithArray:_subordinatesList];
    
}

- (void) addSubordinate:(id<EducationMember>)subordinate{
    if (![_subordinatesList containsObject:subordinate]) { // Protect from duplicate addition to list
        [_subordinatesList addObject:subordinate];
    }
}

- (void) addSubordinateList:(NSArray *)subordinateList {
    [_subordinatesList addObjectsFromArray:subordinateList];
}

- (void) removeFromSubordunateList:(id<EducationMember>)member {
    [_subordinatesList removeObject:member];
}

- (void) removeChief {
    [self setChief:nil];
}

- (NSString *) universityName {
    if (_universityName) {
        return _universityName;
    }
    return [_chief universityName];
}

- (NSString *) departmentName {
    if (_departmentName) {
        return _departmentName;
    }
    return [_chief departmentName];
}

- (NSNumber *) averagePoints {
    float floatAveragePoints = 0;
    for (id<EducationMember>currentSub in _subordinatesList) {
        floatAveragePoints += [[currentSub averagePoints]floatValue];
    }
    floatAveragePoints/=[_subordinatesList count];
    return @(floatAveragePoints);
}

@end
