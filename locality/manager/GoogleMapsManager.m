//
//  GoogleMapsManager.m
//  locality
//
//  Created by Brian Maci on 5/14/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import "GoogleMapsManager.h"
#import "config.h"
#import "AppUtilities.h"

@implementation GoogleMapsManager

#define EARTH_RADIUS 6378.1
#define EARTH_BEARING 1.57
#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)
#define RADIANS_TO_DEGREES(radians) ((radians) * (180.0 / M_PI))

//static const float

+(void) initGoogleMaps {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Info" ofType:@"plist"];
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
    NSString *apiKey = [dict objectForKey:GOOGLE_MAPS_API_KEY];
    NSLog(@"init googlemaps with: %@", apiKey);
    
    [GMSServices provideAPIKey:apiKey];
}

+(void) drawRangeCircleAt:(CLLocationCoordinate2D)center rangeDiameter:(float)range onMap:(GMSMapView*)map {

    [map clear];
    
    GMSCircle *rangeCircle = [GMSCircle circleWithPosition:center radius:range/2];
    
    rangeCircle.fillColor = [UIColor colorWithRed:0 green:122.0f/255.0f blue:1 alpha:0.2];
    rangeCircle.strokeColor = [UIColor colorWithRed:0 green:122.0f/255.0f blue:1 alpha:0.4];
    rangeCircle.strokeWidth = 1;
    rangeCircle.map = map;
    
    //move and center map around radius translated from map points to non-cartesian bounds
    float latCenter = DEGREES_TO_RADIANS(center.latitude);
    float longCenter = DEGREES_TO_RADIANS(center.longitude);
    float radiusInKM = [AppUtilities feetToMeters:(range/2)]/100;
    
    float latNE = asin(sin(latCenter)*cos(radiusInKM/EARTH_RADIUS) + cos(latCenter)*sin(radiusInKM/EARTH_RADIUS) * cos(EARTH_BEARING));
    float longNE= longCenter + atan2((sin(EARTH_BEARING) * sin(radiusInKM/EARTH_RADIUS) * cos(longCenter)), (cos(radiusInKM/EARTH_RADIUS) - sin(latNE)));
    
    latNE = RADIANS_TO_DEGREES(latNE);
    longNE = RADIANS_TO_DEGREES(longNE);
    
    float latSW = asin(sin(latCenter)*cos(-radiusInKM/EARTH_RADIUS) + cos(latCenter)*sin(-radiusInKM/EARTH_RADIUS) * cos(EARTH_BEARING));
    float longSW= longCenter + atan2((sin(EARTH_BEARING) * sin(-radiusInKM/EARTH_RADIUS) * cos(longCenter)), (cos(-radiusInKM/EARTH_RADIUS) - sin(latSW)));
    
    latSW = RADIANS_TO_DEGREES(latSW);
    longSW = RADIANS_TO_DEGREES(longSW);
    
    
    //NSLog(@"lat: %f, long: %f", latNE, longNE);
    
    CLLocationCoordinate2D northeast = CLLocationCoordinate2DMake(latNE, longNE);
    CLLocationCoordinate2D southwest = CLLocationCoordinate2DMake(latSW, longSW);
    
    GMSCoordinateBounds *bounds = [[GMSCoordinateBounds alloc] initWithCoordinate:southwest coordinate:northeast];
    GMSCameraUpdate *camUpdate = [GMSCameraUpdate fitBounds:bounds];
    
    [map animateWithCameraUpdate:camUpdate];
}

@end
