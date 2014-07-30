//
//  PickerPopupViewController.m
//
//  eat24hours
//
// Copyright 2011, Krishna Gupta
//


#import "PickerPopupViewController.h"


@implementation PickerPopupViewController

@synthesize picker, pickerDelegate, section, key, pickerRows,tag, isRangePicker;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil 
{
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) 
	{
    }
	isRangePicker = NO;
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil pickerItems: (NSArray*) pickerItems
{
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) 
	{
		self.pickerRows = pickerItems;
    }
	isRangePicker = NO;
    return self;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
	if(isRangePicker)
		return 2;
	else
		return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
	return [self.pickerRows count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
	if(isRangePicker)
	{
		if(component == 0)
			return [[(NSString*)[self.pickerRows objectAtIndex:row] componentsSeparatedByString:@"-"] objectAtIndex:0];
		else 
			return [[(NSString*)[self.pickerRows objectAtIndex:row] componentsSeparatedByString:@"-"] objectAtIndex:1];
	}
	else 
		return (NSString*)[self.pickerRows objectAtIndex:row];
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
    [super viewDidLoad];
}

- (void) doneButtonPressed
{
//	[pickerDelegate pickerDoneButtonPressed:self withData:(NSString*)[self.pickerRows objectAtIndex: [picker selectedRowInComponent:0]]];
	if(isRangePicker)
	{
		NSString* lowRange = [[[self.pickerRows objectAtIndex:[picker selectedRowInComponent:0]] componentsSeparatedByString:@"-"] objectAtIndex:0];
		NSString* highRange = [[[self.pickerRows objectAtIndex:[picker selectedRowInComponent:1]] componentsSeparatedByString:@"-"] objectAtIndex:1];
		NSString* rangeString = [NSString stringWithFormat:@"%@-%@",lowRange, highRange];
		[pickerDelegate pickerDoneButtonPressed:self withData:rangeString andSelectedIndex:[picker selectedRowInComponent:0]];

	}
	else 
		[pickerDelegate pickerDoneButtonPressed:self withData:[self.pickerRows objectAtIndex:[picker selectedRowInComponent:0]] andSelectedIndex:[picker selectedRowInComponent:0]];

    UIView *firstResponder = [[[UIApplication sharedApplication] keyWindow] performSelector:@selector(firstResponder)];
	[firstResponder resignFirstResponder];

}

- (IBAction) nextButtonPressed
{
//	[pickerDelegate pickerNextButtonPressed:self withData:(NSString*)[self.pickerRows objectAtIndex: [picker selectedRowInComponent:0]]];
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload 
{
    [super viewDidUnload];
    self.picker = nil;
	self.key = nil;
	self.pickerRows = nil;
}


- (void)dealloc 
{
	[pickerRows release];
	[picker release];
	[key release];
    [super dealloc];
}

@end
