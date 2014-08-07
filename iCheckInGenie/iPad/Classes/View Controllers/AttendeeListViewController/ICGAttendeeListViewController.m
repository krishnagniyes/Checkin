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
#import "ICGDataManager.h"
#import "AttendeeDetails.h"
#import "ICGAddAttendeeViewController.h"

#define kBorderWidth 3.0
#define kCornerRadius 8.0

#define WORD_LENGTH 5

static NSString *letters = @"abcdefghijklmnopqrstuvwxyz";

@interface ICGAttendeeListViewController ()
{
    NSUInteger index;
}

@property (weak, nonatomic) IBOutlet UITableView *attendeeTableView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *optionSegmentView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchTextField;

@property (nonatomic, strong) NSMutableArray *attendeesArray;


@property (nonatomic, strong) NSMutableArray *checkedInAttendeeArr;
@property (nonatomic, strong) NSMutableArray *allAttendeeArray;
@property (nonatomic, strong) NSMutableArray *pendingCheckinAttendeeArray;




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
    
    self.attendeesArray = (NSMutableArray *)[[ICGDataManager defaultManager] attendeesList];
    
//    for (ICGAttendeeDetailCell *attendee in self.attendeesArray) {
//        if ([[event Ev_Sts_Cd] isEqualToString:@"Active"]) {
//        }
//        else if (){
//        }
//        else {
//        
//        }
//    }

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
    
//    for(NSDictionary * d in _attendeesArray)
//    {
//        count += [[d objectForKey:@"SB"] count];
//    }

    NSLog(@"Count = %d", count);
    return count;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
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
    
    
    AttendeeDetails *attendee = [self.attendeesArray objectAtIndex:indexPath.row];
    
    cell.snoLabel.text = [NSString stringWithFormat:@"%d", indexPath.row + 1];

    
    cell.infoLabel.text = [attendee Fst_Nm];
    cell.additionalInfoLabel.text = [[attendee Additional_Guests] stringValue];
    cell.confCodeLabel.text = [NSString stringWithFormat:@"Conf. Code :%@",[attendee Cnfrm_Cd]];
    
    
    

//    NSDictionary *d1 = [_attendeesArray objectAtIndex:index
//                       ];
//    
//
//    NSArray* arr = [d1 objectForKey:@"SB"];
//    
//    NSLog(@"ARR COUNT = %d", [arr count]);
//    
//    if([arr count] == indexPath.row){
//        index++;
//        arr = nil;
//    }
//    
//    if([arr count] != 0){
//        NSDictionary* d = [arr objectAtIndex:indexPath.row];
//        cell.snoLabel.text = [d objectForKey:@"sublastname"];
//        cell.infoLabel.text = [d objectForKey:@"subname"];
//        cell.additionalInfoLabel.text = [NSString stringWithFormat:@"[%d]",[arr count]];
//    }else{
//        cell.snoLabel.text = [d1 objectForKey:@"lastname"];
//        cell.infoLabel.text = [d1 objectForKey:@"name"];
//        cell.additionalInfoLabel.text = [NSString stringWithFormat:@"[%d]",[arr count]];
//    }
//
    cell.snoLabel.backgroundColor = [UIColor lightGrayColor];

    cell.infoLabel.backgroundColor = [UIColor whiteColor];
    cell.additionalInfoLabel.backgroundColor = [UIColor whiteColor];
    cell.confCodeLabel.backgroundColor = [UIColor whiteColor];
    cell.packageDEtailLabel.backgroundColor = [UIColor whiteColor];


    
