//
//  ICGLogoutViewController.m
//  iCheckInGenie
//
//  Created by Krishna on 23/02/14.
//  Copyright (c) 2014 Gniyes Inc... All rights reserved.
//

#import "ICGLogoutViewController.h"
#import "ICGLoginViewController.h"
#import "AppConstants.h"
@interface ICGLogoutViewController ()

@end

@implementation ICGLogoutViewController

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
    NSLog(@"In Logout");
	// Do any additional setup after loading the view.
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:kLogoutAlertTitle message:kLogoutMessage delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Logout", nil];
    [alert show];

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma -
#pragma AlertView delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(0 == buttonIndex)
        return;
    else
    {
        [self.navigationController popToRootViewControllerAnimated:YES];

//        for(id VC in [self.navigationController viewControllers])
//        {
//            if([VC isKindOfClass:[ICGLoginViewController class]])
//            {
//                [self.navigationController popToViewController:VC animated:YES];
//                break;
//            }
//        }
    }
}

@end
