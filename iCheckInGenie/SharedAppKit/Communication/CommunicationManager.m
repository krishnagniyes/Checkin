
#import "CommunicationManager.h"
#import "RemoteOperation.h"


static NSString * const kBaseURL = @"http://mobile.jumpdates.com/apis/?api=state&device=iphone";


@interface CommunicationManager()

@property (nonatomic, strong) ConnectionCompletionHandler communicationCompletionBlock;

@property (strong, nonatomic) dispatch_queue_t theQueue;

@end

@implementation CommunicationManager

#pragma mark -
#pragma Singleton methods

+ (instancetype) defaultManager
{
    static CommunicationManager *_defaultManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _defaultManager = [[self alloc] init];
    });
    
    return _defaultManager;
}

+ (id) alloc
{
    return [self defaultManager];
}

+ (id) allocWithZone:(NSZone *)zone
{
    return [self defaultManager];
}

- (id) copyWithZone:(NSZone*)zone
{
    return self;
}

- (void) connectUsingCompletionHandler:(ConnectionCompletionHandler)block
{
    @try {
        self.theQueue = dispatch_queue_create("SerialQueue", NULL);
    }
    @catch (NSException *exception) {
    }
}

- (RemoteOperation *)operationForType:(NSString *)type
{
    NSString *plistPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"RemoteOperations"
                                                                           ofType:@"plist"];
    NSDictionary *remoteOperationsList = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    return [[NSClassFromString([remoteOperationsList objectForKey:type]) alloc] initWithType:type];
}

- (NSURLSessionDataTask*) addRemoteOperation:(id) operation usingCompletionHandler:(RemoteOperationCommpletionHandler)block
{
    return [[CommunicationManager defaultManager] GET:@"stream/0/posts/stream/global" parameters:nil success:^(NSURLSessionDataTask * __unused task, id JSON) {
        
        if (block) {
            //Return Resulted Data
            block(nil, nil);
        }
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        if (block) {
            block(nil, error);
        }
    }];
}


- (void)handleError:(NSError *)error {
    
    NSString *errorMessage = [error localizedDescription];
    NSString *alertTitle = NSLocalizedString(@"Error", @"Title for alert displayed when download or parse error occurs.");
    NSString *okTitle = NSLocalizedString(@"OK ", @"OK Title for alert displayed when download or parse error occurs.");
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:alertTitle message:errorMessage delegate:nil cancelButtonTitle:okTitle otherButtonTitles:nil];
    [alertView show];
}

@end