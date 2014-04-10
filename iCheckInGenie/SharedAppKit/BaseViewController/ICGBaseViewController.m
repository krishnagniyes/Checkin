//
//  ICGBaseViewController.m
//  iCheckInGenie
//
//  Created by Krishna on 12/02/14.
//  Copyright (c) 2014 Gniyes Inc.. All rights reserved.
//

#import "ICGBaseViewController.h"

@interface ICGBaseViewController ()

@end

@implementation ICGBaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        [self.view setBackgroundColor:[UIColor colorWithRed:247.0/255.0 green:247.0/255.0 blue:247.0/255.0 alpha:1.0]];

//        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:kBackgroundColor_iPad]]];
    }
    else {
        [self.view setBackgroundColor:[UIColor colorWithRed:247.0/255.0 green:247.0/255.0 blue:247.0/255.0 alpha:1.0]];

//        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:kBackgroundColor_iPhone]]];
    }

    self.navigationItem.rightBarButtonItem = [self homeButton:@"placeholder_promotions.png"];
//    self.navigationItem.rightBarButtonItems = @[[self homeButton:@"home.png"], [self addAttendeeButton:@"addAttendee.png"]];


	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIBarButtonItem *)homeButton:(NSString *)imagename {
    
    UIImage *checkInImage = nil;
    UIButton *checkInButton = nil;
    checkInImage = [UIImage imageNamed:imagename];
    checkInButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [checkInButton setBackgroundImage:checkInImage forState:UIControlStateNormal];
    
    [checkInButton addTarget:self action:@selector(logoutAction:) forControlEvents:UIControlEventTouchUpInside];
    
    const CGFloat BarButtonOffset = 5.0f;
    [checkInButton setFrame:CGRectMake(BarButtonOffset, 6, 30, 30)];
    
    UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, checkInImage.size.width, checkInImage.size.height)];
    [containerView addSubview:checkInButton];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:containerView];
    return item;
}

- (void)logoutAction:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
