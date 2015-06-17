//
//  GoogleMapsManager.h
//  locality
//
//  Created by Brian Maci on 5/14/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GoogleMaps/GoogleMaps.h>
#import "CallbackManager.h"

@interface GoogleMapsManager : CallbackManager

+(void) initGoogleMaps;
+(void) reverseGeocodeCoordinate:(CLLocationCoordinate2D)coordinate success:(successBlock)successBlock failure:(failureBlock)failureBlock;

//+(void) drawRangeCircleAt:(CLLocationCoordinate2D)center rangeDiameter:(float)range onMap:(GMSMapView*)map;
//+(void) animateToPosition:(CLLocationCoordinate2D)center onMap:(GMSMapView *)map;
@end
