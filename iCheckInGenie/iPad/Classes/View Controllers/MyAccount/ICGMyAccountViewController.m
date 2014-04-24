//
//  ICGMyAccountViewController.m
//  iCheckInGenie
//
//  Created by Krishna on 21/02/14.
//  Copyright (c) 2014 Gniyes Inc... All rights reserved.
//

#import "ICGMyAccountViewController.h"

@interface ICGMyAccountViewController ()
{
    NSArray* _optionsArray;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation ICGMyAccountViewController

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
    _optionsArray = @[@"Notifications", @"Alerts", @"Vibrate on CheckIn"];
//    self.tableView.layer.cornerRadius = 7.0;
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView setBackgroundColor:[UIColor clearColor]];
//    [self.view setBackgroundColor:[UIColor lightGrayColor]];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
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


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case kPICell:
            return 1;
            break;
        case kNotificationCell:
            return 3;
            break;
        case kAboutCell:
            return 1;
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    switch (indexPath.section) {
        case kPICell:
            cell = [tableView dequeueReusableCellWithIdentifier:@"PI"];
            cell.textLabel.text = @"Personal Information";
            return cell;
            break;
        case kNotificationCell:{
            cell = [tableView dequeueReusableCellWithIdentifier:@"NOTIFICATIONS"];
            [(UILabel *) [cell viewWithTag:100] setText:[_optionsArray objectAtIndex:indexPath.row]];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
            return cell;
            break;
        case kAboutCell:
            cell = [tableView dequeueReusableCellWithIdentifier:@"About"];
            cell.textLabel.text = @"About iCheckinGenie";
            return cell;
            break;
    }
    return nil;
}

- (IBAction)updateSwitch:(id)sender
{
    UISwitch * switchView = (UISwitch*) sender;
    UITableViewCell *cell = (UITableViewCell *) switchView.superview.superview.superview;
    NSIndexPath *selectedIndexPath = [self.tableView indexPathForCell:cell];
    
    NSLog(@"ROW = %d", selectedIndexPath.row);

    if ([switchView isOn]) {
        [switchView setOn:NO animated:NO];
    } else {
        [switchView setOn:YES animated:NO];
    }
}
#pragma mark - table view delegate methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
        [self performSegueWithIdentifier:@"PI" sender:self];
    if(indexPath.section == 2)
        [self performSegueWithIdentifier:@"ABOUT" sender:self];
    if(indexPath.section == 1)
    {
//        [self updateSwitchAtIndexPath:indexPath];
    }

}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(tintColor)]) {
        if (tableView == self.tableView) {
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
#pragma mark -
#pragma PrepareSeague for specific controller

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
}
@end
