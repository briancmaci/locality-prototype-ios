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
#import <MapKit/MapKit.h>

@implementation GoogleMapsManager

+(void) initGoogleMaps {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Info" ofType:@"plist"];
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
    NSString *apiKey = [dict objectForKey:GOOGLE_MAPS_API_KEY];
    NSLog(@"init googlemaps with: %@", apiKey);
    
    [GMSServices provideAPIKey:apiKey];
}

+(void) drawRangeCircleAt:(CLLocationCoordinate2D)center rangeDiameter:(float)range onMap:(GMSMapView*)map {

    [map clear];
    
    GMSCircle *rangeCircle = [GMSCircle circleWithPosition:center radius:[AppUtilities feetToMeters:range/2]];
    
    rangeCircle.fillColor = [UIColor colorWithRed:1 green:125.0f/255.0f blue:108.0f/255.0f alpha:0.2];
    //rangeCircle.strokeColor = [UIColor colorWithRed:1 green:125.0f/255.0f blue:108.0f/255.0f alpha:0.2];
    rangeCircle.strokeWidth = 0;
    rangeCircle.map = map;
    
    CLLocationCoordinate2D rangePoint = [GoogleMapsManager translateCoordinate:center withMetersLat:[AppUtilities feetToMeters:range] metersLong:[AppUtilities feetToMeters:range]];
    GMSCoordinateBounds *bounds = [[GMSCoordinateBounds alloc] initWithCoordinate:center coordinate:rangePoint];
    GMSCameraUpdate *camUpdate = [GMSCameraUpdate fitBounds:bounds];
    
    GMSMarker *marker = [GMSMarker markerWithPosition:center];
    marker.icon = [UIImage imageNamed:kMapMarkerHere];
    marker.map = map;

    [map animateWithCameraUpdate:camUpdate];
    [map animateToLocation:center];
}

+(CLLocationCoordinate2D) translateCoordinate:(CLLocationCoordinate2D)coordinate withMetersLat:(double)metersLat metersLong:(double)metersLong {
    CLLocationCoordinate2D tempCoord = coordinate;
    
    MKCoordinateRegion tempRegion = MKCoordinateRegionMakeWithDistance(coordinate, metersLat, metersLong);
    MKCoordinateSpan tempSpan = tempRegion.span;
    
    tempCoord.latitude = coordinate.latitude + tempSpan.latitudeDelta;
    tempCoord.longitude = coordinate.longitude + tempSpan.longitudeDelta;
    
    return tempCoord;
}

+(void) animateToPosition:(CLLocationCoordinate2D)center onMap:(GMSMapView *)map {

    GMSCameraUpdate *camUpdate = [GMSCameraUpdate setTarget:center zoom:14];
    [map animateWithCameraUpdate:camUpdate];
}

+(void) reverseGeocodeCoordinate:(CLLocationCoordinate2D)coordinate success:(successBlock)successBlock failure:(failureBlock)failureBlock {
    GMSGeocoder *geocoder = [[GMSGeocoder alloc] init];
    
    [geocoder reverseGeocodeCoordinate:coordinate completionHandler:^(GMSReverseGeocodeResponse *response, NSError *error) {
        GMSAddress *address = response.firstResult;
        
        if(!error) {
            successBlock(address);
        }
        
        else {
            failureBlock(error);
        }
        
    }];
}


@end
