//
//  ICGSyncViewController.m
//  iCheckInGenie
//
//  Created by Krishna on 12/02/14.
//  Copyright (c) 2014 Gniyes Inc.. All rights reserved.
//

#import "ICGSyncViewController.h"

@interface ICGSyncViewController ()
@property (weak, nonatomic) IBOutlet UILabel *lastSyncTimeStamp;

@end

@implementation ICGSyncViewController

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
    self.navigationController.title = @"SYNC";
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"LLL d yyyy HH:mm:ss"];
    _lastSyncTimeStamp.text = [dateFormat stringFromDate:[NSDate date]];
    [self.tabBarController setSelectedViewController:[self.tabBarController.viewControllers objectAtIndex:1]];

	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)syncAction:(id)sender {
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"LLL d yyyy HH:mm:ss"];
    _lastSyncTimeStamp.text = [dateFormat stringFromDate:[NSDate date]];
}

@end
