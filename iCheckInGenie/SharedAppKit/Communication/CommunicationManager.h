#import <Foundation/Foundation.h>
#import "RemoteOperation.h"
#import "AFHTTPSessionManager.h"

typedef void (^ConnectionCompletionHandler) (NSError *error);
typedef void (^HKRemoteOperationCommpletionHandler) (id operation, NSError *error);

typedef void (^RemoteOperationCommpletionHandler) (RemoteOperation *data, NSError *error);


@interface CommunicationManager : AFHTTPSessionManager

@property (readonly, assign) BOOL isConnected;

+ (instancetype) defaultManager;

- (void) connectUsingCompletionHandler:(ConnectionCompletionHandler)block;

//// Returns an appropriate operation object based on type.
- (RemoteOperation *)operationForType:(NSString *)type;
- (NSURLSessionDataTask*) addRemoteOperation:(id) operation usingCompletionHandler:(RemoteOperationCommpletionHandler)block;
@end