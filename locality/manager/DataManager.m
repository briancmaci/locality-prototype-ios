//
//  DataManager.m
//  locality
//
//  Created by Brian Maci on 6/3/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import "DataManager.h"
#import "UserModel.h"
#import "FeedLocationModel.h"
#import "config.h"

@implementation DataManager

+(void) parseUserDataIntoModel:(PFUser *)me {
    
    //username
    [UserModel sharedInstance].username = [me objectForKey:@"username"];
    
    //current location
    [UserModel sharedInstance].currentLocation = [DataManager parseFeedDataIntoModel:[me objectForKey:@"currentLocation"]];
    
    //pinned locations
    NSMutableArray *pinnedFeedArrayRaw = [me objectForKey:@"pinnedLocations"];
    
    for( int i = 0; i < [pinnedFeedArrayRaw count]; i++ ) {
        [[UserModel sharedInstance].pinnedLocations addObject:[DataManager parseFeedDataIntoModel:[pinnedFeedArrayRaw objectAtIndex:i]]];
    }
    
    //first time
    [UserModel sharedInstance].isFirstTime = [[me objectForKey:@"isFirstTime"] boolValue];
    
    //user status
    [UserModel sharedInstance].userStatus = [[me objectForKey:@"userStatus"] intValue];
    
    //image
    [UserModel sharedInstance].profileImgUrl = [me objectForKey:@"profileImageUrl"];
    
}

+(FeedLocationModel *)parseFeedDataIntoModel:(NSDictionary *)rawFeed {
    CLLocationCoordinate2D here = CLLocationCoordinate2DMake([[rawFeed objectForKey:@"latitude"] doubleValue], [[rawFeed objectForKey:@"longitude"] doubleValue]);
    
    FeedLocationModel *parsedFeed = [[FeedLocationModel alloc] initWithLocation:here andName:[rawFeed objectForKey:@"name"]];
    
    //get the rest of the data
    parsedFeed.imgUrl = [rawFeed objectForKey:@"imgUrl"];
    parsedFeed.location = [rawFeed objectForKey:@"location"];
    parsedFeed.range = [[rawFeed objectForKey:@"range"] floatValue];
    
    parsedFeed.promotionsEnabled = [[rawFeed objectForKey:@"promotionsEnabled"] boolValue];
    parsedFeed.importantEnabled = [[rawFeed objectForKey:@"importantEnabled"] boolValue];
    parsedFeed.pushEnabled = [[rawFeed objectForKey:@"pushEnabled"] boolValue];
    
    return parsedFeed;
}

+(NSDictionary *)parseFeedModelIntoDictionary:(FeedLocationModel *)feed {
    
    return @{ kName : feed.name,
              kLocationLabel : feed.location,
              kImgUrl : feed.imgUrl,
              kLatitude : [[NSNumber alloc] initWithDouble:feed.latitude],
              kLongitude : [[NSNumber alloc] initWithDouble:feed.longitude],
              kRange : [[NSNumber alloc] initWithFloat:feed.range],
              kPromotionsEnabled : @(feed.promotionsEnabled),
              kPushEnabled : @(feed.pushEnabled),
              kImportantEnabled : @(feed.importantEnabled)
            };
}

+(PFObject *)parsePostModelIntoParseObject:(PostModel *)post {
    
    //Create geopoint
    PFGeoPoint *postCoord = [[PFGeoPoint alloc] init];
    postCoord.latitude = post.latitude;
    postCoord.longitude = post.longitude;
    
    PFObject *newPost = [[PFObject alloc] initWithClassName:kPostsTable];
    newPost[kProfileName] = post.username;
    newPost[kProfileImgUrl] = post.profileImgUrl;
    newPost[kCaption] = post.postCaption;
    newPost[kPostLocation] = postCoord;
    newPost[kPostImgUrl] = post.postImgUrl;
    
    return newPost;
}

@end
