//
//  GoogleMapsManager.h
//  locality
//
//  Created by Brian Maci on 5/14/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Google-Maps-iOS-SDK/GoogleMaps.h>

@interface GoogleMapsManager : NSObject

+(void) initGoogleMaps;
+(void) drawRangeCircleAt:(CLLocationCoordinate2D)center rangeDiameter:(float)range onMap:(GMSMapView*)map;

@end
