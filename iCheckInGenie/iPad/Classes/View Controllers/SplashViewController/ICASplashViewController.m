//
//  ICASplashViewController.m
//  iCheckInGenie
//
//  Created by Krishna on 17/02/14.
//  Copyright (c) 2014 Gniyes Inc... All rights reserved.
//

#import "ICASplashViewController.h"

@interface ICASplashViewController ()

@end

@implementation ICASplashViewController

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
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.x, self.view.frame.size.width, self.view.frame.size.height)];
    imgView.image = [UIImage imageNamed:@"MenuBackground"];
    imgView.contentMode = UIViewContentModeScaleToFill;
    [self.view addSubview:imgView];
    [CommonUtils startActivityIndicatorOnView:self.view withText:@"Loading Configuration"];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [CommonUtils stopActivityIndicatorOnView:self.view];
}

@end
