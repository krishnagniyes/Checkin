//
//  ICGEventListViewController.m
//  iCheckInGenie
//
//  Created by Krishna on 12/02/14.
//  Copyright (c) 2014 Gniyes Inc.. All rights reserved.
//

#import "ICGEventListViewController.h"
#import "ExpandableTableViewCell.h"
#import "ICGDataManager.h"
#import "EventList.h"


#define kBorderWidth 1.0
#define kCornerRadius 15.0

@interface ICGEventListViewController ()
{
    BOOL _ischangedTab;
}
@property (weak, nonatomic) IBOutlet UISegmentedControl *optionsSegmentCtrl;
@property (weak, nonatomic) IBOutlet UITableView *eventListTableView;
@property(nonatomic,strong) NSArray *items;
@property (nonatomic, retain) NSMutableArray *activeEvents;
@property (nonatomic, retain) NSMutableArray *closedEvents;

@end

@implementation ICGEventListViewController

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
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:kBackgroundColor_iPhone]]];
    self.navigationItem.hidesBackButton = YES;
    self.title = @"Events";
    self.activeEvents = [[NSMutableArray alloc] init];
    self.closedEvents = [[NSMutableArray alloc] init];

    for (EventList *event in self.eventsList) {
        if ([[event Ev_Sts_Cd] isEqualToString:@"Active"]) {
            [self.activeEvents addObject:event];
        }
        else {
            [self.closedEvents addObject:event];
        }
    }

    self.eventsList = self.activeEvents;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View Data Source Methods

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    
//    if(section == 0 && !_ischangedTab)
//        return @"Active Events";
//    else
//        return @"Closed Events";
//    
//    return nil;
//}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.eventsList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    EventList *event = [self.eventsList objectAtIndex:indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    NSString* str = [event Ev_Nm];
    if(![str isKindOfClass:[NSNull class]]) {
            cell.textLabel.text = str;
    }
    
    cell.imageView.image = [UIImage imageNamed:@"setting.png"];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (IBAction)segmentOptionAction:(id)sender {
    
    UISegmentedControl *segment = (UISegmentedControl *)sender;
    if([segment selectedSegmentIndex] == 0)
    {
        self.eventsList = self.activeEvents;
        [self.eventListTableView reloadData];
        _ischangedTab = NO;
    }else
    {
        self.eventsList = self.closedEvents;
        [self.eventListTableView reloadData];
        _ischangedTab = YES;
    }
    
    [self.eventListTableView reloadData];
}

#pragma mark -
#pragma PrepareSeague for specific controller
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    NSLog(@"VALUE = %@", segue.identifier);
    if ([segue.identifier isEqualToString:@"eventlistpage"]) {
    }
}


@end
