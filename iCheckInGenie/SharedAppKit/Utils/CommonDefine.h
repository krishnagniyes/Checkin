//
//  CoomonsDefine.h
//  eat24houre
//
//  Created by Krishna Gupta on 22/07/11.
//  Copyright 2011 Mindfire Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kUDID_SessionId [[UIDevice currentDevice] uniqueIdentifier]
#define kAppDeligate (JumpDatesAppDelegate*)[[UIApplication sharedApplication] delegate];

///BaseUrls

#define kBaseRequestUrlForLogin @"http://mobile.jumpdates.com/apis/?"
#define KSearchURL @"http://mobile.jumpdates.com/apis/?api=search&device=iphone&gender="
#define KMessageURL @"http://mobile.jumpdates.com/apis/?api=message&device=iphone&id="
#define KActivitiesURL @"http://mobile.jumpdates.com/apis/?api=activities&device=iphone&id="
#define KUserProfileURL @"http://mobile.jumpdates.com/apis/?api=profile&device=iphone&id="
#define KSendMessageBaseURL @"http://mobile.jumpdates.com/apis/?api=reply&device=iphone&id="

#define KStatesListURL @"http://mobile.jumpdates.com/apis/?api=state&device=iphone"

#define kAppPreferencesFileName	@"AppPreferences.plist"
#define kConsumerKey		@"9ruzb97oga4ookosos8c8c4go0ccs44"
#define kConsumerSecret		@"384ue515tmaskccg0040kkw4wwk4kkg"
#define kSessionIdKey		@"SessionId"

#define kMyFavoriteDirectory @"MyFavorite"
#define kMyReceiptDirectory @"MyReceipt"
#define kMyBookingDirectory @"MyBooking"

/// Maximum Restarant Limit

#define kMaxCountForRestaurantSearchResult @"500"

#pragma -
#pragma Base API Urls

#define kRestaurants_By_Address_Base_Url @"http://api.eat24hours.com/rest/restaurants.by_address?"
#define kRestaurants_Menues_Request_Url @"http://api.eat24hours.com/rest/restaurant.menus?"
#pragma -
#pragma oAuthParams Urls

#define kRestaurants_By_Address_oAuthParam @"oauth_consumer_key=9ruzb97oga4ookosos8c8c4go0ccs44&oauth_nonce=9D1C8FCD-6C65-4BFD-BBA3-CBAAAF4FA6DA&oauth_signature_method=HMAC-SHA1&oauth_timestamp=1312309694&oauth_version=1.0&oauth_signature=oNJR9aRZ7Z%2BsCv2%2FuQAumUHvMoM%3D"




