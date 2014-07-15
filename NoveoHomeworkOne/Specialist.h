//
//  Specialist.h
//  NoveoHomeworkOne
//
//  Created by Wadim on 7/14/14.
//  Copyright (c) 2014 Smirnov Electronics. All rights reserved.
//

#import "Human.h"
#import "EducationMember.h"

@interface Specialist : Human <EducationMember>

@property (nonatomic, retain) NSNumber *salary;
@property (nonatomic, assign) MemberDegree degree;
@property (nonatomic, retain) NSMutableArray *subordinatesList;
@property (nonatomic, weak) id<EducationMember> chief;

// Decignated initializer
- (id) initSpicialistWith:(NSString *) firstName
                         :(NSString *) lastName
                         :(NSString *) nickName
                         :(NSNumber *) age
                         :(HumanGender) gender
                         :(NSString *) university
                         :(NSString *) department
                         :(NSNumber *) salary
                         :(MemberDegree) degree;


@end
