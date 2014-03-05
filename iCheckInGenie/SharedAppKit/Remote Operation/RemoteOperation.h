
#import <Foundation/Foundation.h>

extern NSString *const ICGLogin;
extern NSString *const GGDestinations;

typedef void (^CommpletionHandler) (id data, NSError *error);

@interface RemoteOperation : NSObject<NSXMLParserDelegate>

@property (readwrite, copy) NSString *type;  // an operation type.

@property (readonly, strong) id returnedValue;  // a returned value after the operation is completed.

@property (strong) id data; // ** construct the data part according to the direction.


- (NSMutableURLRequest *) createRequest;
- (id) initWithType:(NSString *)operationType;

- (void)request;
@end
