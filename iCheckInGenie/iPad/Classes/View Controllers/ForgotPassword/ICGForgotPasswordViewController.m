//
//  ICGForgotPasswordViewController.m
//  iCheckInGenie
//
//  Created by Krishna on 20/02/14.
//  Copyright (c) 2014 Gniyes Inc... All rights reserved.
//

#import "ICGForgotPasswordViewController.h"
#define keyBoardMovementDistance 120
#define keyBoardMovementDuration 0.3f

@interface ICGForgotPasswordViewController ()

@property (weak, nonatomic) IBOutlet UILabel *titileLabel;
@property (weak, nonatomic) IBOutlet UITextField *usernameTf;
@property (weak, nonatomic) IBOutlet UIButton *forgotButton;

@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@end

@implementation ICGForgotPasswordViewController

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
    
    if(!_isForgotPassword){
        [[self.toolBar.items objectAtIndex:0] setTitle:@"Forgot Username?"];
        [self.titileLabel setText:@"Please Enter Email Address below:"];
        self.usernameTf.placeholder = @"Enter Email Address";
        self.usernameTf.keyboardType = UIKeyboardTypeEmailAddress;
        [self.forgotButton setTitle:@"Forgot Password" forState:UIControlStateNormal];
    }
    else{
        [[self.toolBar.items objectAtIndex:0] setTitle:@"Forgot Password?"];
        [self.titileLabel setText:@"Please Enter your Username below:"];
        self.usernameTf.placeholder = @"Enter your Username";
        [self.forgotButton setTitle:@"Forgot Username" forState:UIControlStateNormal];
    }

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
    if ([_usernameTf isFirstResponder] && [touch view] != _usernameTf)
    {
        [_usernameTf resignFirstResponder];
    }
    if ([_usernameTf isFirstResponder] )
    {
        [_usernameTf resignFirstResponder];
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
    if(textField == self.usernameTf)
    {
        [self.usernameTf resignFirstResponder];
        return YES;
    }
    return YES;
}


- (IBAction)forButtonAction:(id)sender {
    _isForgotPassword = !_isForgotPassword;
    if(!_isForgotPassword){
        [[self.toolBar.items objectAtIndex:0] setTitle:@"Forgot Username?"];
        self.usernameTf.placeholder = @"Enter Email Address";
        [self.titileLabel setText:@"Please Enter Email Address below:"];
        self.usernameTf.keyboardType = UIKeyboardTypeEmailAddress;
        [self.forgotButton setTitle:@"Forgot Password" forState:UIControlStateNormal];
    }
    else{
        [[self.toolBar.items objectAtIndex:0] setTitle:@"Forgot Password?"];
        self.usernameTf.placeholder = @"Enter your Username";

        [self.titileLabel setText:@"Please Enter your Username below:"];
        [self.forgotButton setTitle:@"Forgot Username" forState:UIControlStateNormal];
        
    }
}

- (IBAction)submitButton:(id)sender {
}
@end
