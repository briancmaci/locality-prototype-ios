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

@end
