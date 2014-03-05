//
//  ICGDataManager.m
//  iCheckInGenie
//
//  Created by Krishna on 25/02/14.
//  Copyright (c) 2014 Gniyes Inc... All rights reserved.
//

#import "ICGDataManager.h"
#import "RemoteOperation.h"
#import "CommunicationManager.h"
#import "AFAppDotNetAPIClient.h"
#import "LoginOperation.h"

@implementation ICGDataManager

+(instancetype) defaultManager {

    static ICGDataManager *_defaultManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _defaultManager = [[ICGDataManager alloc] init];
    });
    return _defaultManager;
}

- (RemoteOperation *)operationForType:(NSString *)type
{
    NSString *plistPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"RemoteOperations"
                                                                           ofType:@"plist"];
    NSDictionary *remoteOperationsList = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    return [[NSClassFromString([remoteOperationsList objectForKey:type]) alloc] initWithType:type];
}

- (void) fetchData:(CommpletionHandler)block
{
    __block LoginOperation *op = (LoginOperation*)[self operationForType:ICGLogin];
    [op globalTimelinePostsWithBlock:^(id posts, NSError *error) {
        op.data = posts;
        block(op, error);
    }];

}


@end
