//
//  ICSubEventsListViewController.m
//  iCheckInGenie
//
//  Created by Krishna on 7/30/14.
//  Copyright (c) 2014 Apple. All rights reserved.
//

#import "ICSubEventsListViewController.h"
#import "EventList.h"
#import "ICGEvenLandingViewController.h"
@interface ICSubEventsListViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *eventImageView;
@property (weak, nonatomic) IBOutlet UITableView *subEventsTableView;
@property (weak, nonatomic) IBOutlet UILabel *eventTitleLabel;

@end

@implementation ICSubEventsListViewController

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
    self.title = @"Schedule of Events";
    self.eventTitleLabel.text = [[self.subEventsList objectAtIndex:0] Ev_Nm];
    
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(choseImege:)];
    [self.eventImageView addGestureRecognizer:singleTap];
    [self.eventImageView setMultipleTouchEnabled:YES];
    [self.eventImageView setUserInteractionEnabled:YES];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)choseImege:(id)sender
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    //Set Camera as source type
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker
        didFinishPickingImage:(UIImage *)image
                  editingInfo:(NSDictionary *)editingInfo
{
    self.eventImageView.image = image;
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.subEventsList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    EventList *event = [self.subEventsList objectAtIndex:indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"subEventCell"];
    NSString* str = [event Ev_Nm];
    if(![str isKindOfClass:[NSNull class]]) {
        cell.textLabel.text = str;
    }
    
    cell.imageView.image = [UIImage imageNamed:@"setting.png"];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"eventLandingPage" sender:indexPath];
}

#pragma mark -
#pragma PrepareSeague for specific controller
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *indexpath = (NSIndexPath *)sender;
    if ([segue.identifier isEqualToString:@"eventLandingPage"]) {
        NSLog(@"Index = %d", indexpath.row);
        ICGEvenLandingViewController *viewC =  (ICGEvenLandingViewController*) segue.destinationViewController;
        viewC.event = [self.subEventsList objectAtIndex:indexpath.row];
        
//        viewC.subEventsList = [[ICGDataManager defaultManager] eventsList];
    }
}



@end
