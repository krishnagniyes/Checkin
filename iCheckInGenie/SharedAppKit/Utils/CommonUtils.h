
#import <Foundation/Foundation.h>

@interface CommonUtils : NSObject {

}

+(BOOL) isVoid:(id) obj;
+(BOOL) isEqual:(id) obj1 :(id) obj2;
+(NSArray*) getDemoDataFor:(NSString*) url;

+ (NSDictionary*) getDemoDataFromPList:(NSString*) url;


+(BOOL) isDebugMode;
+(void) logData:(id) obj;
+(void) logData:(id) obj withComments:(id) comments;
+(void) showSimpleAlertWithTitle:(NSString*) title andMessage:(NSString*) message;;
+ (void) startShrinkAnimationForTextField:(UITextField*) textField andTable: (UITableView *)parentTable;
+ (void) startExpandAnimationForTextField:(UITextField*) textField andTable: (UITableView *)parentTable;
+(NSString *)getPhoneNumberFromString:(NSString *)str;

+ (BOOL) validateEmailWithString:(NSString*)email;
+ (BOOL) validateEmailId:(NSString*)email forPattern:(NSString*) pattern;

//Adds "Done" button to the keypad with specified target and selector. This is used for numeric keypad.
+ (void)addDoneButtonToNumericKeypad:(id)aTarget withSelector:(SEL)aSelector;
//Hide the "Done" button inserted into numeric keypad.
+ (void)hideDoneButton;
//Sets Button Title for all states
+(void) setButton:(UIButton *) button title:(NSString *) title;
//Sets Button Title Color for all states
+(void) setButtonTitleColor:(UIButton *) button color:(UIColor *) color;

+ (BOOL)writeDictionary:(NSDictionary *)dict toFile:(NSString *)fileName;
+ (NSMutableDictionary *)getDictionaryFromFile:(NSString *)fileName;
+(void) setButton:(UIButton *) button image:(UIImage*) img;

+(UIColor*) getRGBColorFromHexCode:(NSString*) hexCode;

+(BOOL) canDeviceMakePhoneCalls;
+ (UIImageView*) setCellBackgroundImage:(NSString*) imageName;

+ (UILabel*) initEmptyPEScreenLabelWithString:(NSString*) labelText;

+(void) dismissAllOpenAlertViews;
+ (NSString*) dateAsString:(NSDate*) date;


@end
