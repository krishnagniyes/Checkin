//
//  ICGAddAttendeeViewController.m
//  iCheckInGenie
//
//  Created by Krishna on 12/02/14.
//  Copyright (c) 2014 Gniyes Inc.. All rights reserved.
//

#import "ICGAddAttendeeViewController.h"
#define keyBoardMovementDistance 120
#define keyBoardMovementDuration 0.3f


@interface ICGAddAttendeeViewController ()
{
    NSMutableArray *_detailFieldArray;
    __weak IBOutlet UITableView *attendeeTableView;
    UITextField *_textField;
}
@property (nonatomic , strong) NSMutableDictionary *attendeeDetailDict;
@end

@implementation ICGAddAttendeeViewController

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
    self.tabBarController.hidesBottomBarWhenPushed = NO;
    attendeeTableView.layer.cornerRadius = 7.0;

    _attendeeDetailDict = [[NSMutableDictionary alloc] init];
    _detailFieldArray = (NSMutableArray *) @[@"Confirmation Code", @"First Name", @"Last Name", @"Package", @"Additional Guests", @"Email", @"Phone", @"City",@"State", @"Table Numbers", @"Attendee Type",@"Custom Field 1",@"Custom Field 2"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table View Data Source Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_detailFieldArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"AddAttendeeCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [(UILabel *) [cell viewWithTag:1] setText:[_detailFieldArray objectAtIndex:indexPath.row]];
    return cell;
}

#pragma mark - table view delegate methods


-(IBAction)cancelDetailView:(id)sender{
    NSLog(@"Cancelled");
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)saveDetailView:(id)sender{
    
    [_textField resignFirstResponder];
    NSLog(@"Saved Data = %@", [_attendeeDetailDict description]);
    [self.navigationController popViewControllerAnimated:YES];

}

- (IBAction)checkInAction:(id)sender {
    NSLog(@"Checked In");

}
- (IBAction)eMailAction:(id)sender {
    NSLog(@"Email");

}
- (IBAction)SMSAction:(id)sender {
    NSLog(@"SMS");
}
#pragma mark - resign first responder
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [_textField resignFirstResponder];
}

#pragma mark - Moving the screen up For Keyboard
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    _textField = textField;
    [CommonUtils startShrinkAnimationForTextField:textField andTable:attendeeTableView];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [CommonUtils startExpandAnimationForTextField:textField andTable:attendeeTableView];
    UITableViewCell *cell = (UITableViewCell *) textField.superview.superview.superview;
    NSIndexPath *selectedIndexPath = [attendeeTableView indexPathForCell:cell];
    [_attendeeDetailDict setObject:textField.text forKey:[_detailFieldArray objectAtIndex:selectedIndexPath.row]];
}

#pragma mark - Capture Go of keyboard for login

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    return YES;
}

@end
