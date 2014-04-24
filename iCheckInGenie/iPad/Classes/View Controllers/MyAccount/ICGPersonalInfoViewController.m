//
//  ICGPersonalInfoViewController.m
//  iCheckInGenie
//
//  Created by Krishna on 22/02/14.
//  Copyright (c) 2014 Gniyes Inc... All rights reserved.
//

#import "ICGPersonalInfoViewController.h"

@interface ICGPersonalInfoViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSDictionary *userDetailDict;
@property (nonatomic, strong) NSMutableArray *userDetailArray;
@property (nonatomic, strong) NSArray *labelArray;

@end

@implementation ICGPersonalInfoViewController

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
    [self.view setBackgroundColor:[UIColor greenColor]];
    self.tableView.layer.cornerRadius = 7.0;

    NSDictionary * d1 = @{ @"Name" : @"Krishna"};
    NSDictionary * d2 = @{ @"Email" : @"dev3@gniyes@gmail.com"};
    NSDictionary * d3 = @{ @"Password" : @"**********"};
    self.userDetailArray = [[NSMutableArray alloc] init];
    
    [_userDetailArray addObject:d1];
    [_userDetailArray addObject:d2];
    [_userDetailArray addObject:d3];
    
    _labelArray = @[@"Name", @"Email", @"Password"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View Data Source Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_labelArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"UserInfo";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if ( cell == nil ) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    [(UILabel*)[cell viewWithTag:100] setText:[_labelArray objectAtIndex:indexPath.row]];
    [(UITextField*)[cell viewWithTag:101] setText:[[_userDetailArray objectAtIndex:indexPath.row] objectForKey:[_labelArray objectAtIndex:indexPath.row]]];
    
    return cell;
}
@end
