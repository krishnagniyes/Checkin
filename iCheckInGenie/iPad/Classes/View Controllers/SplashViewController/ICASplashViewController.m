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
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]];
    [self performSelector:@selector(goToLandingPage)
               withObject:nil
               afterDelay:1.0f];
}

- (void)goToLandingPage{
    
    [self performSegueWithIdentifier:@"landingpage" sender:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
