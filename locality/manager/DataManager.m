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
    [UserModel sharedInstance].currentLocationFeed = [DataManager parseFeedDataIntoModel:[me objectForKey:@"currentLocation"]];
    
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

+(NSMutableArray *)parsePostFeedIntoModelArray:(NSArray *)rawPosts {
    
    NSMutableArray *modelsArray = [[NSMutableArray alloc] init];
    PFObject *post;
    
    for( int i = 0; i < [rawPosts count]; i++ ) {
        
        PostModel *p = [[PostModel alloc] init];
        post = (PFObject *)[rawPosts objectAtIndex:i];
        p.createdDate = post[@"createdAt"];
        p.user = [DataManager parseDictionaryIntoPostUser:post[kPostUser]];
        
        p.postImgUrl = post[kPostImgUrl];
        p.postId = post.objectId;
        p.postCaption = post[kCaption];
        
        //grab geopoint
        PFGeoPoint *ctr = post[kPostLocation];
        p.latitude = ctr.latitude;
        p.longitude = ctr.longitude;
        
        //likes
        p.likesCount = (int)[post[kLikes] count];
        p.isLikedByMe = [DataManager myLikeStatusWithArray:post[kLikes]];
        
        [modelsArray addObject:p];
    }
    
    return modelsArray;
}

+(BOOL)myLikeStatusWithArray:(NSArray *)likers {
    
    if( !likers || ![likers count] ) return NO;
    
    for( int i = 0; i < [likers count]; i++ ) {
        if ( [[likers objectAtIndex:i] isEqualToString:[PFUser currentUser].objectId] ) {
            return YES;
        }
    }
    
    return NO;
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

+(NSDictionary *) parsePostUserIntoDictionary:(PostUser *)user {
    return @{ kPostUserId : user.userId,
              kPostUserStatus : user.userStatus,
              kPostProfileImgUrl : user.profileImageUrl,
              kPostUsername : user.username
             };
}

+(PostUser *) parseDictionaryIntoPostUser:(NSDictionary *)dict {
    return [[PostUser alloc] initWithUserId:[dict objectForKey:kPostUserId] username:[dict objectForKey:kPostUsername] userStatus:[UserStatusModel statusTypeFromString:[dict objectForKey:kPostUserStatus]] andImgUrl:[dict objectForKey:kPostProfileImgUrl]];
}

+(PFObject *)parsePostModelIntoParseObject:(PostModel *)post {
    
    //Create geopoint
    PFGeoPoint *postCoord = [[PFGeoPoint alloc] init];
    postCoord.latitude = post.latitude;
    postCoord.longitude = post.longitude;
    
    PFObject *newPost = [[PFObject alloc] initWithClassName:kDBPost];
    newPost[kPostUser] = [DataManager parsePostUserIntoDictionary:post.user];
    newPost[kCaption] = post.postCaption;
    newPost[kPostLocation] = postCoord;
    newPost[kPostImgUrl] = post.postImgUrl;
    
    return newPost;
}

@end
