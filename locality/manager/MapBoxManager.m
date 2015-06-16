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

static NSString * const circleId = @"rangeCircle";
static NSString * const markerId = @"pinnedMarker";

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
    RMMapboxSource *interactiveSource = [[RMMapboxSource alloc] initWithMapID:mapID];
    [MapBoxManager sharedInstance].tileSource = interactiveSource;
}

+(void) setCurrentMapDelegate:(RMMapView *)map {
    map.delegate = [MapBoxManager sharedInstance];
}

+(void) drawRangeCircleAt:(CLLocationCoordinate2D)center rangeDiameter:(float)range onMap:(RMMapView*)map {
    
    [map removeAllAnnotations];
    
    map.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    // add circle
    RMAnnotation *annCircle = [[RMAnnotation alloc] initWithMapView:map
                                                         coordinate:map.centerCoordinate
                                                           andTitle:@""];
    annCircle.userInfo = circleId;
    
    RMAnnotation *annMarker = [[RMAnnotation alloc] initWithMapView:map
                                                         coordinate:map.centerCoordinate
                                                           andTitle:@""];
    
    annMarker.userInfo = markerId;
    
    [map addAnnotation:annCircle];
    [map addAnnotation:annMarker];

    map.centerCoordinate = center;

    CLLocationCoordinate2D rangePointSW = [MapBoxManager translateCoordinate:center withMetersLat:[AppUtilities feetToMeters:-range*2.2] metersLong:[AppUtilities feetToMeters:-range*2.2]];
    CLLocationCoordinate2D rangePointNE = [MapBoxManager translateCoordinate:center withMetersLat:[AppUtilities feetToMeters:range*2.2] metersLong:[AppUtilities feetToMeters:range*2.2]];
    [map zoomWithLatitudeLongitudeBoundsSouthWest:rangePointSW northEast:rangePointNE animated:YES];
}

+(CLLocationCoordinate2D) translateCoordinate:(CLLocationCoordinate2D)coordinate withMetersLat:(double)metersLat metersLong:(double)metersLong {
    CLLocationCoordinate2D tempCoord = coordinate;
    
    MKCoordinateRegion tempRegion = MKCoordinateRegionMakeWithDistance(coordinate, metersLat, metersLong);
    MKCoordinateSpan tempSpan = tempRegion.span;
    
    tempCoord.latitude = coordinate.latitude + tempSpan.latitudeDelta;
    tempCoord.longitude = coordinate.longitude + tempSpan.longitudeDelta;
    
    return tempCoord;
}

//+(void) setMarkerAtTouch:(CGPoint)touchPoint onMap:(RMMapView *)map {
//    map setCenterProjectedPoint:<#(RMProjectedPoint)#>
//}

+(void) animateToPosition:(CLLocationCoordinate2D)center onMap:(RMMapView *)map {
    [map setCenterCoordinate:center animated:YES];
    
}

#pragma mark - RMMapView Delegate Methods

- (RMMapLayer *)mapView:(RMMapView *)mapView layerForAnnotation:(RMAnnotation *)annotation
{
    RMMapLayer *annotationLayer;
    
    if (annotation.isUserLocationAnnotation)
        return nil;
    
    if( [annotation.userInfo isEqualToString:circleId] )
    {
        RMCircle *circle = [[RMCircle alloc] initWithView:mapView radiusInMeters:[MapBoxManager sharedInstance].currentRange/4];
        
        // style circle's line and fill color, and width.
        circle.lineColor = [UIColor mapCircleColor];
        circle.fillColor = [UIColor mapCircleColor];
        circle.lineWidthInPixels = 0;
        
        annotationLayer = circle;
    }
    
    else if( [annotation.userInfo isEqualToString:markerId])
    {
        RMMarker *marker = [[RMMarker alloc] initWithUIImage:[UIImage imageNamed:kMapMarkerHere]];
        annotationLayer = marker;
    }
    
    return annotationLayer;
}

- (void) singleTapOnMap:(RMMapView *)map at:(CGPoint)point {
    CLLocationCoordinate2D tappedLocation = CLLocationCoordinate2DMake([map pixelToCoordinate:point].latitude, [map pixelToCoordinate:point].longitude);
    
    if( [_delegate respondsToSelector:@selector(onMapTapped:)]) {
        [_delegate onMapTapped:tappedLocation];
    }
    //[MapBoxManager animateToPosition:tappedLocation onMap:map];
}

@end
