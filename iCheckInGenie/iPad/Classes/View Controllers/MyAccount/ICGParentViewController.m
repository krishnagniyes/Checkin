//
//  ICGParentViewController.m
//  iCheckInGenie
//
//  Created by Krishna on 21/02/14.
//  Copyright (c) 2014 Gniyes Inc... All rights reserved.
//

#import "ICGParentViewController.h"

@interface ICGParentViewController ()<UITabBarDelegate>
@property (weak, nonatomic) IBOutlet UITabBar *optionsTabBar;

@end

@implementation ICGParentViewController

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
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tree"]];
    self.navigationItem.rightBarButtonItems = @[[self homeButton:@"home.png"], [self addAttendeeButton:@"addAttendee.png"]];


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
    
    [checkInButton addTarget:self action:@selector(homeAction:) forControlEvents:UIControlEventTouchUpInside];
    
    const CGFloat BarButtonOffset = 5.0f;
    [checkInButton setFrame:CGRectMake(BarButtonOffset, 0, checkInImage.size.width, checkInImage.size.height)];
    
    UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, checkInImage.size.width, checkInImage.size.height)];
    [containerView addSubview:checkInButton];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:containerView];
    return item;
}

- (UIBarButtonItem *)addAttendeeButton:(NSString *)imagename {
    
    UIImage *checkInImage = nil;
    UIButton *checkInButton = nil;
    checkInImage = [UIImage imageNamed:imagename];
    checkInButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [checkInButton setBackgroundImage:checkInImage forState:UIControlStateNormal];
    
    [checkInButton addTarget:self action:@selector(addAttendeeAction:) forControlEvents:UIControlEventTouchUpInside];
    
    const CGFloat BarButtonOffset = 5.0f;
    [checkInButton setFrame:CGRectMake(BarButtonOffset, 0, checkInImage.size.width, checkInImage.size.height)];
    
    UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, checkInImage.size.width, checkInImage.size.height)];
    [containerView addSubview:checkInButton];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:containerView];
    return item;
}

- (void)homeAction:(id) sender
{
    NSLog(@"Home");
}

- (void)addAttendeeAction:(id) sender
{
    NSLog(@"addAttendeeAction");
}

#pragma -
#pragma UItabbar delegate
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    NSLog(@"didSelectItem: %d", item.tag);
}


@end
