//
//  ICQuickMenuViewController.m
//  iCheckInGenie
//
//  Created by Krishna on 11/04/14.
//  Copyright (c) 2014 Gniyes. All rights reserved.
//

#import "ICQuickMenuViewController.h"
#import "ICAppDelegate.h"
@interface ICQuickMenuViewController ()
@property (strong, readwrite, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray * titlesArray;
@end

@implementation ICQuickMenuViewController



- (void)viewDidLoad
{
    [super viewDidLoad];

    self.titlesArray = @[@"Search", @"Events", @"CE Credits", @"Exhibitor Lead Retrieval", @"Logout"];

    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:kBackgroundColor_iPhone]]];

    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    [button addTarget:self
//               action:@selector(aMethod:)
//     forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"Start" forState:UIControlStateNormal];
    button.frame = CGRectMake(self.view.frame.size.width - 90, 100, 100, 44) ;
    [self.view addSubview:button];
    
    
    self.tableView = ({
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, (self.view.frame.size.height - 60 * 5) / 2.0f, self.view.frame.size.width, 60 * 5) style:UITableViewStylePlain];
        tableView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.opaque = NO;
        tableView.backgroundColor = [UIColor clearColor];
        tableView.backgroundView = nil;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.bounces = NO;
        tableView;
    });
    [self.view addSubview:self.tableView];
}

#pragma mark -
#pragma mark UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
//            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"firstViewController"]]
//                                                         animated:YES];
            [self.sideMenuViewController hideMenuViewController];
            break;
        case 1:
//            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"secondViewController"]]
//                                                         animated:YES];
            [self.sideMenuViewController hideMenuViewController];
            break;
        case 2:
            [self.sideMenuViewController hideMenuViewController];

            break;
        case 3:
            break;
            [self.sideMenuViewController hideMenuViewController];

        case 4:
        {
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:kLogoutAlertTitle message:kLogoutMessage delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Logout", nil];
            [alert show];

        }
//            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"LandingVC"]]];
//        {
//            
//            [self.sideMenuViewController hideMenuViewController];
//
//        }
            break;

        default:
            break;
    }
}

#pragma mark -
#pragma mark UITableView Datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 54;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return [_titlesArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:18];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.highlightedTextColor = [UIColor lightGrayColor];
        cell.selectedBackgroundView = [[UIView alloc] init];
    }
    
    cell.textLabel.text = _titlesArray[indexPath.row];
    cell.textLabel.textAlignment = NSTextAlignmentRight;
    
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width - 30, 30)];
    /* Create custom view to display section header... */
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, tableView.frame.size.width - 30, 30)];
    label.font = [UIFont fontWithName:@"HelveticaNeue" size:21];
    label.textAlignment =  NSTextAlignmentRight;
    label.textColor = [UIColor darkGrayColor];
    label.highlightedTextColor = [UIColor whiteColor];

    /* Section header is in 0th index... */
    [label setText:@"Jump to Section"];
    [view addSubview:label];
    [view setBackgroundColor:[UIColor clearColor]]; //your background color...
    return view;
}


#pragma -
#pragma AlertView delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(0 == buttonIndex)
        return;
    else
    {
        [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"LandingVC"]]];
        [self.sideMenuViewController hideMenuViewController];
    }
}


@end
