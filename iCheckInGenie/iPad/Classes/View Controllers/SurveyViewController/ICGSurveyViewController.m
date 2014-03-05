//
//  ICGSurveyViewController.m
//  iCheckInGenie
//
//  Created by Krishna on 17/02/14.
//  Copyright (c) 2014 Gniyes Inc... All rights reserved.
//

#import "ICGSurveyViewController.h"

@interface ICGSurveyViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation ICGSurveyViewController

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
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://bv7dto.axshare.com/"]];
    [_webView loadRequest:request];}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
