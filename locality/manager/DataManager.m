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

@implementation DataManager

+(void) parseUserDataIntoModel:(PFUser *)me {
    
    //username
    [UserModel sharedInstance].username = [me objectForKey:@"username"];
    
    //current location
    [UserModel sharedInstance].currentLocation = [DataManager parseFeedDataIntoModel:[me objectForKey:@"currentLocation"]];
    
    //pinned locations
    
    //first time
    [UserModel sharedInstance].isFirstTime = [[me objectForKey:@"isFirstTime"] boolValue];
    
}

+(FeedLocationModel *)parseFeedDataIntoModel:(NSDictionary *)rawFeed {
    CLLocationCoordinate2D here = CLLocationCoordinate2DMake([[rawFeed objectForKey:@"latitude"] doubleValue], [[rawFeed objectForKey:@"longitude"] doubleValue]);
    
    FeedLocationModel *parsedFeed = [[FeedLocationModel alloc] initWithLocation:here andName:[rawFeed objectForKey:@"name"]];
    
    //get the rest of the data
    parsedFeed.imgUrl = [rawFeed objectForKey:@"imgUrl"];
    parsedFeed.range = [[rawFeed objectForKey:@"range"] floatValue];
    
    parsedFeed.promotionsEnabled = [[rawFeed objectForKey:@"promotionsEnabled"] boolValue];
    parsedFeed.importantEnabled = [[rawFeed objectForKey:@"importantEnabled"] boolValue];
    parsedFeed.pushEnabled = [[rawFeed objectForKey:@"pushEnabled"] boolValue];
    
    return parsedFeed;
}

@end
