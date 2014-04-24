//
//  ICGLoginOptionsViewController.m
//  iCheckInGenie
//
//  Created by Krishna on 10/04/14.
//  Copyright (c) 2014 Gniyes. All rights reserved.
//

#import "ICGLoginOptionsViewController.h"
#import "ICGLoginViewController.h"
@interface ICGLoginOptionsViewController ()
{
    NSArray *_landingOptionsArray;
}
@property (weak, nonatomic) IBOutlet UITableView *loginOptionsTableView;

@end

@implementation ICGLoginOptionsViewController

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
    [self.loginOptionsTableView setBackgroundColor:[UIColor clearColor]];
    [self.loginOptionsTableView reloadData];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
//    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tree"]];
    
    self.navigationItem.rightBarButtonItem.enabled = YES;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.view.backgroundColor = [UIColor clearColor];

    
    ///Settingup Options
    _loginOptionsTableView.contentInset = UIEdgeInsetsZero;
    
    NSDictionary *option1 = @{ @"title" : @"Organizer Login", @"subtitle" : @"Click here to Login as an Event Organizer"};
    NSDictionary *option2 = @{ @"title" : @"Have an Event Code?", @"subtitle" : @"Click here to Enter Event Code"};
    NSDictionary *option3 = @{ @"title" : @"Have a Attendee Confirmation Code?", @"subtitle" : @"Click here to PRECHECKIN using Confirmation Code"};
    NSDictionary *option4 = @{ @"title" : @"Would you like to submit your CE credits?", @"subtitle" : @"Click here to View Sessions and Submit CE Credits"};
    NSDictionary *option5 = @{ @"title" : @"Exhibitor Lead Retreival Login", @"subtitle" : @"Click here to Enter your Exhibitor Activation Code"};
    
    NSLog(@"Title Option = %@", self.optionTitle);
    if([self.optionTitle isEqualToString:@"Organizer"]){
        _landingOptionsArray = @[ option1, option2];
    }else if([self.optionTitle isEqualToString:@"Attendee"])
    {
        _landingOptionsArray = @[ option3, option4];
    }else
    {
        _landingOptionsArray = @[option5];
    }
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
    NSLog(@"sections = %d", [_landingOptionsArray count]);
    return [_landingOptionsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"OptionsCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if ( cell == nil ) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    NSDictionary *dict = [_landingOptionsArray objectAtIndex:indexPath.section];
    
    
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
    cell.detailTextLabel.textColor = [UIColor grayColor];
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

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(tintColor)]) {
        if (tableView == self.loginOptionsTableView) {
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
    
    if([self.optionTitle isEqualToString:@"Organizer"]){
        if(0 == indexPath.section)
            [self performSegueWithIdentifier:@"Organizer Login" sender:self];
        else if(1 == indexPath.section)
            [self performSegueWithIdentifier:@"LoginViaEventCode" sender:self];

    }else if([self.optionTitle isEqualToString:@"Attendee"])
    {
        if(0 == indexPath.section)
            [self performSegueWithIdentifier:@"LoginViaAttendeeConfirmationCode" sender:self];
        else if(1 == indexPath.section)
            [self performSegueWithIdentifier:@"CECredit" sender:self];
    }else
    {
        if(0 == indexPath.section)
            [self performSegueWithIdentifier:@"Exhibitor Lead Retreival Login" sender:self];
    }

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
