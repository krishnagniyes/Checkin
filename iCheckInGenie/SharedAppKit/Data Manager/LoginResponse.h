//
//  LoginResponse.h
//  iCheckInGenie
//
//  Created by Krishna on 7/28/14.
//  Copyright (c) 2014 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginResponse : NSObject

@property (nonatomic, copy) NSString *CreatedTimestamp;
@property (nonatomic, copy) NSString *DeviceID;
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *OrganizerID;
@property (nonatomic, copy) NSString *Token;

@end
