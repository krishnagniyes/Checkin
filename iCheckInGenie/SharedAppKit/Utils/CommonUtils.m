
#import "CommonUtils.h"

#define kDoneButtonX 0
#define kDoneButtonY 163
#define kDoneButtonWidth 106
#define kDoneButtonHeight 53

#define kDebugMode @"DebugMode"
#define kAppPreferencesFileName	@"AppPreferences.plist"

@implementation CommonUtils

static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.2;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 120;///Changed from 167 to 88
static const NSInteger DONE_BUTTON_TAG = 575634;
static CGFloat animatedDistance = 0;


+(BOOL) isVoid:(id) obj {
	if(obj == nil){
		return YES;
	}else if([obj isKindOfClass:[NSString class]]){
		if([@"" isEqualToString:obj]){
			return YES;
		}else{
			return NO;		
		}	
	}else if([obj isKindOfClass:[NSDictionary class]]){
		if([(NSDictionary*) obj count] == 0){
			return YES;
		}else{
			return NO;
		} 	
	}else if([obj isKindOfClass:[NSArray class]]){
		if([(NSArray*)obj count] == 0){
			return YES;
		}else{
			return NO;
		} 	
	}
	return NO;
}

+(BOOL) isEqual:(id) obj1 :(id) obj2 {
	if(![CommonUtils isVoid:obj1] && ![CommonUtils isVoid:obj2]){
		if([obj1 isKindOfClass:[NSString class]] && [obj2 isKindOfClass:[NSString class]]){
			return [(NSString*)obj1 isEqualToString:(NSString*)obj2];
		}else if([obj1 isKindOfClass:[NSDictionary class]] && [obj2 isKindOfClass:[NSDictionary class]]){
			[(NSDictionary*)obj1 isEqualToDictionary:(NSDictionary*)obj2];
		}else if([obj1 isKindOfClass:[NSArray class]] && [obj2 isKindOfClass:[NSArray class]]){
			[(NSArray*)obj1 isEqualToArray:(NSArray*)obj2];
		}else if([obj1 isKindOfClass:[NSDate class]] && [obj2 isKindOfClass:[NSDate class]]){
			[(NSDate*)obj1 isEqualToDate:(NSDate*)obj2];
		}else{
			return [obj1 isEqual:obj2];
		}
	}
	return NO;
}

//Krishna---this is to load demo data plist...

+ (NSArray *) getDemoDataFor:(NSString *) url {
    
	NSString* path = [[NSBundle mainBundle] pathForResource:url ofType:@"plist"];
	return [NSArray arrayWithContentsOfFile:path];
}

+ (NSDictionary*) getDemoDataFromPList:(NSString*) url
{
	NSString* path = [[NSBundle mainBundle] pathForResource:url ofType:@"plist"];
	return [NSDictionary dictionaryWithContentsOfFile:path];
}


#pragma mark -
#pragma mark logger...
/** Krishna --- "DebugMode" set this parameter Y/N in info.plist to enable/disable logging...
* don't forgot to set this to N in release version...
**/
+(BOOL) isDebugMode {
	return [CommonUtils isEqual:@"Y" :[[NSBundle mainBundle] objectForInfoDictionaryKey:kDebugMode]];
}

+(void) logData:(id) obj {
	if(obj == nil) return;
	if([CommonUtils isDebugMode]){
//		NSLog([NSString stringWithFormat:@"%@",[obj description]]);
	}
}

+(void) logData:(id) obj withComments:(id) comments {
	[CommonUtils logData:comments];
	[CommonUtils logData:obj];
}

+(void) showSimpleAlertWithTitle:(NSString*) title andMessage:(NSString*) message {
	UIAlertView* alert = [[UIAlertView alloc] initWithTitle:title message: message delegate:nil cancelButtonTitle: @"OK" otherButtonTitles:nil];
	[alert show];
	[alert release];
}

+(NSString *)getPhoneNumberFromString:(NSString *)str {
	NSCharacterSet *numCharacterSet =  [NSCharacterSet characterSetWithCharactersInString:@"+0123456789"];
	NSMutableString *sPhone= [[[NSMutableString alloc] initWithCapacity:[str length]] autorelease];
	for (int i=0; i < ([str length]); i++){		
		unichar currentChar = [str characterAtIndex:i];
		if ([numCharacterSet characterIsMember:currentChar]){
			[sPhone appendFormat:@"%C", currentChar];
		} 
	}
	return sPhone;		
}

