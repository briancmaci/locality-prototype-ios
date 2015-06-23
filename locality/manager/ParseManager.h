//
//  ParseManager.h
//  locality
//
//  Created by Brian Maci on 5/13/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
#import "FeedLocationModel.h"
#import "PostModel.h"
#import "SortByModel.h"
#import "CallbackManager.h"

@interface ParseManager : CallbackManager

+(void) initParse;

//authentication + signup
+(void) signupUserViaEmail:(NSString *)email username:(NSString *)username password:(NSString *)password success:(successBlock)successBlock failure:(failureBlock)failureBlock;
+(void) loginViaUsername:(NSString *)username password:(NSString *)password success:(successBlock)successBlock failure:(failureBlock)failureBlock;
+(void) signupUserViaFacebookWithUsername:(NSString *)username success:(successBlock)successBlock failure:(failureBlock)failureBlock;
+(void) loginViaFacebook:(successBlock)successBlock failure:(failureBlock)failureBlock;


//queries
+(void) isValidUsername:(NSString *)username success:(successBlock)successBlock failure:(failureBlock)failureBlock;
+(void) getPostsWithinRange:(float)rangeInFeet atCoordinate:(CLLocationCoordinate2D)center sortedBy:(SortByType)sortByType success:(successBlock)successBlock failure:(failureBlock)failureBlock;

//posts
+(void) updateCurrentFeed:(FeedLocationModel *)currentFeed success:(successBlock)successBlock failure:(failureBlock)failureBlock;
+(void) addNewPinnedLocation:(FeedLocationModel *)pinnedFeed success:(successBlock)successBlock failure:(failureBlock)failureBlock;
+(void) addNewPost:(PostModel *)post success:(successBlock)successBlock failure:(failureBlock)failureBlock;
@end
