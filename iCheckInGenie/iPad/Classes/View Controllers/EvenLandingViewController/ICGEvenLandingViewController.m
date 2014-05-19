//
//  ICGEvenLandingViewController.m
//  iCheckInGenie
//
//  Created by Krishna on 12/02/14.
//  Copyright (c) 2014 Gniyes Inc.. All rights reserved.
//

#import "ICGEvenLandingViewController.h"
#import "AppConstants.h"
#import "ICGLoginViewController.h"

@interface ICGEvenLandingViewController ()<UITabBarDelegate>
{
    NSArray *_optionsArray;
    NSArray *_optionsImageArray;

    NSUInteger _selectedOption;
}
@property (weak, nonatomic) IBOutlet UITabBar *optionsTabBar;
@property (weak, nonatomic) IBOutlet UIImageView *cellImageView;
@property (weak, nonatomic) IBOutlet UILabel *cellOptionNameLabel;
@property (weak, nonatomic) IBOutlet UITableView *oprionsTableView;
@property (weak, nonatomic) IBOutlet UILabel *eventDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *eventTimeLabel;

@property (weak, nonatomic) IBOutlet UILabel *eventVenueLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalAttendeeLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalAttendeesCheckinLabel;
@property (weak, nonatomic) IBOutlet UILabel *pendingCheckinLabel;



@end

@implementation ICGEvenLandingViewController

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
//    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tree"]];
    
    self.navigationController.title = @"Details";
//    self.oprionsTableView.layer.cornerRadius = 7.0;

    _optionsArray = @[@"CHECK IN ATTENDEES", @"ADD ATTENDEE" , @"SYNC DATABASE", @"SCAN TICKET", @"MY ACCOUNT", @"LOGOUT"];
    
    _optionsImageArray = @[@"Check in Nav button",@"addAttendee",@"Sync Database",@"Scan ticket",@"setting",@"logout"];

    [self.oprionsTableView setBackgroundColor:[UIColor clearColor]];
    self.oprionsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.oprionsTableView reloadData];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table View Data Source Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [_optionsArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;//[_optionsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"OptionsCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if ( cell == nil ) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    UIImageView *imgView = (UIImageView*) [cell viewWithTag:0];
    imgView.image = [UIImage imageNamed:[_optionsImageArray objectAtIndex:indexPath.section]];
    
    UILabel *l =   (UILabel*) [cell viewWithTag:1];
    l.text = [_optionsArray objectAtIndex:indexPath.section];
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

    switch (indexPath.section) {
        case kCheckInOption:
        {
            _selectedOption = 0;
            [self performSegueWithIdentifier:@"PARENTVC" sender:self];
        }
            break;
        case kScanOption:
        {
            _selectedOption = 1;
            [self performSegueWithIdentifier:@"PARENTVC" sender:self];
        }
            break;
        case kSyncOption:
        {
            _selectedOption = 2;
            [self performSegueWithIdentifier:@"PARENTVC" sender:self];
        }
            break;

        case kAddAttendee:
        {
            _selectedOption = 100;
            [self performSegueWithIdentifier:@"ICGAddAttendeeViewController" sender:self];
        }
            break;
            
        case kMyAccountOptions:
        {
            _selectedOption = 1001;

            [self performSegueWithIdentifier:@"MY ACCOUNT" sender:self];
        }
            break;
            
        case kLogoutOption:
        {
            _selectedOption = 3;

            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:kLogoutAlertTitle message:kLogoutMessage delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Logout", nil];
            [alert show];
        }
            break;
        default:
            break;
    }
}


#pragma -
#pragma UItabbar delegate
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    NSLog(@"didSelectItem: %d", item.tag);
}

#pragma mark -
#pragma PrepareSeague for specific controller
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UITabBarController *tabVC = (UITabBarController *) segue.destinationViewController;
    NSLog(@"Index = %d", _selectedOption);
    
    if(_selectedOption < 4){
        tabVC.navigationItem.rightBarButtonItem = [self homeButton:@"menu icon.png"];
        
        [tabVC setSelectedViewController:[tabVC.viewControllers objectAtIndex:_selectedOption]];
    }
}



- (UIBarButtonItem *)homeButton:(NSString *)imagename {
    UIImage *checkInImage = nil;
    UIButton *checkInButton = nil;
    checkInImage = [UIImage imageNamed:imagename];
    checkInButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [checkInButton setBackgroundImage:checkInImage forState:UIControlStateNormal];
    
    [checkInButton addTarget:self action:@selector(presentRightMenuViewController:) forControlEvents:UIControlEventTouchUpInside];
    
    const CGFloat BarButtonOffset = 5.0f;
    [checkInButton setFrame:CGRectMake(BarButtonOffset + 20, 6, 30, 30)];
    
    UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, checkInImage.size.width, checkInImage.size.height)];
    [containerView addSubview:checkInButton];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:containerView];
    return item;
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

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(tintColor)]) {
        if (tableView == self.oprionsTableView) {
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

@end
