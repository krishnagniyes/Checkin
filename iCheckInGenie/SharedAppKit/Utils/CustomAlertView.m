//
//  CustomAlertView.m
//  iCheckInGenie
//
//  Created by Krishna on 08/03/14.
//  Copyright (c) 2014 Apple. All rights reserved.
//

#import "CustomAlertView.h"

#define ACTIVITY_INDICATOR_CENTER   CGPointMake(130, 90)

@implementation CustomAlertView

- (id)initWithTitle:(NSString *)title andMessage:(NSString *)message
{
    if ( self = [super init] )
    {
        self.title = title;
        self.message = message;
        [self setDelegate:self];
    }
    
    return self;
}


- (id)initCustomAlertWithTitle:(NSString *)title message:(NSString *)message delegate:(id /*<UIAlertViewDelegate>*/)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles
{
    if ( self = [super init] )
    {
        self.title = title;
        self.message = message;
        [self setDelegate:self];
    }

    return self;
}

// You can Customise this based on your requirement by adding subviews.
- (void)didPresentAlertView:(UIAlertView *)alertView
{
    NSArray *subviews = [UIApplication sharedApplication].keyWindow.rootViewController.presentedViewController.view.subviews;
    
    if( subviews.count > 1 )
    {
        // iOS while presenting an alertview uses a presening view controller. That controller's view has several subviews. I have picked one
        // subview from it which has frame similar to the alertview frame.
        UIView *presentedView = [subviews objectAtIndex:1];
        
        UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tree.png"]];
        img.frame = CGRectMake(10, 10, 48, 48);
//        img.center = ACTIVITY_INDICATOR_CENTER;
        
        [presentedView addSubview:img];
    }
}

@end