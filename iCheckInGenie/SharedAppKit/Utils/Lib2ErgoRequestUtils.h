//
//  Lib2ErgoRequestUtils.h
//  PizzaExpress
//
// Copyright 2011, 2ergo Limited.

#import <Foundation/Foundation.h>


typedef void (^RequestCommpletionHandler) (id data, NSError *error);


@interface Lib2ErgoRequestUtils : NSObject <UIAlertViewDelegate>{
	NSString* callurl;
	NSMutableData *mdata;
	BOOL showNoNetworkPopup;
	NSString* okButtonTitle;
	NSString* retryButtonTitle;
}

@property (nonatomic, retain) NSString* okButtonTitle;
@property (nonatomic, retain) NSString* retryButtonTitle;
@property (nonatomic, assign) BOOL showNoNetworkPopup;
@property (nonatomic, retain) NSString* callurl;
@property (nonatomic, retain) NSMutableData *mdata;

- (void)doRequestForService:(NSString *)service usingCompletionBlock:(RequestCommpletionHandler )block;


//Async Requests
- (void)doRequestForUrl:(NSString*)url withDelegate:(id)del noNetworkPopupRequired:(BOOL) popup;
- (void) handleNoNetworkCondition;

@end
