//
//  FeedLocationModel.h
//  locality
//
//  Created by Brian Maci on 5/13/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface FeedLocationModel : NSObject

#define kCurrentFeedName @"_current"

#define kName @"name"
#define kLocationLabel @"location"

#define kImgUrl @"imgUrl"

#define kLatitude @"latitude"
#define kLongitude @"longitude"
#define kRange @"range"

#define kPromotionsEnabled @"promotionsEnabled"
#define kPushEnabled @"pushEnabled"
#define kImportantEnabled @"importantEnabled"

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *location;

@property (strong, nonatomic) NSString *imgUrl;

@property (nonatomic) double latitude;
@property (nonatomic) double longitude;
@property (nonatomic) float range;

//fill in additional feed options here
@property (nonatomic) BOOL promotionsEnabled;
@property (nonatomic) BOOL pushEnabled;
@property (nonatomic) BOOL importantEnabled;

-(id) initWithLocation:(CLLocationCoordinate2D)center andName:(NSString *)name;

@end
