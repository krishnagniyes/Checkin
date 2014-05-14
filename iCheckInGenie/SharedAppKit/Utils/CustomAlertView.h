//
//  CustomAlertView.h
//  iCheckInGenie
//
//  Created by Krishna on 08/03/14.
//  Copyright (c) 2014 Gniyes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomAlertView : UIAlertView

- (id)initWithTitle:(NSString *)title andMessage:(NSString *)message;

- (id)initCustomAlertWithTitle:(NSString *)title message:(NSString *)message delegate:(id /*<UIAlertViewDelegate>*/)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles;


@end
