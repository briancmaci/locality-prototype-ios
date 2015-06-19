//
//  ParseManager.m
//  locality
//
//  Created by Brian Maci on 5/13/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import "ParseManager.h"
#import "DataManager.h"
#import "config.h"
#import "UserModel.h"
#import <ParseFacebookUtilsV4/PFFacebookUtils.h>
#import <Facebook-iOS-SDK/FBSDKCoreKit/FBSDKProfile.h>
#import <Facebook-iOS-SDK/FBSDKCoreKit/FBSDKGraphRequest.h>

@implementation ParseManager

static NSString * kDBUser = @"_User";

+(void) initParse {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Info" ofType:@"plist"];
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
    NSString *appID = [dict objectForKey:PARSE_APP_ID];
    NSString *clientKey = [dict objectForKey:PARSE_CLIENT_KEY];
    NSLog(@"init Parse with: %@, %@", appID, clientKey);
    
    [Parse setApplicationId:appID clientKey:clientKey];
    [PFUser enableRevocableSessionInBackground];
}

+(void) signupUserViaEmail:(NSString *)email username:(NSString *)username password:(NSString *)password success:(successBlock)successBlock failure:(failureBlock)failureBlock {
    
    PFUser *user = [PFUser user];
    
    user.username = username;
    user.email = email;
    user.password = password;
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            
            //Nothing to return. The act of the return continues with sign-up completion.
            successBlock(nil);
        } else {
            
            //Transmit error for future alerts, etc.
            failureBlock(error);
        }
    }];
}

+(void) loginViaUsername:(NSString *)username password:(NSString *)password success:(successBlock)successBlock failure:(failureBlock)failureBlock {
    [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser *user, NSError *error) {
        if (!error) {
            // Do stuff after successful login.
            
            successBlock(user);
        } else {
            // The login failed. Check error to see why.
            failureBlock(error);
        }
    }];

}

+(void) signupUserViaFacebookWithUsername:(NSString *)username success:(successBlock)successBlock failure:(failureBlock)failureBlock {
    
    NSArray *permissions = @[ @"email"];
    
    [PFFacebookUtils logInInBackgroundWithReadPermissions:permissions block:^(PFUser *user, NSError *error) {
        NSLog(@"PFFacebookUtils called");
        if (!user) {
            NSLog(@"Uh oh. The user cancelled the Facebook login.");
        } else if (user.isNew) {
            NSLog(@"User signed up and logged in through Facebook!");
            
            //add username
            user.username = username;
            
            if ([FBSDKAccessToken currentAccessToken]) {
                [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:nil]
                 startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
                     if (!error) {
                         NSLog(@"fetched user:%@", result);
                         
                         //We save the Facebook authenticated user email in a separate column of _User dB. Without email verification, we save this for future authentication needs and/or user contact list building.
                         user[@"facebookEmail"] = [result objectForKey:@"email"];
                         user[@"isFirstTime"] = @YES;
                         
                         [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                             if (!error) {
                                 successBlock(nil);
                             } else {
                                 failureBlock(error);
                             }
                         }];
                     }
                 }];
            }

        } else {
            NSLog(@"User logged in through Facebook!");
        }
    }];
}

+(void) loginViaFacebook:(successBlock)successBlock failure:(failureBlock)failureBlock {
    
    NSArray *permissions = @[ @"email"];
    
    [PFFacebookUtils logInInBackgroundWithReadPermissions:permissions block:^(PFUser *user, NSError *error) {
        NSLog(@"PFFacebookUtils called");
        if (!user) {
            failureBlock(error);
            NSLog(@"Uh oh. The user cancelled the Facebook login.");
        } else if (user.isNew) {
            NSLog(@"User signed up and logged in through Facebook!");
            NSLog(@"They should be redirected to signup");
            failureBlock(error);
        } else {
            NSLog(@"User logged in through Facebook!");
            
            if ([FBSDKAccessToken currentAccessToken]) {
                [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:nil]
                 startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
                     if (!error) {
                         
                         NSLog(@"[TO DO]: Set Facebook stuff here that we wish to save in UserModel from result %@", result);
                         successBlock(user);
                     }
                     
                     else {
                         failureBlock(error);
                     }
                 }];
            }
        }
    }];
}

#pragma mark - Parse Queries

//queries
+(void) isValidUsername:(NSString *)username success:(successBlock)successBlock failure:(failureBlock)failureBlock {
    PFQuery *query = [PFQuery queryWithClassName:kDBUser];
    [query whereKey:@"username" equalTo:username];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            
            //This return value should be of count 0 if we do not have a duplicate.
            return successBlock(objects);
            
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
            return failureBlock(error);
        }
    }];
}

+(void) updateCurrentFeed:(FeedLocationModel *)currentFeed success:(successBlock)successBlock failure:(failureBlock)failureBlock {
    
    //create parse-safe object
    NSDictionary *currentFeedParams = [DataManager parseFeedModelIntoDictionary:currentFeed];
    
    [PFUser currentUser][@"currentLocation"] = currentFeedParams;
    [PFUser currentUser][@"isFirstTime"] = @NO;
    
    [[PFUser currentUser] saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {   // Hooray! Let them use the app now.
            successBlock(nil);
        } else {   //NSString *errorString = [error userInfo][@"error"];   // Show the errorString somewhere and let the user try again.
            failureBlock(error);
            NSLog(@"error saving currentLocation");
        }
    }];

}

+(void) addNewPinnedLocation:(FeedLocationModel *)pinnedFeed success:(successBlock)successBlock failure:(failureBlock)failureBlock {
    
    NSDictionary *newFeed = [DataManager parseFeedModelIntoDictionary:pinnedFeed];
    NSMutableArray *rawArray = [[NSMutableArray alloc] init];
    
    //write all others
    for( int i = 0; i < [[UserModel sharedInstance].pinnedLocations count]; i++ ) {
        NSDictionary *rawFeed = [DataManager parseFeedModelIntoDictionary:[[UserModel sharedInstance].pinnedLocations objectAtIndex:i]];
        [rawArray addObject:rawFeed];
    }
    
    [rawArray addObject:newFeed];
    //NSLog(@"raw array: %@", rawArray);
    
    [PFUser currentUser][@"pinnedLocations"] = rawArray;
    
    [[PFUser currentUser] saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {   // Hooray! Let them use the app now.
            successBlock(nil);
            
            //now add it to our user object
            [[UserModel sharedInstance].pinnedLocations addObject:pinnedFeed];
            
        } else {   //NSString *errorString = [error userInfo][@"error"];   // Show the errorString somewhere and let the user try again.
            failureBlock(error);
            NSLog(@"error saving pinnedLocation");
        }
    }];
}

+(void) addNewPost:(PostModel *)post success:(successBlock)successBlock failure:(failureBlock)failureBlock {
    
    PFObject *newPost = [DataManager parsePostModelIntoParseObject:post];
    
    [newPost saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            successBlock(nil);
        } else {
            failureBlock(error);
        }
    }];
}

@end