#pragma mark -
#pragma mark shrink/expand talbeview when focus in a textfield...
+ (void) startShrinkAnimationForTextField:(UITextField*) textField andTable: (UITableView *)parentTable {

	CGRect textFieldRect = [parentTable.window convertRect:textField.bounds fromView:textField];
	CGRect viewRect = [parentTable.window convertRect:parentTable.bounds fromView:parentTable];
	CGFloat midline = textFieldRect.origin.y + 0.5 * textFieldRect.size.height;
	CGFloat numerator = midline - viewRect.origin.y - MINIMUM_SCROLL_FRACTION * viewRect.size.height;
	CGFloat denominator = (MAXIMUM_SCROLL_FRACTION - MINIMUM_SCROLL_FRACTION) * viewRect.size.height;
	CGFloat heightFraction = numerator / denominator;
	
	if (heightFraction < 0.0) {
		heightFraction = 0.0;
	}else if (heightFraction > 1.0) {
		heightFraction = 1.0;
	}
	
	animatedDistance = floor(PORTRAIT_KEYBOARD_HEIGHT * heightFraction);
	
	CGRect viewFrame = parentTable.frame;
	//CGRect viewFrame = viewRect;
	viewFrame.origin.y -= animatedDistance;
	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationBeginsFromCurrentState:YES];
	[UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
	
	[parentTable setFrame:viewFrame];
	
	[UIView commitAnimations];
}

+ (void) startExpandAnimationForTextField:(UITextField*) textField andTable: (UITableView *)parentTable 
{
	
	CGRect viewFrame = parentTable.frame;
	viewFrame.origin.y += animatedDistance;
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationBeginsFromCurrentState:YES];
	[UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
	
	[parentTable setFrame:viewFrame];
	
	[UIView commitAnimations];
}

#pragma mark -
#pragma mark custom done button...
+(void) setButton:(UIButton *) button title:(NSString *) title{
	[button setTitle:title forState:UIControlStateNormal];
	[button setTitle:title forState:UIControlStateHighlighted];
	[button setTitle:title forState:UIControlStateDisabled];
	[button setTitle:title forState:UIControlStateSelected];
}

+(void) setButton:(UIButton *) button image:(UIImage*) img {
	[button setImage:img forState:UIControlStateNormal];
	[button setImage:img forState:UIControlStateHighlighted];
	[button setImage:img forState:UIControlStateDisabled];
	[button setImage:img forState:UIControlStateSelected];	
}

+(void) setButtonTitleColor:(UIButton *) button color:(UIColor *) color{
	[button setTitleColor:color forState:UIControlStateNormal];
	[button setTitleColor:color forState:UIControlStateHighlighted];
	[button setTitleColor:color forState:UIControlStateDisabled];
	[button setTitleColor:color forState:UIControlStateSelected];
}

+ (void)addDoneButtonToNumericKeypad:(id)aTarget withSelector:(SEL)aSelector {
	// locate keyboard view
	NSArray* a = [[UIApplication sharedApplication] windows];
	if([a count] <= 1) return;
	UIWindow* tempWindow = [a objectAtIndex:1];
	UIView* keyboard;
	for(int i=0; i<[tempWindow.subviews count]; i++) {
		keyboard = [tempWindow.subviews objectAtIndex:i];
		// keyboard found
		if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 3.2) {
			if([[keyboard description] hasPrefix:@"<UIPeripheralHost"] == YES){
				UIButton *doneButton = (UIButton *)[keyboard viewWithTag:DONE_BUTTON_TAG];
				if(doneButton != nil){
					//Already exists, enable it
					doneButton.hidden = NO;
					doneButton.enabled = YES;
					break;
				}else{
					//Create a new custom button
					UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
					doneButton.frame = CGRectMake(kDoneButtonX, kDoneButtonY, kDoneButtonWidth, kDoneButtonHeight);
					doneButton.adjustsImageWhenHighlighted = NO;
					doneButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:16.0];
					[CommonUtils setButton:doneButton title:@"Done"];
					doneButton.backgroundColor = [UIColor clearColor];
					[CommonUtils setButtonTitleColor:doneButton color:[UIColor darkGrayColor]];
					doneButton.tag = DONE_BUTTON_TAG;
					[doneButton addTarget:aTarget action:aSelector forControlEvents:UIControlEventTouchUpInside];
					[keyboard addSubview:doneButton];
				}
			}
		} else {
			if([[keyboard description] hasPrefix:@"<UIKeyboard"] == YES){
				//Create a new custom button
				UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
				doneButton.frame = CGRectMake(kDoneButtonX, kDoneButtonY, kDoneButtonWidth, kDoneButtonHeight);
				doneButton.adjustsImageWhenHighlighted = NO;
				doneButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:16.0];
				[CommonUtils setButton:doneButton title:@"Done"];
				doneButton.backgroundColor = [UIColor clearColor];
				[CommonUtils setButtonTitleColor:doneButton color:[UIColor darkGrayColor]];
				doneButton.tag = DONE_BUTTON_TAG;
				[doneButton addTarget:aTarget action:aSelector forControlEvents:UIControlEventTouchUpInside];
				[keyboard addSubview:doneButton];
			}
		}
	}
}

