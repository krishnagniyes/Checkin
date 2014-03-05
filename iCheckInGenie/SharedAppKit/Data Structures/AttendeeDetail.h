//
//  AttendeeDetail.h
//  iCheckInGenie
//
//  Created by Krishna on 02/03/14.
//  Copyright (c) 2014 Apple. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface AttendeeDetail : NSManagedObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *deviceType;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, assign) BOOL isUpdatedR;

@end
