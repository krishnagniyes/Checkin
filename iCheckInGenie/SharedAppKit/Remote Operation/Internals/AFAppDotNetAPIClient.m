// AFAppDotNetAPIClient.h
//
// Copyright (c) 2012 Mattt Thompson (http://mattt.me/)
// 
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "AFAppDotNetAPIClient.h"
#import "AFURLRequestSerialization.h"
//http://mobile.jumpdates.com/apis/?api=state&device=iphone
//static NSString * const AFAppDotNetAPIBaseURLString = @"http://mobile.jumpdates.com/apis/";

static NSString * const kCheckINBaseURL = @"https://api.parse.com/1/";

static NSString * const kCheckINApplicationId = @"RwdXgm7GoNijDKwUJDhFWmjtQVBsJwn4vh8axjkB";
static NSString * const kCheckINParseAPIKey = @"CSFhPyZWuiU2IwChhHNva1q992OvQayQCOsFwUV3";


@implementation ICGAPIClient

+ (instancetype)sharedClient {
    static ICGAPIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[ICGAPIClient alloc] initWithBaseURL:[NSURL URLWithString:kCheckINBaseURL]];
        AFHTTPRequestSerializer *r = [AFHTTPRequestSerializer serializer];
        [r setValue:kCheckINApplicationId forHTTPHeaderField:@"X-Parse-Application-Id"];
        [r setValue:kCheckINParseAPIKey forHTTPHeaderField:@"X-Parse-REST-API-Key"];

    });
    
    return _sharedClient;
}

- (NSURLSessionDataTask *)GET:(NSString *)URLString
                   parameters:(NSDictionary *)parameters
                      success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:@"GET" URLString:[[NSURL URLWithString:URLString relativeToURL:self.baseURL] absoluteString] parameters:parameters error:nil];
    
    NSString *  kCheckINApplicationId = @"iLqFPBiX8inakdzjQ4f3mhlJBlYQSVOckiN6qw3t";
    NSString *  kCheckINParseAPIKey = @"KpSqCwYaM0hm3CyBZcc1TA5D9mvtM9snQ9h67eAJ";
    
    [request addValue:kCheckINApplicationId forHTTPHeaderField:@"X-Parse-Application-Id"];
    [request addValue:kCheckINParseAPIKey forHTTPHeaderField:@"X-Parse-REST-API-Key"];
    
    
    __block NSURLSessionDataTask *task = [self dataTaskWithRequest:request completionHandler:^(NSURLResponse * __unused response, id responseObject, NSError *error) {
        if (error) {
            if (failure) {
                failure(task, error);
            }
        } else {
            if (success) {
                success(task, responseObject);
            }
        }
    }];
    
    [task resume];
    
    return task;
}

@end