//    CALayer *borderLayer = [CALayer layer];
//    CGRect borderFrame = CGRectMake(0, 0, (cell.additionalInfoLabel.frame.size.width), (cell.additionalInfoLabel.frame.size.height));
//    [borderLayer setBackgroundColor:[[UIColor clearColor] CGColor]];
//    [borderLayer setFrame:borderFrame];
//    [borderLayer setCornerRadius:kCornerRadius];
//    [borderLayer setBorderWidth:kBorderWidth];
//    [borderLayer setBorderColor:[[UIColor redColor] CGColor]];
//    [cell.additionalInfoLabel.layer addSublayer:borderLayer];

    
//    NSArray *a = [_attendeesArray objectAtIndex:0];
//    
//    NSDictionary *d = [a objectAtIndex:indexPath.row];
//            cell.snoLabel.text = [d objectForKey:@"lastname"];
//            cell.infoLabel.text = [d objectForKey:@"name"];
//            cell.additionalInfoLabel.text = [NSString stringWithFormat:@"[%d]",[a count]];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90.0;
}


-(CGFloat) tableView:(UITableView *)tableView
heightForHeaderInSection:(NSInteger)section
{
    return 35.0;
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
    
    //TODO - write conditional code here for iPad

    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(tableView.frame.origin.x, tableView.frame.origin.x, tableView.frame.size.width, 35)];
    [headerView setBackgroundColor:[UIColor blackColor]];

    UILabel* sno = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 35)];
    [sno setBackgroundColor:[UIColor blackColor]];
    sno.textColor = [UIColor whiteColor];
    sno.text = @"#";
    sno.textAlignment = NSTextAlignmentCenter;
    sno.font = [UIFont boldSystemFontOfSize:11.0];
    [headerView addSubview:sno];

    UILabel* info = [[UILabel alloc] initWithFrame:CGRectMake(50, 0, 150, 35)];
    [info setBackgroundColor:[UIColor blackColor]];
    info.textColor = [UIColor whiteColor];
    info.text = @"Information";
    info.font = [UIFont boldSystemFontOfSize:11.0];
    info.textAlignment = NSTextAlignmentLeft;
    [headerView addSubview:info];

    UILabel* additionalInfoLabel = [[UILabel alloc] initWithFrame:CGRectMake(200, 0, 40, 35)];
    [additionalInfoLabel setBackgroundColor:[UIColor blackColor]];
    additionalInfoLabel.font = [UIFont boldSystemFontOfSize:11.0];
    additionalInfoLabel.textColor = [UIColor whiteColor];
    additionalInfoLabel.text = @"Guests";
    additionalInfoLabel.textAlignment = NSTextAlignmentLeft;
    [headerView addSubview:additionalInfoLabel];

    UILabel* checkInLabel = [[UILabel alloc] initWithFrame:CGRectMake(240, 0, 60, 35)];
    [checkInLabel setBackgroundColor:[UIColor blackColor]];
    checkInLabel.textColor = [UIColor whiteColor];
    checkInLabel.font = [UIFont boldSystemFontOfSize:11.0];
    checkInLabel.text = @"Check-In";
    checkInLabel.textAlignment = NSTextAlignmentRight;
    [headerView addSubview:checkInLabel];

    return headerView;

}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    NSMutableArray *sectionedArray = [[NSMutableArray alloc] init];
    for(char c ='A' ; c <= 'Z' ;  c++)
    {
        [sectionedArray addObject:[NSString stringWithFormat:@"%c",c]];
    }
    return sectionedArray;
}


- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    NSInteger count = 0;
//    for(NSString *character in nameIndex)
//    {
//        if([character isEqualToString:title])
//        {
//            return count;
//        }
//        count ++;
//    }
    return 0;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.title = @"Back";
    [self performSegueWithIdentifier:@"addAttendeePage" sender:indexPath];
}


#pragma mark -
#pragma PrepareSeague for specific controller
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *indexpath = (NSIndexPath *)sender;
    if ([segue.identifier isEqualToString:@"addAttendeePage"]) {
        ICGAddAttendeeViewController *viewC =  (ICGAddAttendeeViewController*) segue.destinationViewController;
        viewC.attendeeDetail = [self.attendeesArray objectAtIndex:indexpath.row];
    }
}


@end
