//
//  ICGLeadRetrievalDashBoardViewController.m
//  iCheckInGenie
//
//  Created by Krishna on 12/02/14.
//  Copyright (c) 2014 Gniyes Inc.. All rights reserved.
//

#import "ICGLeadRetrievalDashBoardViewController.h"
typedef enum
{
    kSCANOption = 0,
    kEnterALeadOption,
    kViewLeadsOption,
    kMyAccountOption
}Options;

@interface ICGLeadRetrievalDashBoardViewController ()<UITabBarDelegate>
{
    NSArray *_optionsArray;
    NSUInteger _selectedOption;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *eventName;
@end

@implementation ICGLeadRetrievalDashBoardViewController

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
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:kBackgroundColor_iPad]]];
    }
    else {
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:kBackgroundColor_iPhone]]];
    }

    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tree"]];
    self.tableView.layer.cornerRadius = 7.0;
    
    self.navigationItem.rightBarButtonItems = @[[self homeButton:@"home.png"], [self addAttendeeButton:@"addAttendee.png"]];
    _optionsArray = @[@"SCAN", @"ENTER A LEAD", @"VIEW LEADS", @"MY ACCOUNT"];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIBarButtonItem *)homeButton:(NSString *)imagename {
    
    UIImage *checkInImage = nil;
    UIButton *checkInButton = nil;
    checkInImage = [UIImage imageNamed:imagename];
    checkInButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [checkInButton setBackgroundImage:checkInImage forState:UIControlStateNormal];
    
    [checkInButton addTarget:self action:@selector(homeAction:) forControlEvents:UIControlEventTouchUpInside];
    
    const CGFloat BarButtonOffset = 5.0f;
    [checkInButton setFrame:CGRectMake(BarButtonOffset, 0, checkInImage.size.width, checkInImage.size.height)];
    
    UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, checkInImage.size.width, checkInImage.size.height)];
    [containerView addSubview:checkInButton];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:containerView];
    return item;
}

- (UIBarButtonItem *)addAttendeeButton:(NSString *)imagename {
    
    UIImage *checkInImage = nil;
    UIButton *checkInButton = nil;
    checkInImage = [UIImage imageNamed:imagename];
    checkInButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [checkInButton setBackgroundImage:checkInImage forState:UIControlStateNormal];
    
    [checkInButton addTarget:self action:@selector(addAttendeeAction:) forControlEvents:UIControlEventTouchUpInside];
    
    const CGFloat BarButtonOffset = 5.0f;
    [checkInButton setFrame:CGRectMake(BarButtonOffset, 0, checkInImage.size.width, checkInImage.size.height)];
    
    UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, checkInImage.size.width, checkInImage.size.height)];
    [containerView addSubview:checkInButton];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:containerView];
    return item;
}

#pragma mark - Table View Data Source Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_optionsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"OptionsCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if ( cell == nil ) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    UILabel *l =   (UILabel*) [cell viewWithTag:1];
    l.text = [_optionsArray objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark - table view delegate methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"LEADRETRIEVAL" sender:self];
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

- (void)homeAction:(id) sender
{
    NSLog(@"Home");
}

- (void)addAttendeeAction:(id) sender
{
    NSLog(@"addAttendeeAction");
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
        [tabVC setSelectedViewController:[tabVC.viewControllers objectAtIndex:_selectedOption]];
    }
}

#pragma -
#pragma AlertView delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(0 == buttonIndex)
        return;
    else
    {
        for(id VC in [self.navigationController viewControllers])
        {
//            if([VC isKindOfClass:[ICGLoginViewController class]])
//            {
//                [self.navigationController popToViewController:VC animated:YES];
//                break;
//            }
        }
    }
}


@end
