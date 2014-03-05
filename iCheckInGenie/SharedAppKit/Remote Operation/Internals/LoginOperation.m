//
//  LoginOperation.m
//  iCheckInGenie
//
//  Created by Krishna on 25/02/14.
//  Copyright (c) 2014 Gniyes Inc... All rights reserved.
//

#import "LoginOperation.h"
#import "AFAppDotNetAPIClient.h"

@implementation LoginOperation

- (NSURLSessionDataTask *)globalTimelinePostsWithBlock:(void (^)(id data, NSError *error))block {
    return [[ICGAPIClient sharedClient] GET:@"?api=state&device=iphone" parameters:nil success:^(NSURLSessionDataTask * __unused task, id JSON) {
        if (block) {
            block(JSON, nil);
            //Success
        }
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        if (block) {
            ///Failure
            block([NSArray array], error);
        }
    }];
}
@end
