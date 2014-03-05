#import "GlobalMemory.h"
#import "CommonUtils.h"
#define kAppPreferencesFileName	@"AppPreferences.plist"

@interface GlobalMemory (Private)
///Stores the in-memory object.
-(void) storeMemoryObject: (id) obj forKey: (id) key; 
///Returns the in-memory object.
-(id) fetchMemoryObjectForKey: (id) key;
///Stores an object for the specified key.
-(void) storeObject: (id) obj forKey: (id) key;
///Returns an object for the specified key.
-(id) fetchObjectForKey: (id) key;
///Commits the changes to phone.
-(void) commit;
///Sets if demo mode.
-(void) setDemo: (BOOL) b;
///Returns if demo mode.
-(BOOL) getDemo;
///Resets the stored contents.
-(void) resetDict;
@end

@implementation GlobalMemory

static GlobalMemory *instance = nil;
@synthesize sessionId;


+ (GlobalMemory*)getInstance {
    @synchronized(self) {
        if (instance == nil) {
            [[self alloc] init]; 
        }
    }
    return instance;
}

+ (id)allocWithZone:(NSZone *)zone {
    @synchronized(self) {
        if (instance == nil) {
            instance = [super allocWithZone:zone];
            return instance;  // assignment and return on first allocation
        }
    }
    return nil; //on subsequent allocation attempts return nil
}

- (id)copyWithZone:(NSZone *)zone {
    return self;
}

- (id)retain {
    return self;
}

- (unsigned)retainCount {
    return UINT_MAX;  //denotes an object that cannot be released
}

//- (void)release {
//    //do nothing
//}

- (id)autorelease {
    return self;
}

// setup the data collection
- init {
	if (self = [super init]) {
		//[self setupProductList]; any initialization
	}
	return self;
}

+(void) setObject: (id) obj forKey: (id) key {
	[[GlobalMemory getInstance] storeObject:obj forKey:key];
}

+(id) objectForKey: (id) key {
	return [[GlobalMemory getInstance] fetchObjectForKey:key];
}

+(NSString *)stringObjectForKey:(id)key {
	NSString *obj = [[GlobalMemory getInstance] fetchObjectForKey:key];
	return (obj==nil ? @"" : obj);
}

+(void) setMemoryObject: (id) obj forKey: (id) key {
	[[GlobalMemory getInstance] storeMemoryObject:obj forKey:key];
}

+(id) memoryObjectForKey: (id) key {
	return [[GlobalMemory getInstance] fetchMemoryObjectForKey:key];
}

+(NSString *)stringMemoryObjectForKey:(id)key {
	NSString *obj = [[GlobalMemory getInstance] fetchMemoryObjectForKey:key];
	return (obj==nil ? @"" : obj);
}

+(void) commit {
	[[GlobalMemory getInstance] commit];
}	

+(BOOL) isDemoMode {
	return [[GlobalMemory getInstance] getDemo];
}	

+(void) setDemoMode:(BOOL) b {
	[[GlobalMemory getInstance] setDemo:b];
}	

+(void) reset {
	[[GlobalMemory getInstance] resetDict];	
}	

//private functions
-(void) setDemo: (BOOL) b {
	demoMode = b;
}

-(void) resetDict {
	[mainDictionary removeAllObjects];
	[self commit];
}

-(BOOL) getDemo {
	return demoMode;
}


+(NSString*) getSessionId{
	return @"";//sessionId;
}

-(void) storeObject: (id) obj forKey: (id) key {
	if (mainDictionary == nil)
		mainDictionary = [NSMutableDictionary new];
	if(obj == nil)
		[mainDictionary removeObjectForKey:key];
	else
		[mainDictionary setObject:obj forKey:key];
	[self commit];
}

-(id) fetchObjectForKey: (id) key {
	if (mainDictionary == nil ) {
		mainDictionary = [[CommonUtils getDictionaryFromFile:kAppPreferencesFileName] retain];
		if (mainDictionary == nil ) {//this has never been initialized. so create a dictionary and store it so we know that one exists
			mainDictionary = [[NSMutableDictionary  dictionaryWithObject:[NSDate date] forKey:@"FileCreateDate"] retain];
			[self commit];
		}
	}
	return [mainDictionary objectForKey:key];
}

-(void) storeMemoryObject: (id) obj forKey: (id) key {
	if (inMemoryDictionary == nil)
		inMemoryDictionary = [NSMutableDictionary new];
	if(obj == nil)
		[inMemoryDictionary removeObjectForKey:key];
	else
		[inMemoryDictionary setObject:obj forKey:key];
}

-(id) fetchMemoryObjectForKey: (id) key {
	if (inMemoryDictionary == nil ) {
		return nil;
	}
	return [inMemoryDictionary objectForKey:key];
}

-(void) commit {
	[CommonUtils writeDictionary:mainDictionary toFile:kAppPreferencesFileName]; //should it be commited everytime?
}

- (void)dealloc {
	[mainDictionary release];
	[sessionId release];
	[super dealloc];
}

@end