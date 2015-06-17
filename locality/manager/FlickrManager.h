//
//  FlickrManager.h
//  locality
//
//  Created by Brian Maci on 5/14/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GoogleMaps/GoogleMaps.h>
#import "CallbackManager.h"

@interface FlickrManager : CallbackManager

+(void) initFlickr;
+(void) getImagesForLocation:(CLLocationCoordinate2D)center success:(successBlock)successBlock failure:(failureBlock)failureBlock;

@end
