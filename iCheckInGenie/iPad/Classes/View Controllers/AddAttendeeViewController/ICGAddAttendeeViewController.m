//
//  ICGAddAttendeeViewController.m
//  iCheckInGenie
//
//  Created by Krishna on 12/02/14.
//  Copyright (c) 2014 Gniyes Inc.. All rights reserved.
//

#import "ICGAddAttendeeViewController.h"
#import "AttendeeDetails.h"

#define keyBoardMovementDistance 120
#define keyBoardMovementDuration 0.3f


@interface ICGAddAttendeeViewController ()
{
    __weak IBOutlet UITableView *attendeeTableView;
    UITextField *_textField;
    
}
@property (nonatomic , strong) NSMutableDictionary *attendeeDetailDict;

@property (nonatomic , strong) AttendeeDetails *attendeeObject;

@property (nonatomic, strong)   NSMutableArray *detailFieldArray;

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
    

    self.attendeeObject = self.attendeeDetail;
    
    
    self.tabBarController.hidesBottomBarWhenPushed = NO;
    attendeeTableView.layer.cornerRadius = 7.0;

    _attendeeDetailDict = [[NSMutableDictionary alloc] init];
    
    
    if(self.attendeeDetail == nil) {
        
        self.detailFieldArray = [[NSMutableArray alloc] initWithObjects:@"Confirmation Code", @"First Name", @"Last Name", @"Package", @"Additional Guests", @"Email", @"Phone", @"City",@"State", @"Table Numbers", @"Attendee Type", nil];
        for (NSString *str in self.detailFieldArray) {
            [_attendeeDetailDict setObject:@" " forKey:str];
        }
    }
    else {
        self.detailFieldArray = [[NSMutableArray alloc] initWithObjects:@"Confirmation Code", @"First Name", @"Last Name", @"Package", @"Additional Guests", @"Email", @"Phone", @"City",@"State", @"Table Numbers", @"Attendee Type", nil];

    
    if ([_attendeeObject Custm_Fld_1_Lbl_Txt] != nil &&  ![[_attendeeObject Custm_Fld_1_Lbl_Txt] isKindOfClass:[NSNull class]]) {
        [self.detailFieldArray addObject:[_attendeeObject Custm_Fld_1_Lbl_Txt]];
        [_attendeeDetailDict setObject:[_attendeeObject Custm_Fld_1_Val_Txt] forKey:[_attendeeObject Custm_Fld_1_Lbl_Txt]];
    }
     if ([_attendeeObject Custm_Fld_2_Lbl_Txt] != nil &&  ![[_attendeeObject Custm_Fld_2_Lbl_Txt] isKindOfClass:[NSNull class]]) {
         [self.detailFieldArray addObject:[_attendeeObject Custm_Fld_2_Lbl_Txt]];
        [_attendeeDetailDict setObject:[_attendeeObject Custm_Fld_2_Val_Txt] forKey:[_attendeeObject Custm_Fld_2_Lbl_Txt]];
    }
    
    if ([_attendeeObject Custm_Fld_3_Lbl_Txt] != nil &&  ![[_attendeeObject Custm_Fld_3_Lbl_Txt] isKindOfClass:[NSNull class]]) {
        
        [self.detailFieldArray addObject:[_attendeeObject Custm_Fld_3_Lbl_Txt]];
        [_attendeeDetailDict setObject:[_attendeeObject Custm_Fld_3_Val_Txt] forKey:[_attendeeObject Custm_Fld_3_Lbl_Txt]];
    }
    
    if ([_attendeeObject Custm_Fld_4_Lbl_Txt] != nil &&  ![[_attendeeObject Custm_Fld_4_Lbl_Txt] isKindOfClass:[NSNull class]]) {
        [self.detailFieldArray addObject:[_attendeeObject Custm_Fld_4_Lbl_Txt]];
        [_attendeeDetailDict setObject:[_attendeeObject Custm_Fld_4_Val_Txt] forKey:[_attendeeObject Custm_Fld_4_Lbl_Txt]];
    }
    if ([_attendeeObject Custm_Fld_5_Lbl_Txt] != nil &&  ![[_attendeeObject Custm_Fld_5_Lbl_Txt] isKindOfClass:[NSNull class]]) {
        [self.detailFieldArray addObject:[_attendeeObject Custm_Fld_5_Lbl_Txt]];
        [_attendeeDetailDict setObject:[_attendeeObject Custm_Fld_5_Val_Txt] forKey:[_attendeeObject Custm_Fld_5_Lbl_Txt]];
    }
    if ([_attendeeObject Custm_Fld_6_Lbl_Txt] != nil &&  ![[_attendeeObject Custm_Fld_6_Lbl_Txt] isKindOfClass:[NSNull class]]) {
        [self.detailFieldArray addObject:[_attendeeObject Custm_Fld_6_Lbl_Txt]];
        [_attendeeDetailDict setObject:[_attendeeObject Custm_Fld_6_Val_Txt] forKey:[_attendeeObject Custm_Fld_6_Lbl_Txt]];
    }
    
    if ([_attendeeObject Custm_Fld_7_Lbl_Txt] != nil &&  ![[_attendeeObject Custm_Fld_7_Lbl_Txt] isKindOfClass:[NSNull class]]) {
        [self.detailFieldArray addObject:[_attendeeObject Custm_Fld_7_Lbl_Txt]];
        [_attendeeDetailDict setObject:[_attendeeObject Custm_Fld_7_Val_Txt] forKey:[_attendeeObject Custm_Fld_7_Lbl_Txt]];
    }
    if ([_attendeeObject Custm_Fld_8_Lbl_Txt] != nil &&  ![[_attendeeObject Custm_Fld_8_Lbl_Txt] isKindOfClass:[NSNull class]]) {
        [self.detailFieldArray addObject:[_attendeeObject Custm_Fld_8_Lbl_Txt]];
        [_attendeeDetailDict setObject:[_attendeeObject Custm_Fld_8_Val_Txt] forKey:[_attendeeObject Custm_Fld_8_Lbl_Txt]];
    }
    if ([_attendeeObject Custm_Fld_9_Lbl_Txt] != nil &&  ![[_attendeeObject Custm_Fld_9_Lbl_Txt] isKindOfClass:[NSNull class]]) {
        [self.detailFieldArray addObject:[_attendeeObject Custm_Fld_9_Lbl_Txt]];
        [_attendeeDetailDict setObject:[_attendeeObject Custm_Fld_9_Val_Txt] forKey:[_attendeeObject Custm_Fld_9_Lbl_Txt]];
    }
    
    if ([_attendeeObject Custm_Fld_10_Lbl_Txt] != nil &&  ![[_attendeeObject Custm_Fld_10_Lbl_Txt] isKindOfClass:[NSNull class]]) {
        [self.detailFieldArray addObject:[_attendeeObject Custm_Fld_10_Lbl_Txt]];
        [_attendeeDetailDict setObject:[_attendeeObject Custm_Fld_10_Val_Txt] forKey:[_attendeeObject Custm_Fld_10_Lbl_Txt]];
    }
    
    [_attendeeDetailDict setObject:[_attendeeObject Cnfrm_Cd]  forKey:@"Confirmation Code"];
    [_attendeeDetailDict setObject:[_attendeeObject Fst_Nm] forKey:@"First Name"];
    [_attendeeDetailDict setObject:[_attendeeObject Last_Nm] forKey:@"Last Name"];
    [_attendeeDetailDict setObject:@"Package_Temp" forKey:@"Package"];
    [_attendeeDetailDict setObject:[[_attendeeObject Additional_Guests] stringValue] forKey:@"Additional Guests"];
    [_attendeeDetailDict setObject:[_attendeeObject Eml_Addr_Txt] forKey:@"Email"];

    if ([_attendeeObject Phn_Num] != nil) {
        [_attendeeDetailDict setObject:[_attendeeObject Phn_Num]  forKey:@"Phone"];
    }
    else {
        [_attendeeDetailDict setObject:@"027531267098019"  forKey:@"Phone"];
        
    }
    [_attendeeDetailDict setObject:[_attendeeObject City_Txt] forKey:@"City"];

    [_attendeeDetailDict setObject:[_attendeeObject St_Cd] forKey:@"State"];
    [_attendeeDetailDict setObject:@"Table Number" forKey:@"Table Numbers"];

    [_attendeeDetailDict setObject:@"Attendee_type" forKey:@"Attendee Type"];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table View Data Source Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.detailFieldArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"AddAttendeeCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if(![[self.detailFieldArray objectAtIndex:indexPath.row] isKindOfClass:[NSNumber class]]) {
        [(UILabel *) [cell viewWithTag:1] setText:[self.detailFieldArray objectAtIndex:indexPath.row]];
    }
    
    
    if ([[self.attendeeDetailDict objectForKey:[self.detailFieldArray objectAtIndex:indexPath.row] ] isKindOfClass:[NSNumber class]]) {
        
        [(UILabel *) [cell viewWithTag:2] setText:[self.attendeeDetailDict objectForKey:[[self.detailFieldArray objectAtIndex:indexPath.row] stringValue]]];
    }
    else if ([[self.attendeeDetailDict objectForKey:[self.detailFieldArray objectAtIndex:indexPath.row]] isKindOfClass:[NSNull class]]) {
        [(UILabel *) [cell viewWithTag:2] setText:@"No Data"];
    }
    else {
        [(UILabel *) [cell viewWithTag:2] setText:[self.attendeeDetailDict objectForKey:[self.detailFieldArray objectAtIndex:indexPath.row] ]];
    }
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
    
    
    if ([[self.detailFieldArray objectAtIndex:selectedIndexPath.row] isKindOfClass:[NSNumber class]]) {
        [_attendeeDetailDict setObject:textField.text forKey:[[self.detailFieldArray objectAtIndex:selectedIndexPath.row] stringValue]];
    }
    else if ([[self.detailFieldArray objectAtIndex:selectedIndexPath.row] isKindOfClass:[NSNull class]]) {
        [_attendeeDetailDict setObject:textField.text forKey:@"Data Not present"];
    }
    else {
        [_attendeeDetailDict setObject:textField.text forKey:[self.detailFieldArray objectAtIndex:selectedIndexPath.row]];
    }
}

#pragma mark - Capture Go of keyboard for login

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    return YES;
}

@end
