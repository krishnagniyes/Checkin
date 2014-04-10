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
    NSArray *_optionsArray;
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

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.landingTableView setBackgroundColor:[UIColor clearColor]];
    //    [self.view setBackgroundColor:[UIColor lightGrayColor]];
    [self.landingTableView reloadData];
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.navigationController popToRootViewControllerAnimated:NO];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

//    self.landingTableView.layer.cornerRadius = 7.0;
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tree"]];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
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
//    [[ICGAPIClient sharedClient] GET:@"https://api.parse.com/1/classes/AttendeeDetail?" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
//        
//        NSLog(@"DESC = %@", [responseObject description]);
//        
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//
//    }];
    
    
    _optionsArray = @[@"Organizer", @"Attendee", @"Exhibitor"];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View Data Source Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    NSLog(@"sections = %d", [_optionsArray count]);
//    return [_optionsArray count];
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"LandingCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if ( cell == nil ) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
//    NSDictionary *dict = [_landingOptionsArray objectAtIndex:indexPath.row];
    
    
//    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
//        cell.textLabel.font = [UIFont systemFontOfSize:25];
//        cell.detailTextLabel.font = [UIFont systemFontOfSize:25];
//    }
//    else {
//        cell.textLabel.font = [UIFont systemFontOfSize:12];
//        cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
//    }


    NSMutableParagraphStyle* linkTitle = [[NSMutableParagraphStyle alloc] init];
    linkTitle.alignment = NSTextAlignmentLeft;
    
//    NSAttributedString* attrStr = [[NSAttributedString alloc] initWithString:[dict objectForKey:@"subtitle"] attributes:
//                                   @{NSUnderlineStyleAttributeName:@(NSUnderlineStyleSingle),
//                                     NSParagraphStyleAttributeName:linkTitle}];
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
//    cell.detailTextLabel.numberOfLines = 2;
    cell.textLabel.text = [_optionsArray objectAtIndex:indexPath.section];
//    cell.detailTextLabel.attributedText = attrStr;
    cell.detailTextLabel.textColor = [UIColor blueColor];
    cell.textLabel.textAlignment = NSTextAlignmentLeft;

    
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

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(tintColor)]) {
        if (tableView == self.landingTableView) {
            CGFloat cornerRadius = 5.f;
            cell.backgroundColor = UIColor.clearColor;
            CAShapeLayer *layer = [[CAShapeLayer alloc] init];
            CGMutablePathRef pathRef = CGPathCreateMutable();
            CGRect bounds = CGRectInset(cell.bounds, 10, 0);
            BOOL addLine = NO;
            if (indexPath.row == 0 && indexPath.row == [tableView numberOfRowsInSection:indexPath.section] - 1) {
                CGPathAddRoundedRect(pathRef, nil, bounds, cornerRadius, cornerRadius);
            } else if (indexPath.row == 0) {
                CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds));
                CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds), CGRectGetMidX(bounds), CGRectGetMinY(bounds), cornerRadius);
                CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
                CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds));
                addLine = YES;
            } else if (indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1) {
                CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds));
                CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds), CGRectGetMidX(bounds), CGRectGetMaxY(bounds), cornerRadius);
                CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
                CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds));
            } else {
                CGPathAddRect(pathRef, nil, bounds);
                addLine = YES;
            }
            layer.path = pathRef;
            CFRelease(pathRef);
            layer.fillColor = [UIColor colorWithWhite:1.f alpha:0.8f].CGColor;
            
            if (addLine == YES) {
                CALayer *lineLayer = [[CALayer alloc] init];
                CGFloat lineHeight = (1.f / [UIScreen mainScreen].scale);
                lineLayer.frame = CGRectMake(CGRectGetMinX(bounds)+10, bounds.size.height-lineHeight, bounds.size.width-10, lineHeight);
                lineLayer.backgroundColor = tableView.separatorColor.CGColor;
                [layer addSublayer:lineLayer];
            }
            UIView *testView = [[UIView alloc] initWithFrame:bounds];
            [testView.layer insertSublayer:layer atIndex:0];
            testView.backgroundColor = UIColor.clearColor;
            cell.backgroundView = testView;
        }
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
