//
//  ParseManager.m
//  locality
//
//  Created by Brian Maci on 5/13/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import "ParseManager.h"
#import "config.h"

@implementation ParseManager

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
        if (!error) {   // Hooray! Let them use the app now.
            successBlock(nil);
        } else {   //NSString *errorString = [error userInfo][@"error"];   // Show the errorString somewhere and let the user try again.
            failureBlock(error);
        }
    }];
}

+(void) loginViaUsername:(NSString *)username password:(NSString *)password success:(successBlock)successBlock failure:(failureBlock)failureBlock {
    [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser *user, NSError *error) {
        if (user) {
            // Do stuff after successful login.
            successBlock(user);
        } else {
            // The login failed. Check error to see why.
            failureBlock(error);
        }
    }];

}

@end
