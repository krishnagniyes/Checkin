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
#import "ICGEventListViewController.h"
#import "ICASplashViewController.h"

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
@property (strong, nonatomic) ICASplashViewController *splashVC;
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
    
    self.usernameTF.text = @"Aditya";
    self.userPasswordTF.text = @"aditya123";
    Lib2ErgoRequestUtils *util = [[Lib2ErgoRequestUtils alloc] init];
    
    if ([self.usernameTF.text length] == 0 || [self.userPasswordTF.text length] == 0) {
    
        [CommonUtils showSimpleAlertWithTitle:@"" andMessage:@"Username & and password can not be left empty"];
        return;
    }
    else {
        [self loadData:util];
    
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


#pragma mark -
#pragma PrepareSeague for specific controller
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    NSLog(@"VALUE = %@", segue.identifier);
    if ([segue.identifier isEqualToString:@"eventlistpage"]) {
        ICGEventListViewController *viewC =  (ICGEventListViewController*) segue.destinationViewController;
        viewC.eventsList = [[ICGDataManager defaultManager] eventsList];
        
        
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

- (void) loadData :(Lib2ErgoRequestUtils*) util{
    
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
                
                [CommonUtils stopActivityIndicatorOnView:self.view];
                
                
                self.splashVC = [[ICASplashViewController alloc] init];
                self.splashVC.view = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.x, self.view.frame.size.width, self.view.frame.size.height)];
                [self presentViewController:self.splashVC animated:YES completion:nil];
                

                NSString* temp = @"GetEventList?DeviceID=5654&token=ZO9VK3LSPTGKAXH983A7TEVC15379G&OrganizerID=2";
                
                //                    LoginResponse *res = [[ICGDataManager defaultManager] loginResponse];
                //                    [util doRequestForService:[NSString stringWithFormat:kGetEventListService,[res DeviceID],
                //                                               [res Token], [res OrganizerID]] usingCompletionBlock:^(id data, NSError *error) {
                
                
                [util doRequestForService:temp usingCompletionBlock:^(id data, NSError *error) {
                    
                    if(![[dict allKeys] containsObject:@"Result"]) {
                        
                        sleep(2);
                        [[ICGDataManager defaultManager] listOfEventsFromData:data];
                        
                        ///Get Attendee List
                        [util doRequestForService:kTempGetAttendee usingCompletionBlock:^(id data, NSError *error) {
                            if(![[dict allKeys] containsObject:@"Result"]) {
                                
                                [[ICGDataManager defaultManager] attendeeList:data];
                                NSArray *data = [[ICGDataManager defaultManager] attendeesList];
                                NSLog(@"Attendee Data = %@", [data description]);
                                
                                [self.splashVC dismissViewControllerAnimated:YES
                                                                  completion:nil];
                                
                                
                                [self performSegueWithIdentifier:@"eventlistpage" sender:self];
                                
                            }
                            
                        }];
                    }
                }];
                
            }
        }
        
    }];
    
}
@end
