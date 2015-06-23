//
//  MapBoxManager.h
//  locality
//
//  Created by Brian Maci on 6/12/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mapbox-iOS-SDK/MapBox.h>

@protocol MapBoxManagerDelegate <NSObject>

-(void) onMapTapped:(CLLocationCoordinate2D)center;

@end

@interface MapBoxManager : NSObject <RMMapViewDelegate>

@property (weak, nonatomic) id<MapBoxManagerDelegate> delegate;

@property (strong, nonatomic) RMMapboxSource *tileSource;
@property (nonatomic) float currentRange;

+(MapBoxManager *)sharedInstance;

+(void) initMapBox;
+(void) setCurrentMapDelegate:(RMMapView *)map;

+(void) drawRangeCircleAt:(CLLocationCoordinate2D)center rangeDiameter:(float)range onMap:(RMMapView*)map;
+(void) animateToPosition:(CLLocationCoordinate2D)center onMap:(RMMapView *)map;
+(CLLocationCoordinate2D) translateCoordinate:(CLLocationCoordinate2D)coordinate withMetersLat:(double)metersLat metersLong:(double)metersLong;

@end
