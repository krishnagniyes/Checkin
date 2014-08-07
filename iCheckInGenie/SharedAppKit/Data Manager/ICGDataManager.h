//
//  ICGDataManager.h
//  iCheckInGenie
//
//  Created by Krishna on 25/02/14.
//  Copyright (c) 2014 Gniyes Inc... All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RemoteOperation.h"
#import "LoginResponse.h"

@interface ICGDataManager : NSObject
+ (instancetype) defaultManager;

@property (nonatomic, strong) LoginResponse *loginResponse;

@property (nonatomic, strong) NSArray *eventsList;

@property (nonatomic, strong) NSArray *attendeesList;


- (RemoteOperation*)operationForType:(NSString *)type;
- (void)fetchData:(CommpletionHandler)block;
- (void)parseDataForLogin:(id) data;
- (NSArray*)listOfEventsFromData:(id)data;
- (void)attendeeList:(id)data;

@end
