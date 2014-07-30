//
//  Lib2ErgoRequestUtils.m
//  PizzaExpress
//
// Copyright 2011, 2ergo Limited.

#import "Lib2ErgoRequestUtils.h"
#import "CommonUtils.h"
#import "AppConstants.h"
#import "CustomActivityIndicatorView.h"
//#import "NSObjectJSON.h"

#define	kNoNetworkConnectivityMessage @"No Network Connection. Press Retry to try again or OK to work in offline mode."
#define	kNoNetworkConnectivityHomeMessage @"No Network Connection. Press Retry to try again or Home to return to the home page."

@implementation Lib2ErgoRequestUtils
@synthesize mdata, callurl, showNoNetworkPopup, okButtonTitle, retryButtonTitle;

- (void)dealloc {
	[okButtonTitle release];
	[retryButtonTitle release];
	[callurl release];
	[mdata release];
	[super dealloc];
}

- (void)doRequestForService:(NSString *)service usingCompletionBlock:(RequestCommpletionHandler )block {

//    [self handleNoNetworkCondition];
    showNoNetworkPopup = YES;
    NSString* escapedUrl = [[NSString stringWithFormat:@"%@%@",kEndPointURL, service] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:escapedUrl];
    
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:url] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSError *error;
        id responseData = [NSJSONSerialization
                   JSONObjectWithData:data options:kNilOptions error:&error];
        if (connectionError) {
            block(nil, connectionError);
        }
        else {
            block(responseData, nil);
        }
    }];
}


-(void) handleNoNetworkCondition {
	NSString* sOkBtn = @"OK";
	NSString* sRetryBtn = @"Retry";
	NSString* sMsg = kNoNetworkConnectivityMessage;
	
	if(![CommonUtils isVoid:okButtonTitle]){
		sOkBtn = okButtonTitle;
		sMsg = kNoNetworkConnectivityHomeMessage;
	}
	
	if(![CommonUtils isVoid:retryButtonTitle]){
		sRetryBtn = retryButtonTitle;
	}
	[[UIApplication sharedApplication] endIgnoringInteractionEvents];
	UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Warning" message:sMsg delegate:self cancelButtonTitle:sOkBtn otherButtonTitles:sRetryBtn, nil];
	[alertView show];
	[alertView release];
}

//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
//	if(buttonIndex == 1){
//		[self doRequestForUrl:self.callurl withDelegate:self.delegate noNetworkPopupRequired:YES];
//	}else if(buttonIndex == 0) {
//		if(delegate != nil && [delegate respondsToSelector:@selector(handleOKButtonAction)]) {
//			[delegate handleOKButtonAction];
//		}
//	}
//}



@end
