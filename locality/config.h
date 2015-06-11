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

/* IOS VERSION DETECTION */
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

/* SCREEN DIMENSIONS */
#define DEVICE_WIDTH                                [[UIScreen mainScreen] bounds].size.width
#define DEVICE_HEIGHT                               [[UIScreen mainScreen] bounds].size.height

/* CONSTANTS MOST LIKELY TO BE DB DRIVEN FOR PRODUCTION */
#define SLIDER_STEPS_IN_FEET @[@{ @"distance":@500, @"unit_label":@"500", @"unit":@"ft"},@{ @"distance":@750, @"unit_label":@"750", @"unit":@"ft"},@{ @"distance":@1000, @"unit_label":@"1000", @"unit":@"ft"},@{ @"distance":@1320, @"unit_label":@"0.25", @"unit":@"mi"},@{ @"distance":@2640, @"unit_label":@"0.5", @"unit":@"mi"},@{ @"distance":@5280, @"unit_label":@"1", @"unit":@"mi"},@{ @"distance":@10560, @"unit_label":@"2", @"unit":@"mi"},@{ @"distance":@26400, @"unit_label":@"5", @"unit":@"mi"},@{ @"distance":@52800, @"unit_label":@"10", @"unit":@"mi"}]

#define FEED_SETTINGS @[@{ @"label":@"Send me push alerts from this location", @"default":@YES, @"var":@"pushEnabled"}, @{ @"label":@"Include promotions for this location", @"default":@NO, @"var":@"promotionsEnabled"}, @{ @"label":@"Send me push alerts from this location", @"default":@YES, @"var":@"pushEnabled"}, @{ @"label":@"Include promotions for this location", @"default":@NO, @"var":@"promotionsEnabled"}, @{ @"label":@"Would you like important alerts?", @"default":@YES, @"var":@"importantEnabled"}]



/* Storyboard IDs */
#define kLoginStoryboardId @"loginVC"
#define kCurrentFeedInitStoryboardId @"currentFeedInitVC"
#define kCurrentFeedStoryboardId @"mainFeedVC"
#define kFeedMenuStoryboardId @"feedMenuVC"

/* Fonts */
#define kMainFont @"InterstateLightCondensed"

/* CURRENT FEED DEFAULTS */
#define DEFAULT_FEED_IMAGE @"feed_default_hero"
#define FEED_HERO_HEIGHT 157.0f //adjusted 20px for the status bar

/* FEED SETTINGS DEFAULTS */
#define FEED_SETTINGS_OPTION_HEIGHT 44.0f

/* CUSTOM UI */
#define kSwitchSliderKnob @"ui_switch_knob"
#define kMapMarkerHere @"map_marker_here"

@end
