//
//  LoginOperation.h
//  iCheckInGenie
//
//  Created by Krishna on 25/02/14.
//  Copyright (c) 2014 Gniyes Inc... All rights reserved.
//

#import "RemoteOperation.h"

@interface LoginOperation : RemoteOperation

- (NSURLSessionDataTask *)globalTimelinePostsWithBlock:(void (^)(id data, NSError *error))block;

@end
