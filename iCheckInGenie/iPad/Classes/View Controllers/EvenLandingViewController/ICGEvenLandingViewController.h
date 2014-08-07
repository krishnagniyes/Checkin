//
//  ICGEvenLandingViewController.h
//  iCheckInGenie
//
//  Created by Krishna on 12/02/14.
//  Copyright (c) 2014 Gniyes Inc.. All rights reserved.
//

#import "ICGBaseViewController.h"
#import "EventList.h"

typedef enum
{
    kCheckInOption = 0,
    kAddAttendee,
    kSyncOption,
    kScanOption,
    kMyAccountOptions,
    kLogoutOption
}OptionName;

@interface ICGEvenLandingViewController : ICGBaseViewController
@property (nonatomic, strong) EventList* event;
@end






