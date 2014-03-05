//
//  ICGLoginViaEventCodeViewController.m
//  iCheckInGenie
//
//  Created by Krishna on 12/02/14.
//  Copyright (c) 2014 Gniyes Inc.. All rights reserved.
//

#import "ICGLoginViaEventCodeViewController.h"
#define keyBoardMovementDistance 120
#define keyBoardMovementDuration 0.3f

@interface ICGLoginViaEventCodeViewController ()
@property (weak, nonatomic) IBOutlet UITextField *eventCodeTF;

@end

@implementation ICGLoginViaEventCodeViewController

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
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tree"]];

	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)submitEventCodeAction:(id)sender {
}

#pragma mark - resign first responder
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    UITouch *touch = [[event allTouches] anyObject];
    if ([_eventCodeTF isFirstResponder] && [touch view] != _eventCodeTF)
    {
        [_eventCodeTF resignFirstResponder];
    }
    if ([_eventCodeTF isFirstResponder] )
    {
        [_eventCodeTF resignFirstResponder];
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
    if(textField == self.eventCodeTF)
    {
        [self.eventCodeTF resignFirstResponder];
        return YES;
    }
    return YES;
}


@end
