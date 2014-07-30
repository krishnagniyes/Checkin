//
//  PickerPopupViewController.h
//
//  eat24hours
//
// Copyright 2011, Krishna Gupta
//

#import <UIKit/UIKit.h>
#import "PickerPopupDelegateProtocol.h"

@interface PickerPopupViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>
{
	UIPickerView* picker;
	id<PickerPopupDelegate> pickerDelegate;
	
	NSUInteger section;
	NSString* key;
	NSUInteger tag;
	NSArray* pickerRows;
	BOOL isRangePicker;
}

@property (nonatomic, retain) IBOutlet UIPickerView* picker;
@property (nonatomic, assign) id<PickerPopupDelegate> pickerDelegate;
@property (nonatomic) NSUInteger section;
@property (nonatomic, retain) NSString* key;
@property (nonatomic, retain) NSArray* pickerRows;
@property (nonatomic, assign) 	NSUInteger tag;
@property (nonatomic, assign)BOOL isRangePicker;


- (IBAction) doneButtonPressed;
- (IBAction) nextButtonPressed;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil pickerItems: (NSArray*) pickerItems;

@end
