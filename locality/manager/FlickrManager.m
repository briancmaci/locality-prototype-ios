//
//  FlickrManager.m
//  locality
//
//  Created by Brian Maci on 5/14/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import "FlickrManager.h"
#import <FlickrKit/FlickrKit.h>
#import "config.h"

@implementation FlickrManager

+(void) initFlickr {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Info" ofType:@"plist"];
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
    NSString *appKey = [dict objectForKey:FLICKR_APP_KEY];
    NSString *appSecret = [dict objectForKey:FLICKR_APP_SECRET];
    NSLog(@"init flickr with: %@, %@", appKey, appSecret);
    
    [[FlickrKit sharedFlickrKit] initializeWithAPIKey:appKey sharedSecret:appSecret];
}

+(void) getImagesForLocation:(CLLocationCoordinate2D)center success:(successBlock)successBlock failure:(failureBlock)failureBlock {
    
    NSMutableArray __block *pictureObjects;
    NSMutableArray __block *pictureURLs;
    
    
//    [FlickrManager getFlickrPlaceIdForLocation:center success:^(id response) {
//        //success
//        
//        NSDictionary *firstPlace = [[[response objectForKey:@"places"] objectForKey:@"place"] objectAtIndex:0];
    
    NSMutableDictionary *flickrSearchParameters = [[NSMutableDictionary alloc] init];
    
    [flickrSearchParameters setValue:@"1" forKey:@"privacy_filter"];
    [flickrSearchParameters setValue:@"11" forKey:@"accuracy"];
    [flickrSearchParameters setValue:@"1" forKey:@"has_geo"];
    [flickrSearchParameters setValue:@"0" forKey:@"geo_context"];
    [flickrSearchParameters setValue:@"skyline" forKey:@"text"];
    [flickrSearchParameters setValue:@"1" forKey:@"content_type"];
    [flickrSearchParameters setValue:@"interestingness-desc" forKey:@"sort"];
    //[flickrSearchParameters setValue:[firstPlace objectForKey:@"place_id"] forKey:@"place_id"];
    [flickrSearchParameters setValue:[NSString stringWithFormat:@"%f", center.latitude] forKey:@"lat"];
    [flickrSearchParameters setValue:[NSString stringWithFormat:@"%f", center.longitude] forKey:@"lon"];
    
    
    [[FlickrKit sharedFlickrKit] call:@"flickr.photos.search" args:flickrSearchParameters maxCacheAge:FKDUMaxAgeOneDay completion:^(NSDictionary *response, NSError *error) {
        
        if(error) {
            NSLog(@"Flickr search error: %@", error);
            failureBlock(error);
        }
        
        else {
            NSLog(@"flickr response: %@", response);
            pictureObjects = [[response objectForKey:@"photos"] objectForKey:@"photo"];
            
            pictureURLs = [[NSMutableArray alloc] init];
            
            for( int i = 0; i < [pictureObjects count]; i++) {
                [pictureURLs addObject:[self getFlickrURL:[pictureObjects objectAtIndex:i]]];
                NSLog(@"url: %@", [self getFlickrURL:[pictureObjects objectAtIndex:i]]);
            }
            
            successBlock(pictureURLs);
        }
    }];
        
//    } failure:^(NSError *error) {
//        //places fail
//        failureBlock(error);
//    }];
}

+(void) getFlickrPlaceIdForLocation:(CLLocationCoordinate2D)center success:(successBlock)successBlock failure:(failureBlock)failureBlock {
    NSMutableDictionary *flickrSearchParameters = [[NSMutableDictionary alloc] init];
    
    [flickrSearchParameters setValue:[NSString stringWithFormat:@"%f", center.latitude] forKey:@"lat"];
    [flickrSearchParameters setValue:[NSString stringWithFormat:@"%f", center.longitude] forKey:@"lon"];
    [flickrSearchParameters setValue:@"6" forKey:@"accuracy"];
    
    [[FlickrKit sharedFlickrKit] call:@"flickr.places.findByLatLon" args:flickrSearchParameters maxCacheAge:FKDUMaxAgeOneDay completion:^(NSDictionary *response, NSError *error) {
        if(error) {
            NSLog(@"Flickr search places error: %@", error);
            failureBlock(error);
        }
        
        else {
            NSLog(@"flickr places response: %@", response);
            //pictureObjects = [[response objectForKey:@"photos"] objectForKey:@"photo"];
            
            //pictureURLs = [[NSMutableArray alloc] init];
            
//            for( int i = 0; i < [pictureObjects count]; i++) {
//                [pictureURLs addObject:[self getFlickrURL:[pictureObjects objectAtIndex:i]]];
//                NSLog(@"url: %@", [self getFlickrURL:[pictureObjects objectAtIndex:i]]);
//            }
            
            successBlock(response);
        }
    } ];
}

+(NSString *)getFlickrURL:(NSDictionary *)responseObject {
    NSDictionary *photo = responseObject;
    
    return [NSString stringWithFormat:@"https://farm%@.staticflickr.com/%@/%@_%@.jpg", [photo objectForKey:@"farm"], [photo objectForKey:@"server"], [photo objectForKey:@"id"], [photo objectForKey:@"secret"]];
}

@end
