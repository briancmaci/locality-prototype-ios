//
//  MapBoxManager.h
//  locality
//
//  Created by Brian Maci on 6/12/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mapbox-iOS-SDK/MapBox.h>

@interface MapBoxManager : NSObject <RMMapViewDelegate>

@property (strong, nonatomic) RMMapboxSource *tileSource;
@property (nonatomic) float currentRange;

+(MapBoxManager *)sharedInstance;

+(void) initMapBox;

+(void) drawRangeCircleAt:(CLLocationCoordinate2D)center rangeDiameter:(float)range onMap:(RMMapView*)map;
+(void) animateToPosition:(CLLocationCoordinate2D)center onMap:(RMMapView *)map;


@end
