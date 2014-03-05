
#import <Foundation/Foundation.h>

/**
 Utility for maintaining in-memory and on-phone objects.
 */
@interface GlobalMemory : NSObject {
	NSMutableDictionary *mainDictionary;
	NSMutableDictionary *inMemoryDictionary;
	NSString* sessionId;
	
	BOOL demoMode;
}

///Wiil keep the session Id in UserDefaults
@property(nonatomic, retain) 	NSString* sessionId;

+(NSString*) getSessionId;


///Stores the object under specified key.
+(void) setObject: (id) obj forKey: (id) key;
///Returns the object under specified key.
+(id) objectForKey: (id) key;
///Returns the string object under specified key.
+(NSString *)stringObjectForKey:(id)key;

///Stores an in-memory object for specified key.
+(void) setMemoryObject: (id) obj forKey: (id) key;
///returns an in-memory object for the specified key.
+(id) memoryObjectForKey: (id) key;
///returns the string value of an inmemory object for the specified key.
+(NSString *)stringMemoryObjectForKey:(id)key;

///Commits the changes into phone.
+(void) commit;
///Sets demo mode to true.
+(void) setDemoMode:(BOOL) b;
///Returns if demo mode.
+(BOOL) isDemoMode;
///Reset all stored information.
+(void) reset;

@end
