




#define kEndPointURL @"http://50.62.149.51/DesktopModules/CheckinService/API/ICheckinEvents/"

///Service Names
#define kServiceLogin @"iCheckinOrganizerLogin?"
#define kGetEventListService @"GetEventList?DeviceID=%@&token=%@&OrganizerID=%@"
#define kGetEventDetail @"GetEventDetail?DeviceID=%@&token=%@&OrganizerID=%@&EventID=%@"

#define kUniqueDeviceID [[[UIDevice currentDevice] identifierForVendor] UUIDString]




#define kLogoutAlertTitle @"Are you sure you would like to Logout?"

#define kLogoutMessage @"The database will automatically sync before logging out"


#define kBackgroundColor_iPhone @"Default.png"
#define kBackgroundColor_iPad @"background.png"

//[self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]]];
