//
//  config.h
//  locality
//
//  Created by Brian Maci on 5/13/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface config : NSObject

#define kLoggedInNotify @"loggedIn"

//API Keys in Info.plist
#define FLICKR_APP_KEY @"FlickrAppKey"
#define FLICKR_APP_SECRET @"FlickrAppSecret"

#define GOOGLE_MAPS_API_KEY @"GoogleMapsAPIKey"

#define PARSE_APP_ID @"ParseApplicationID"
#define PARSE_CLIENT_KEY @"ParseClientKey"

#define MAP_RANGES_IN_FEET @[{ "distance":500, "unit_label":"500", "unit":"ft"},{ "distance":750, "unit_label":"750", "unit":"ft"},{ "distance":1000, "unit_label":"1000", "unit":"ft"},{ "distance":1320, "unit_label":"0.25", "unit":"mi"},{ "distance":2640, "unit_label":"0.5", "unit":"mi"},{ "distance":5280, "unit_label":"1", "unit":"mi"},{ "distance":10560, "unit_label":"2", "unit":"mi"},{ "distance":26400, "unit_label":"5", "unit":"mi"},{ "distance":52800, "unit_label":"10", "unit":"mi"}]

@end
