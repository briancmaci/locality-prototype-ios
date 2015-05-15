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
//    for(GMSCircle *circle in map.layer) {
//        circle.map = nil;
//    }
    
    GMSCircle *rangeCircle = [GMSCircle circleWithPosition:center radius:range/2];
    
    rangeCircle.fillColor = [UIColor colorWithRed:0.25 green:0 blue:0 alpha:0.05];
    rangeCircle.strokeColor = [UIColor colorWithRed:0.25 green:0 blue:0 alpha:1];
    rangeCircle.strokeWidth = 1;
    rangeCircle.map = map;
    
    //move and center map
    //test pin
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
    
    
    NSLog(@"lat: %f, long: %f", latNE, longNE);
    
    CLLocationCoordinate2D northeast = CLLocationCoordinate2DMake(latNE, longNE);
    CLLocationCoordinate2D southwest = CLLocationCoordinate2DMake(latSW, longSW);
    
    //GMSMarker *marker = [GMSMarker markerWithPosition:northeast];
    //GMSMarker *markerSW = [GMSMarker markerWithPosition:southwest];
    
    //marker.title = @"NORTHEAST";
    //marker.map = map;
    //markerSW.map = map;
    
    GMSCoordinateBounds *bounds = [[GMSCoordinateBounds alloc] initWithCoordinate:southwest coordinate:northeast];
    GMSCameraUpdate *camUpdate = [GMSCameraUpdate fitBounds:bounds];
    
    //[map moveCamera:camUpdate];
    [map animateWithCameraUpdate:camUpdate];
}

//-(CLLocationCoordinate2D)boundsWithCenterAndLatLngDistance:(CLLocationCoordinate2D):center latDistance:(float)latDistanceInMeters, float lngDistanceInMeters) {
//    latDistanceInMeters /= 2;
//    lngDistanceInMeters /= 2;
//    LatLngBounds.Builder builder = LatLngBounds.builder();
//    float[] distance = new float[1];
//    {
//        boolean foundMax = false;
//        double foundMinLngDiff = 0;
//        double assumedLngDiff = ASSUMED_INIT_LATLNG_DIFF;
//        do {
//            Location.distanceBetween(center.latitude, center.longitude, center.latitude, center.longitude + assumedLngDiff, distance);
//            float distanceDiff = distance[0] - lngDistanceInMeters;
//            if (distanceDiff < 0) {
//                if (!foundMax) {
//                    foundMinLngDiff = assumedLngDiff;
//                    assumedLngDiff *= 2;
//                } else {
//                    double tmp = assumedLngDiff;
//                    assumedLngDiff += (assumedLngDiff - foundMinLngDiff) / 2;
//                    foundMinLngDiff = tmp;
//                }
//            } else {
//                assumedLngDiff -= (assumedLngDiff - foundMinLngDiff) / 2;
//                foundMax = true;
//            }
//        } while (Math.abs(distance[0] - lngDistanceInMeters) > lngDistanceInMeters * ACCURACY);
//        LatLng east = new LatLng(center.latitude, center.longitude + assumedLngDiff);
//        builder.include(east);
//        LatLng west = new LatLng(center.latitude, center.longitude - assumedLngDiff);
//        builder.include(west);
//    }
//    {
//        boolean foundMax = false;
//        double foundMinLatDiff = 0;
//        double assumedLatDiffNorth = ASSUMED_INIT_LATLNG_DIFF;
//        do {
//            Location.distanceBetween(center.latitude, center.longitude, center.latitude + assumedLatDiffNorth, center.longitude, distance);
//            float distanceDiff = distance[0] - latDistanceInMeters;
//            if (distanceDiff < 0) {
//                if (!foundMax) {
//                    foundMinLatDiff = assumedLatDiffNorth;
//                    assumedLatDiffNorth *= 2;
//                } else {
//                    double tmp = assumedLatDiffNorth;
//                    assumedLatDiffNorth += (assumedLatDiffNorth - foundMinLatDiff) / 2;
//                    foundMinLatDiff = tmp;
//                }
//            } else {
//                assumedLatDiffNorth -= (assumedLatDiffNorth - foundMinLatDiff) / 2;
//                foundMax = true;
//            }
//        } while (Math.abs(distance[0] - latDistanceInMeters) > latDistanceInMeters * ACCURACY);
//        LatLng north = new LatLng(center.latitude + assumedLatDiffNorth, center.longitude);
//        builder.include(north);
//    }
//    {
//        boolean foundMax = false;
//        double foundMinLatDiff = 0;
//        double assumedLatDiffSouth = ASSUMED_INIT_LATLNG_DIFF;
//        do {
//            Location.distanceBetween(center.latitude, center.longitude, center.latitude - assumedLatDiffSouth, center.longitude, distance);
//            float distanceDiff = distance[0] - latDistanceInMeters;
//            if (distanceDiff < 0) {
//                if (!foundMax) {
//                    foundMinLatDiff = assumedLatDiffSouth;
//                    assumedLatDiffSouth *= 2;
//                } else {
//                    double tmp = assumedLatDiffSouth;
//                    assumedLatDiffSouth += (assumedLatDiffSouth - foundMinLatDiff) / 2;
//                    foundMinLatDiff = tmp;
//                }
//            } else {
//                assumedLatDiffSouth -= (assumedLatDiffSouth - foundMinLatDiff) / 2;
//                foundMax = true;
//            }
//        } while (Math.abs(distance[0] - latDistanceInMeters) > latDistanceInMeters * ACCURACY);
//        LatLng south = new LatLng(center.latitude - assumedLatDiffSouth, center.longitude);
//        builder.include(south);
//    }
//    return builder.build();
//}

@end
