//
//  GoogleMapsManager.m
//  locality
//
//  Created by Brian Maci on 5/14/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import "GoogleMapsManager.h"
#import <Google-Maps-iOS-SDK/GoogleMaps.h>
#import "config.h"

@implementation GoogleMapsManager

+(void) initGoogleMaps {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Info" ofType:@"plist"];
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
    NSString *apiKey = [dict objectForKey:GOOGLE_MAPS_API_KEY];
    NSLog(@"init googlemaps with: %@", apiKey);
    
    [GMSServices provideAPIKey:apiKey];
}

@end
