//
//  ICGEventListViewController.m
//  iCheckInGenie
//
//  Created by Krishna on 12/02/14.
//  Copyright (c) 2014 Gniyes Inc.. All rights reserved.
//

#import "ICGEventListViewController.h"
#import "ExpandableTableViewCell.h"
#define kBorderWidth 1.0
#define kCornerRadius 15.0

@interface ICGEventListViewController ()
{
    BOOL _ischangedTab;
}
@property (weak, nonatomic) IBOutlet UISegmentedControl *optionsSegmentCtrl;
@property (weak, nonatomic) IBOutlet UITableView *eventListTableView;
@property(nonatomic,strong) NSArray *items;
@property (nonatomic, retain) NSMutableArray *itemsInTable;

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
//    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tree"]];
    self.title = @"Events";

    NSDictionary *dict=[[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"data" ofType:@"plist"]];
	self.items=[dict valueForKey:@"Items"];
	self.itemsInTable=[[NSMutableArray alloc] init];
	[self.itemsInTable addObjectsFromArray:self.items];

	// Do any additional setup after loading the view.
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
    return [self.itemsInTable count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *Title= [[self.itemsInTable objectAtIndex:indexPath.row] valueForKey:@"Name"];
    
    return [self createCellWithTitle:Title image:[[self.itemsInTable objectAtIndex:indexPath.row] valueForKey:@"Image name"] indexPath:indexPath];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = [self.itemsInTable objectAtIndex:indexPath.row];
    if([dic valueForKey:@"SubItems"])
    {
        NSArray *arr = [dic valueForKey:@"SubItems"];
        BOOL isTableExpanded = NO;
        
        for(NSDictionary *subitems in arr)
        {
            NSInteger index = [self.itemsInTable indexOfObjectIdenticalTo:subitems];
            isTableExpanded = (index > 0 && index != NSIntegerMax);
            if(isTableExpanded) break;
        }
        
        if(isTableExpanded)
        {
            [self collapseRows:arr];
        }
        else
        {
            NSUInteger count = indexPath.row + 1;
            NSMutableArray *arrCells = [NSMutableArray array];
            for(NSDictionary *dInner in arr )
            {
                [arrCells addObject:[NSIndexPath indexPathForRow:count inSection:0]];
                [self.itemsInTable insertObject:dInner atIndex:count++];
            }
            [self.eventListTableView insertRowsAtIndexPaths:arrCells withRowAnimation:UITableViewRowAnimationLeft];
        }
    }else
    {
        [self performSegueWithIdentifier:@"eventdetailpage" sender:self];
    }
}

-(void)collapseRows:(NSArray*)ar
{
	for(NSDictionary *dInner in ar)
    {
		NSUInteger indexToRemove=[self.itemsInTable indexOfObjectIdenticalTo:dInner];
		NSArray *arInner=[dInner valueForKey:@"SubItems"];
		if(arInner && [arInner count] > 0)
        {
			[self collapseRows:arInner];
		}
		
		if([self.itemsInTable indexOfObjectIdenticalTo:dInner]!=NSNotFound)
        {
			[self.itemsInTable removeObjectIdenticalTo:dInner];
			[self.eventListTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:
                                                        [NSIndexPath indexPathForRow:indexToRemove inSection:0]
                                                        ]
                                      withRowAnimation:UITableViewRowAnimationLeft];
        }
	}
}

- (UITableViewCell*)createCellWithTitle:(NSString *)title image:(UIImage *)image  indexPath:(NSIndexPath*)indexPath
{
    NSString *CellIdentifier = @"Cell";
    ExpandableTableViewCell* cell = [self.eventListTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    
    CALayer *borderLayer = [CALayer layer];
    CGRect borderFrame = CGRectMake(0, 0, (cell.imgView.frame.size.width), (cell.imgView.frame.size.height));
    [borderLayer setBackgroundColor:[[UIColor clearColor] CGColor]];
    [borderLayer setFrame:borderFrame];
    [borderLayer setCornerRadius:kCornerRadius];
    [borderLayer setBorderWidth:kBorderWidth];
    [borderLayer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [cell.imgView.layer addSublayer:borderLayer];
    
    if(indexPath.row % 2 == 0){
        
        cell.imgView.image = [UIImage imageNamed:@"mac"];
    }


    
    UIView *bgView = [[UIView alloc] init];
    bgView.backgroundColor = [UIColor grayColor];
    cell.selectedBackgroundView = bgView;
    cell.lblTitle.text = title;
    cell.lblTitle.textColor = [UIColor blackColor];
    
    [cell setIndentationLevel:[[[self.itemsInTable objectAtIndex:indexPath.row] valueForKey:@"level"] intValue]];
    cell.indentationWidth = 25;
    
    float indentPoints = cell.indentationLevel * cell.indentationWidth;
    
    cell.contentView.frame = CGRectMake(indentPoints,cell.contentView.frame.origin.y,cell.contentView.frame.size.width - indentPoints,cell.contentView.frame.size.height);
    
    NSDictionary *d1=[self.itemsInTable objectAtIndex:indexPath.row] ;
    
    if([d1 valueForKey:@"SubItems"])
    {
        cell.btnExpand.alpha = 1.0;
        [cell.btnExpand addTarget:self action:@selector(showSubItems:) forControlEvents:UIControlEventTouchUpInside];
    }
    else
    {
        cell.btnExpand.alpha = 0.0;
    }
    return cell;
}

-(void)showSubItems :(id) sender
{
    UIButton *btn = (UIButton*)sender;
    CGRect buttonFrameInTableView = [btn convertRect:btn.bounds toView:self.eventListTableView];
    NSIndexPath *indexPath = [self.eventListTableView indexPathForRowAtPoint:buttonFrameInTableView.origin];
    
    if(btn.alpha == 1.0)
    {
        if ([[btn imageForState:UIControlStateNormal] isEqual:[UIImage imageNamed:@"down-arrow.png"]])
        {
            [btn setImage:[UIImage imageNamed:@"up-arrow.png"] forState:UIControlStateNormal];
        }
        else
        {
            [btn setImage:[UIImage imageNamed:@"down-arrow.png"] forState:UIControlStateNormal];
        }
        
    }
    
    NSDictionary *d=[self.itemsInTable objectAtIndex:indexPath.row] ;
    NSArray *arr=[d valueForKey:@"SubItems"];
    if([d valueForKey:@"SubItems"])
    {
        BOOL isTableExpanded = NO;
        for(NSDictionary *subitems in arr )
        {
            NSInteger index=[self.itemsInTable indexOfObjectIdenticalTo:subitems];
            isTableExpanded=(index > 0 && index!=NSIntegerMax);
            if(isTableExpanded) break;
        }
        
        if(isTableExpanded)
        {
            [self collapseRows:arr];
        }
        else
        {
            NSUInteger count=indexPath.row+1;
            NSMutableArray *arrCells=[NSMutableArray array];
            for(NSDictionary *dInner in arr )
            {
                [arrCells addObject:[NSIndexPath indexPathForRow:count inSection:0]];
                [self.itemsInTable insertObject:dInner atIndex:count++];
            }
            [self.eventListTableView insertRowsAtIndexPaths:arrCells withRowAnimation:UITableViewRowAnimationLeft];
        }
    }
    
    
}

- (IBAction)segmentOptionAction:(id)sender {
    
    UISegmentedControl *segment = (UISegmentedControl *)sender;
    
    if([segment selectedSegmentIndex] == 0)
    {
        _ischangedTab = NO;
    }else
    {
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
