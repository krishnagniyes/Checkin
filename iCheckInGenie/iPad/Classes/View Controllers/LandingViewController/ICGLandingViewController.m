//
//  ICGLandingViewController.m
//  iCheckInGenie
//
//  Created by Krishna on 12/02/14.
//  Copyright (c) 2014 Gniyes Inc.. All rights reserved.
//

#import "ICGLandingViewController.h"
#import "ICGLoginViewController.h"
#import "AFAppDotNetAPIClient.h"
@import QuartzCore;

@interface ICGLandingViewController ()
{
    NSArray *_landingOptionsArray;
}
@property (weak, nonatomic) IBOutlet UITableView *landingTableView;

@end

@implementation ICGLandingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.navigationController popToRootViewControllerAnimated:NO];
}
- (void)viewDidLoad
{
    [super viewDidLoad];

    self.landingTableView.layer.cornerRadius = 7.0;
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tree"]];

    ///Settingup Options
    _landingTableView.contentInset = UIEdgeInsetsZero;

    NSDictionary *option1 = @{ @"title" : @"Organizer Login", @"subtitle" : @"Click here to Login as an Event Organizer"};
    NSDictionary *option2 = @{ @"title" : @"Have an Event Code?", @"subtitle" : @"Click here to Enter Event Code"};
    NSDictionary *option3 = @{ @"title" : @"Have a Attendee Confirmation Code?", @"subtitle" : @"Click here to PRECHECKIN using Confirmation Code"};
    NSDictionary *option4 = @{ @"title" : @"Would you like to submit your CE credits?", @"subtitle" : @"Click here to View Sessions and Submit CE Credits"};
    NSDictionary *option5 = @{ @"title" : @"Exhibitor Lead Retreival Login", @"subtitle" : @"Click here to Enter your Exhibitor Activation Code"};
    _landingOptionsArray = @[ option1, option2, option3, option4, option5 ];
    
	// Do any additional setup after loading the view.
    
//    https://api.parse.com/1/classes/Holiday
//    https://api.parse.com/1/classes/Holiday
    [[ICGAPIClient sharedClient] GET:@"https://api.parse.com/1/classes/AttendeeDetail?" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSLog(@"DESC = %@", [responseObject description]);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {

    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View Data Source Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_landingOptionsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"LandingCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if ( cell == nil ) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    NSDictionary *dict = [_landingOptionsArray objectAtIndex:indexPath.row];
    
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        cell.textLabel.font = [UIFont systemFontOfSize:25];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:25];
    }
    else {
        cell.textLabel.font = [UIFont systemFontOfSize:12];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
    }


    NSMutableParagraphStyle* linkTitle = [[NSMutableParagraphStyle alloc] init];
    linkTitle.alignment = NSTextAlignmentLeft;
    
    NSAttributedString* attrStr = [[NSAttributedString alloc] initWithString:[dict objectForKey:@"subtitle"] attributes:
                                   @{NSUnderlineStyleAttributeName:@(NSUnderlineStyleSingle),
                                     NSParagraphStyleAttributeName:linkTitle}];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.detailTextLabel.numberOfLines = 2;
    cell.textLabel.text = [dict objectForKey:@"title"];
    cell.detailTextLabel.attributedText = attrStr;
    cell.detailTextLabel.textColor = [UIColor blueColor];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;

    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        return 70.0;
    }
    else {
        return 44.0;
    }
}

#pragma mark - table view delegate methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(0 == indexPath.row)
        [self performSegueWithIdentifier:@"Organizer Login" sender:self];
    else if(1 == indexPath.row)
        [self performSegueWithIdentifier:@"LoginViaEventCode" sender:self];
    else if(2 == indexPath.row)
        [self performSegueWithIdentifier:@"LoginViaAttendeeConfirmationCode" sender:self];
    else if(3 == indexPath.row)
        [self performSegueWithIdentifier:@"CECredit" sender:self];
    else if(4 == indexPath.row)
        [self performSegueWithIdentifier:@"Exhibitor Lead Retreival Login" sender:self];
}

#pragma mark -
#pragma PrepareSeague for specific controller
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"VALUE = %@", segue.identifier);
    if ([segue.identifier isEqualToString:@"Organizer Login"]) {
        ICGLoginViewController *loginVC = segue.destinationViewController
        ;        loginVC.navTitle = @"Organizer Login";
    }else if ([segue.identifier isEqualToString:@"LoginViaEventCode"]) {
        }
    else if ([segue.identifier isEqualToString:@"LoginViaAttendeeConfirmationCode"]) {
    }
    else if ([segue.identifier isEqualToString:@"CECredit"]) {
    }
    else if ([segue.identifier isEqualToString:@"Exhibitor Lead Retreival Login"]) {
    }
}


@end
