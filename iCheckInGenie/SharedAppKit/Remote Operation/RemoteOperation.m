
#import "RemoteOperation.h"


NSString *const ICGLogin = @"icg.operation.login";
NSString *const GGDestinations = @"gogreen.operation.destinations.get";

@interface RemoteOperation () <NSXMLParserDelegate>

@property (copy, readwrite) NSData *responseData;
@property (strong) NSInvocation *_invocation;  // a private invocation property.


@end

@implementation RemoteOperation

- (id) initWithType:(NSString *)operationType
{
    self.type = operationType;
    return self;
}

- (NSMutableURLRequest *) createRequest
{
    return nil;
}

- (void)request
{

}

@end
