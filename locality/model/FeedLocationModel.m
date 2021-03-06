//
//  FeedLocationModel.m
//  locality
//
//  Created by Brian Maci on 5/13/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import "FeedLocationModel.h"
#import "config.h"

@implementation FeedLocationModel

-(id) initWithLocation:(CLLocationCoordinate2D)center andName:(NSString *)name {
    
    self = [super init];
    
    if(self) {
        _promotionsEnabled = YES;
        _pushEnabled = YES;
        _importantEnabled = YES;
        
        _latitude = center.latitude;
        _longitude = center.longitude;
        
        _name = name;
        _location = @"";
        _imgUrl = DEFAULT_FEED_IMAGE;
        
        _isCurrentLocationFeed = NO;
    }
    
    return self;

}

@end
