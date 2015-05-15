//
//  FlickrManager.h
//  locality
//
//  Created by Brian Maci on 5/14/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Google-Maps-iOS-SDK/GoogleMaps.h>

@interface FlickrManager : NSObject

typedef void(^failureBlock)(NSError *error);
typedef void(^successBlock)(id response);

+(void) initFlickr;
+(void) getImagesForLocation:(CLLocationCoordinate2D)center success:(successBlock)successBlock failure:(failureBlock)failureBlock;

@end