+ (void)hideDoneButton {
	NSArray* a = [[UIApplication sharedApplication] windows];
	if([a count] <= 1) return;
	
	UIWindow* tempWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:1];
    UIView* keyboard;
    for(int i=0; i<[tempWindow.subviews count]; i++) {
        keyboard = [tempWindow.subviews objectAtIndex:i];
        // keyboard view found; add the custom button to it
		if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 3.2) {
			if([[keyboard description] hasPrefix:@"<UIPeripheralHost"] == YES){
				UIButton *doneButton = (UIButton *)[keyboard viewWithTag:DONE_BUTTON_TAG];
				[doneButton removeFromSuperview];
			}
		} else {
			if([[keyboard description] hasPrefix:@"<UIKeyboard"] == YES){
				UIButton *doneButton = (UIButton *)[keyboard viewWithTag:DONE_BUTTON_TAG];
				[doneButton removeFromSuperview];
			}
		}
    }
}

#pragma mark -
#pragma mark saving dictionary to the iphone...
+ (BOOL)writeDictionary:(NSDictionary *)dict toFile:(NSString *)fileName {
	[dict retain];
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
  	NSString *writablePath = [documentsDirectory stringByAppendingFormat:@"/%@",fileName];
	BOOL ret = [dict writeToFile:writablePath atomically:YES];
	[dict release];
	return ret;
}

+ (NSMutableDictionary *)getDictionaryFromFile:(NSString *)fileName {
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
  	NSString *writablePath = [documentsDirectory stringByAppendingFormat:@"/%@",fileName];
	return [NSMutableDictionary dictionaryWithContentsOfFile:writablePath];
}

#pragma mark -
#pragma mark Email validation check
+ (BOOL) validateEmailWithString:(NSString*)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"; 
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex]; 
    return [emailTest evaluateWithObject:email];
}

+ (BOOL) validateEmailId:(NSString*)email forPattern:(NSString*) pattern {
	if([CommonUtils isVoid:pattern]){
		return [CommonUtils validateEmailWithString:email];
	} else {
		NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern]; 
		return [emailTest evaluateWithObject:email];
	}
}

#pragma mark -
#pragma mark hex to rgb converter...
+(UIColor*) getRGBColorFromHexCode:(NSString*) hexCode {
	unsigned int c;
	if ([hexCode characterAtIndex:0] == '#') {
		[[NSScanner scannerWithString:[hexCode substringFromIndex:1]] scanHexInt:&c];
	} else {
		[[NSScanner scannerWithString:hexCode] scanHexInt:&c];
	}
	return [UIColor colorWithRed:((c & 0xff0000) >> 16)/255.0 green:((c & 0xff00) >> 8)/255.0 blue:(c & 0xff)/255.0 alpha:1.0];
}

#pragma mark Device Capability Checks
+(BOOL) canDeviceMakePhoneCalls
{
	 if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tel://"]])
		 return YES;
	else 
		return NO;
}

+ (UIImageView*) setCellBackgroundImage:(NSString*) imageName
{
	UIImageView* iV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
	return iV;
}



+ (UILabel*) initEmptyPEScreenLabelWithString:(NSString*) labelText
{
	UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(20,150, 280, 30)];
	label.text = labelText;
	label.font = [UIFont boldSystemFontOfSize:20];
//	label.textAlignment = UITextAlignmentCenter;
	label.textColor = [UIColor darkGrayColor];
	return label;
}

+(void) dismissAllOpenAlertViews {
	for (UIWindow* window in [UIApplication sharedApplication].windows) {
		NSArray* subviews = window.subviews;
		if ([subviews count] > 0) {
			if ([[subviews objectAtIndex:0] isKindOfClass:[UIAlertView class]]) {
				[(UIAlertView *)[subviews objectAtIndex:0] dismissWithClickedButtonIndex:[(UIAlertView *)[subviews objectAtIndex:0] cancelButtonIndex] animated:NO];
			}
		}
	}	
}
+ (NSString*) dateAsString:(NSDate*) date
{
	//	NSDate* date = [self.userDetailsArray objectAtIndex:4] ;
	NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
	//[dateFormatter setDateFormat:@"dd/MM/yyyy"];
	[dateFormatter setDateFormat:@"yyyy-MM-dd"];
	NSString *strDate = [dateFormatter stringFromDate:date];
	//	NSLog(@"%@", strDate);
	[dateFormatter autorelease];
	return strDate;
}

@end
