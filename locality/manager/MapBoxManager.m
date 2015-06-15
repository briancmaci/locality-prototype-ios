//
//  MapBoxManager.m
//  locality
//
//  Created by Brian Maci on 6/12/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import "MapBoxManager.h"
#import "config.h"
#import "UIColor+LocalityColor.h"
#import <MapKit/MapKit.h>
#import "GoogleMapsManager.h"
#import "AppUtilities.h"

@implementation MapBoxManager

+ (MapBoxManager *)sharedInstance
{
    static MapBoxManager *sharedSingleton;
    
    @synchronized(self)
    {
        if (!sharedSingleton)
        {
            sharedSingleton = [[MapBoxManager alloc] init];
            sharedSingleton.currentRange = 0;
        }
        return sharedSingleton;
    }
}

+(void) initMapBox {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Info" ofType:@"plist"];
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
    NSString *accessToken = [dict objectForKey:MAP_BOX_ACCESS_TOKEN];
    NSString *mapID = [dict objectForKey:MAP_BOX_MAP_ID];
    NSLog(@"init mapbox with: %@", mapID);
    

    [[RMConfiguration sharedInstance] setAccessToken:accessToken];
    [MapBoxManager sharedInstance].tileSource = [[RMMapboxSource alloc  ]initWithMapID:mapID];
}

+(void) drawRangeCircleAt:(CLLocationCoordinate2D)center rangeDiameter:(float)range onMap:(RMMapView*)map {
    
    map.delegate = [MapBoxManager sharedInstance];
    
    [map removeAllAnnotations];
    
    map.autoresizingMask = UIViewAutoresizingFlexibleHeight |
    UIViewAutoresizingFlexibleWidth;
    
    // add callout title
    RMAnnotation *annotation = [[RMAnnotation alloc] initWithMapView:map
                                                          coordinate:map.centerCoordinate
                                                            andTitle:@"Coverage Area"];
    
    [map addAnnotation:annotation];
    
    // set zoom
    //map.zoom = 10;
    map.centerCoordinate = center;
//    //[map clear];
//    
//    GMSCircle *rangeCircle = [GMSCircle circleWithPosition:center radius:[AppUtilities feetToMeters:range/2]];
//    
//    rangeCircle.fillColor = [UIColor colorWithRed:1 green:125.0f/255.0f blue:108.0f/255.0f alpha:0.2];
//    //rangeCircle.strokeColor = [UIColor colorWithRed:1 green:125.0f/255.0f blue:108.0f/255.0f alpha:0.2];
//    rangeCircle.strokeWidth = 0;
//    rangeCircle.map = map;
//
    CLLocationCoordinate2D rangePointSW = [MapBoxManager translateCoordinate:center withMetersLat:[AppUtilities feetToMeters:-range*2.2] metersLong:[AppUtilities feetToMeters:-range*2.2]];
    CLLocationCoordinate2D rangePointNE = [MapBoxManager translateCoordinate:center withMetersLat:[AppUtilities feetToMeters:range*2.2] metersLong:[AppUtilities feetToMeters:range*2.2]];
    [map zoomWithLatitudeLongitudeBoundsSouthWest:rangePointSW northEast:rangePointNE animated:YES];
//    GMSCoordinateBounds *bounds = [[GMSCoordinateBounds alloc] initWithCoordinate:center coordinate:rangePoint];
//    GMSCameraUpdate *camUpdate = [GMSCameraUpdate fitBounds:bounds];
//    
//    GMSMarker *marker = [GMSMarker markerWithPosition:center];
//    marker.icon = [UIImage imageNamed:kMapMarkerHere];
//    marker.map = map;
//    
//    [map animateWithCameraUpdate:camUpdate];
//    [map animateToLocation:center];
}

+(CLLocationCoordinate2D) translateCoordinate:(CLLocationCoordinate2D)coordinate withMetersLat:(double)metersLat metersLong:(double)metersLong {
    CLLocationCoordinate2D tempCoord = coordinate;
    
    MKCoordinateRegion tempRegion = MKCoordinateRegionMakeWithDistance(coordinate, metersLat, metersLong);
    MKCoordinateSpan tempSpan = tempRegion.span;
    
    tempCoord.latitude = coordinate.latitude + tempSpan.latitudeDelta;
    tempCoord.longitude = coordinate.longitude + tempSpan.longitudeDelta;
    
    return tempCoord;
}

- (RMMapLayer *)mapView:(RMMapView *)mapView layerForAnnotation:(RMAnnotation *)annotation
{
    RMMapLayer *layer = [[RMMapLayer alloc] init];

    if (annotation.isUserLocationAnnotation)
        return nil;
    
    RMCircle *circle = [[RMCircle alloc] initWithView:mapView radiusInMeters:[MapBoxManager sharedInstance].currentRange/4];
    
    // style circle's line and fill color, and width.
    circle.lineColor = [UIColor mapCircleColor];
    circle.fillColor = [UIColor mapCircleColor];
    circle.lineWidthInPixels = 0;
    
    RMMarker *marker = [[RMMarker alloc] initWithUIImage:[UIImage imageNamed:kMapMarkerHere]];
    
    [circle addSublayer:marker];
    //[layer addSublayer:circle];
    //[layer addSublayer:marker];
    
    return circle;
}

@end
