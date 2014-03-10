//
//  AttendeeDetail.h
//  iCheckInGenie
//
//  Created by Krishna on 10/03/14.
//  Copyright (c) 2014 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface AttendeeDetail : NSManagedObject

@property (nonatomic, retain) NSString * attendeeType;
@property (nonatomic, retain) NSString * prefix;
@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSString * workSpeciality;
@property (nonatomic, retain) NSString * groupAffiliation;
@property (nonatomic, retain) NSString * numberofYearsinpractice;
@property (nonatomic, retain) NSString * degree;
@property (nonatomic, retain) NSString * yearGraduated;
@property (nonatomic, retain) NSString * pri_Address1;
@property (nonatomic, retain) NSString * pri_Address2;
@property (nonatomic, retain) NSString * city;
@property (nonatomic, retain) NSString * state;
@property (nonatomic, retain) NSString * zipcode;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * telephone;
@property (nonatomic, retain) NSString * cell;
@property (nonatomic, retain) NSString * workPhone;
@property (nonatomic, retain) NSString * dietPreference;
@property (nonatomic, retain) NSString * tables;
@property (nonatomic, retain) NSString * alumniChapter;

@end
