//
//  ICGForgotPasswordViewController.h
//  iCheckInGenie
//
//  Created by Krishna on 20/02/14.
//  Copyright (c) 2014 Gniyes Inc... All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ICGBaseViewController.h"

@interface ICGForgotPasswordViewController : ICGBaseViewController
@property (nonatomic, strong) NSDictionary *dataDictionary;
@property (nonatomic, strong) IBOutlet UIToolbar *toolBar;;
@property (assign) BOOL isForgotPassword;
@end
