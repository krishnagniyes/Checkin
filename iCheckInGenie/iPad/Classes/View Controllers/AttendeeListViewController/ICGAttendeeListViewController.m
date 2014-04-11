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
{
    NSUInteger index;
}

@property (weak, nonatomic) IBOutlet UITableView *attendeeTableView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *optionSegmentView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchTextField;

@property (nonatomic, strong) NSMutableArray *attendeesArray;
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
    self.attendeesArray = [[NSMutableArray alloc] init];
    
    NSDictionary* d3 = [NSDictionary dictionaryWithObjects:@[@"SIM", @"1"] forKeys:@[@"subname",@"sublastname"]];
    NSDictionary* d4 = [NSDictionary dictionaryWithObjects:@[@"SIM", @"2"] forKeys:@[@"subname",@"sublastname"]];
    NSDictionary* d5 = [NSDictionary dictionaryWithObjects:@[@"SIM", @"3"] forKeys:@[@"subname",@"sublastname"]];
    
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    
    [arr addObject:d3];
    [arr addObject:d4];
    [arr addObject:d5];
    
    NSDictionary* d = [NSDictionary dictionaryWithObjects:@[@"Krishna", @"1211", arr] forKeys:@[@"name",@"lastname", @"SB"]];

    
    NSDictionary* d2 = [NSDictionary dictionaryWithObjects:@[@"ILA", @"2"] forKeys:@[@"name",@"lastname"]];

    
    [_attendeesArray addObject:d];
    [_attendeesArray addObject:d2];
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
    NSUInteger count = [_attendeesArray count];
    
    for(NSDictionary * d in _attendeesArray)
    {
        count += [[d objectForKey:@"SB"] count];
    }

    NSLog(@"Count = %d", count);
    return count;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = nil;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        CellIdentifier = @"AttendeeDetailCell";
    }
    else {
        CellIdentifier = @"AttendeeDetailCellIPhone";
    }

    ICGAttendeeDetailCell *cell = (ICGAttendeeDetailCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.checkInLabel.hidden = NO;
    cell.checkInLabel.text = @"";

    NSDictionary *d1 = [_attendeesArray objectAtIndex:index
                       ];
    

    NSArray* arr = [d1 objectForKey:@"SB"];
    
    NSLog(@"ARR COUNT = %d", [arr count]);
    
    if([arr count] == indexPath.row){
        index++;
        arr = nil;
    }
    
    if([arr count] != 0){
        NSDictionary* d = [arr objectAtIndex:indexPath.row];
        cell.snoLabel.text = [d objectForKey:@"sublastname"];
        cell.infoLabel.text = [d objectForKey:@"subname"];
        cell.additionalInfoLabel.text = [NSString stringWithFormat:@"[%d]",[arr count]];
    }else{
        cell.snoLabel.text = [d1 objectForKey:@"lastname"];
        cell.infoLabel.text = [d1 objectForKey:@"name"];
        cell.additionalInfoLabel.text = [NSString stringWithFormat:@"[%d]",[arr count]];
    
    }
    
//    NSArray *a = [_attendeesArray objectAtIndex:0];
//    
//    NSDictionary *d = [a objectAtIndex:indexPath.row];
//            cell.snoLabel.text = [d objectForKey:@"lastname"];
//            cell.infoLabel.text = [d objectForKey:@"name"];
//            cell.additionalInfoLabel.text = [NSString stringWithFormat:@"[%d]",[a count]];

    return cell;
}


-(CGFloat) tableView:(UITableView *)tableView
heightForHeaderInSection:(NSInteger)section
{
    return 44.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    static NSString *CellIdentifier = nil;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        CellIdentifier = @"AttendeeDetailCell";
    }
    else {
        CellIdentifier = @"AttendeeDetailCellIPhone";
    }

    ICGAttendeeDetailCell *cell = (ICGAttendeeDetailCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    cell.infoLabel.backgroundColor = [UIColor blueColor];
    cell.additionalInfoLabel.backgroundColor = [UIColor blueColor];
    cell.checkInLabel.backgroundColor = [UIColor blueColor];
    cell.snoLabel.backgroundColor = [UIColor blueColor];

    cell.snoLabel.textColor = [UIColor whiteColor];
    
    cell.infoLabel.textColor = [UIColor whiteColor];
    cell.additionalInfoLabel.textColor = [UIColor whiteColor];
    cell.checkInLabel.textColor = [UIColor whiteColor];

    cell.snoLabel.text = @"###";
    cell.infoLabel.text = @"Information";
    cell.additionalInfoLabel.text = @"Additional Guest";
    cell.checkInLabel.text = @"Check In";

    cell.checkInLabel.hidden = NO;
    cell.checkedInButton.hidden = YES;
    
    return cell;

}

@end
