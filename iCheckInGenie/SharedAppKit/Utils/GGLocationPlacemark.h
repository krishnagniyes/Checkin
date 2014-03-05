
#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface GGLocationPlacemark : NSObject <MKAnnotation>

- (id)initWithName:(NSString*)name address:(NSString*)address coordinate:(CLLocationCoordinate2D)coordinate;

@end
