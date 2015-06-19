//
//  DataManager.h
//  locality
//
//  Created by Brian Maci on 6/3/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
#import "FeedLocationModel.h"
#import "PostModel.h"

@interface DataManager : NSObject

+(void) parseUserDataIntoModel:(PFUser *)me;

+(NSDictionary *) parseFeedModelIntoDictionary:(FeedLocationModel *)feed;
+(PFObject *)parsePostModelIntoParseObject:(PostModel *)post;

@end
