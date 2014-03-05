//
//  ICGAttendeeListViewController.m
//  iCheckInGenie
//
//  Created by Krishna on 12/02/14.
//  Copyright (c) 2014 Gniyes Inc.. All rights reserved.
//

#import "ICGAttendeeListViewController.h"
#import "ICGSyncViewController.h"
#import "ICGAttendeeDetailCell.h"
#import "ICGAttendeeDetailCell.h"
@interface ICGAttendeeListViewController ()
@property (weak, nonatomic) IBOutlet UITableView *attendeeTableView;

@property (weak, nonatomic) IBOutlet UISegmentedControl *optionSegmentView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchTextField;
@end

@implementation ICGAttendeeListViewController

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
    [self.attendeeTableView setBackgroundColor:[UIColor grayColor]];

}

- (void) viewWillAppear:(BOOL)animated
{
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"AttendeeDetailCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    return cell;
}


-(CGFloat) tableView:(UITableView *)tableView
heightForHeaderInSection:(NSInteger)section
{
    return 44.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
//    UIView *sectionHeaderView = [[UIView alloc] initWithFrame:
//                                 CGRectMake(0, 0, tableView.frame.size.width, 50.0)];
//    sectionHeaderView.backgroundColor = [UIColor cyanColor];
//    
//    UILabel *headerLabel = [[UILabel alloc] initWithFrame:
//                            CGRectMake(15, 15, sectionHeaderView.frame.size.width, 25.0)];
//    
//    headerLabel.backgroundColor = [UIColor clearColor];
//    headerLabel.textAlignment = NSTextAlignmentCenter;
//    [headerLabel setFont:[UIFont fontWithName:@"Verdana" size:20.0]];
//    [sectionHeaderView addSubview:headerLabel];
//    
//    return sectionHeaderView;
    
    static NSString *CellIdentifier = @"AttendeeDetailCell";
    ICGAttendeeDetailCell *cell = (ICGAttendeeDetailCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell.snoLabel.text = @"###";
    cell.infoLabel.text = @"Information";
    cell.additionalInfoLabel.text = @"Additional Guest";
    cell.checkInLabel.hidden = NO;
    cell.checkInLabel.text = @"Check In";
    cell.checkedInButton.hidden = YES;
    
    return cell;

}

@end
