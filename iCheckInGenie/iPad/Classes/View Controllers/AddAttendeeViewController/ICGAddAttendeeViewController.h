//
//  ICGAddAttendeeViewController.h
//  iCheckInGenie
//
//  Created by Krishna on 12/02/14.
//  Copyright (c) 2014 Gniyes Inc.. All rights reserved.
//

#import "ICGBaseViewController.h"
#import "AttendeeDetails.h"

@interface ICGAddAttendeeViewController : ICGBaseViewController

-(IBAction)cancelDetailView:(id)sender;
-(IBAction)saveDetailView:(id)sender;

@property (nonatomic, strong) AttendeeDetails *attendeeDetail;

@end
