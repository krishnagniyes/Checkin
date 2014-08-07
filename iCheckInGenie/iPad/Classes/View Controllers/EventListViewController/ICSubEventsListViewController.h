//
//  ICSubEventsListViewController.h
//  iCheckInGenie
//
//  Created by Krishna on 7/30/14.
//  Copyright (c) 2014 Apple. All rights reserved.
//

#import "ICGBaseViewController.h"
#import "EventList.h"

@interface ICSubEventsListViewController : ICGBaseViewController
@property (nonatomic, strong) NSArray *subEventsList;
@property (nonatomic, strong) EventList *eventDetail;

@end
