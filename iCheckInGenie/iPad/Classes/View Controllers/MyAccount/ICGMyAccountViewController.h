//
//  ICGMyAccountViewController.h
//  iCheckInGenie
//
//  Created by Krishna on 21/02/14.
//  Copyright (c) 2014 Gniyes Inc... All rights reserved.
//

#import "ICGBaseViewController.h"

typedef enum {
    kPICell = 0,
    kNotificationCell,
    kAboutCell
}CellType;

@interface ICGMyAccountViewController : ICGBaseViewController
- (IBAction)updateSwitch:(id)sender;
@end
