//
//  ICGPreCheckinViewController.m
//  iCheckInGenie
//
//  Created by Krishna on 12/02/14.
//  Copyright (c) 2014 Gniyes Inc.. All rights reserved.
//

#import "ICGPreCheckinViewController.h"
#define keyBoardMovementDistance 120
#define keyBoardMovementDuration 0.3f

#define kInvalidConfirmationCodeMessage @"The Confirmation Code your entered is invalid. Please try another Confirmation Code.If you are unable to find your Confirmation Code please contact your event administrator."

@interface ICGPreCheckinViewController ()
@property (weak, nonatomic) IBOutlet UITextField *confirmationCodeTF;

@end

@implementation ICGPreCheckinViewController

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

	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - resign first responder
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    UITouch *touch = [[event allTouches] anyObject];
    if ([_confirmationCodeTF isFirstResponder] && [touch view] != _confirmationCodeTF)
    {
        [_confirmationCodeTF resignFirstResponder];
    }
    if ([_confirmationCodeTF isFirstResponder] )
    {
        [_confirmationCodeTF resignFirstResponder];
    }
    
}

#pragma mark - Moving the screen up For Keyboard
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self animateTextField: textField up: YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self animateTextField: textField up: NO];
}

- (void) animateTextField: (UITextField*) textField up: (BOOL) up
{
    const int movementDistance = keyBoardMovementDistance; // tweak as needed
    const float movementDuration = keyBoardMovementDuration; // tweak as needed
    
    int movement = (up ? -movementDistance : movementDistance);
    
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}

#pragma mark - Capture Go of keyboard for login

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    if(textField == self.confirmationCodeTF)
    {
        [self.confirmationCodeTF resignFirstResponder];
        return YES;
    }
    return YES;
}



- (IBAction)submitAction:(id)sender {
    
    [CommonUtils showSimpleAlertWithTitle:nil andMessage:kInvalidConfirmationCodeMessage];
}

@end
