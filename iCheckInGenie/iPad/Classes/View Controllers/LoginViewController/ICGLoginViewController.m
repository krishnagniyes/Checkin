//
//  ICGLoginViewController.m
//  iCheckInGenie
//
//  Created by Krishna on 12/02/14.
//  Copyright (c) 2014 Gniyes Inc.. All rights reserved.
//

#import "ICGLoginViewController.h"
#import "ICGForgotPasswordViewController.h"
#import "ICGDataManager.h"

#define keyBoardMovementDistance 120
#define keyBoardMovementDuration 0.3f

@interface ICGLoginViewController ()
{
    BOOL _isForgotPassword;
}
@property (weak, nonatomic) IBOutlet UITextField *usernameTF;

@property (weak, nonatomic) IBOutlet UITextField *userPasswordTF;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *forgotUsernameButton;
@end

@implementation ICGLoginViewController

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
//    self.title = _navTitle;
//    self.navigationController.navigationBarHidden = YES;
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
    if ([_usernameTF isFirstResponder] && [touch view] != _usernameTF)
    {
        [_usernameTF resignFirstResponder];
    }
    if ([_userPasswordTF isFirstResponder] && [touch view] != _userPasswordTF)
    {
        [_userPasswordTF resignFirstResponder];
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
    if(textField == self.usernameTF)
    {
        [self.usernameTF resignFirstResponder];
        [self.userPasswordTF becomeFirstResponder];
        return YES;
    }
    else if(textField == self.userPasswordTF)
    {
        [textField resignFirstResponder];
        
    }
    return YES;
}


- (IBAction)loginAction:(id)sender {
    
    
//    DeviceID=5654&Username=Aditya&password=aditya123
    
    Lib2ErgoRequestUtils *util = [[Lib2ErgoRequestUtils alloc] init];
    
    if ([self.usernameTF.text length] == 0 || [self.userPasswordTF.text length] == 0) {
    
        [CommonUtils showSimpleAlertWithTitle:@"" andMessage:@"Username & and password can not be left empty"];
        return;
    }
    else {
        
        [CommonUtils startActivityIndicatorOnView:self.view withText:@"Authenticating..."];
        NSString *service = [NSString stringWithFormat:@"%@DeviceID=%@&Username=%@&password=%@",kServiceLogin,kUniqueDeviceID,
                             self.usernameTF.text,self.userPasswordTF.text];
        [util doRequestForService:service usingCompletionBlock:^(id data, NSError *error) {
        [[ICGDataManager defaultManager] parseDataForLogin:data];
            
            if (data != nil) {
                NSDictionary *dict = (NSDictionary *)data;
                if([[dict allKeys] containsObject:@"Result"])
                {
                    [CommonUtils showSimpleAlertWithTitle:@"Login Failed" andMessage:@"Username or password was entered incorrectly!"];
                    [CommonUtils stopActivityIndicatorOnView:self.view];
                }
                else {
                    [self performSegueWithIdentifier:@"eventlistpage" sender:self];
                }
            }
            
            [CommonUtils stopActivityIndicatorOnView:self.view];
        }];
        
    }
}
- (IBAction)forgotUsername:(id)sender {
    
    _isForgotPassword = NO;
    [self performSegueWithIdentifier:@"forgotUsername" sender:self];

}

- (IBAction)forgotPassword:(id)sender {
    
    _isForgotPassword = YES;
    [self performSegueWithIdentifier:@"forgotUsername" sender:self];

}

- (NSString *)testSample:(NSString*) str
{
    NSString *s = [NSString stringWithFormat:@"Krishna = %@", str];
    return s;
}

#pragma mark - Authentication ( Login )
- (void) authenticate
{
#if 0
    __block NSDictionary *loginDataRoot = nil;
    __block NSDictionary *loginDataChild = nil;
    __block BOOL loginSuccessful = NO;
    [[GGDataManager defaultManager] authenticateUser:nil usingBlock:^(NSDictionary *data, NSError *err)
     {
         loginDataRoot = data;
         [loginDataRoot enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop)
          {
              loginDataChild = [loginDataRoot objectForKey:key];
              [loginDataChild enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop)
               {
                   if([key isEqualToString:self.userId.text] && [obj isEqualToString:self.password.text])
                   {
                       loginSuccessful = YES;
                       *stop = YES;
                   }
               }];
          }];
     }];
    if(loginSuccessful){
        [self performSegueWithIdentifier:@"Authenticate" sender:self]; // Changes the scene to GGHomeViewController
        [GlobalMemory setObject:self.userPasswordTF.text forKey:@"UserID"];
    }
    else{
        [CommonUtils showSimpleAlertWithTitle:@"Login Failed" andMessage:@"Invalid username or password"];
    }
#endif
}

#pragma mark -
#pragma PrepareSeague for specific controller
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    NSLog(@"VALUE = %@", segue.identifier);
    if ([segue.identifier isEqualToString:@"eventlistpage"]) {
        
    }else if([segue.identifier isEqualToString:@"forgotUsername"])
    {
        ICGForgotPasswordViewController* viewC = (ICGForgotPasswordViewController*) segue.destinationViewController;
        viewC.isForgotPassword = _isForgotPassword;
    }
}

- (IBAction)backToViewControllerOne:(UIStoryboardSegue *)segue
{
    NSLog(@"from segue id: %@", segue.identifier);
}

@end
