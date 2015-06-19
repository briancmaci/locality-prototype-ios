//
//  UserModel.m
//  locality
//
//  Created by Brian Maci on 5/13/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import "UserModel.h"
#import "config.h"

@implementation UserModel

+ (UserModel *)sharedInstance
{
    static UserModel *sharedSingleton;
    
    @synchronized(self)
    {
        if (!sharedSingleton)
        {
            sharedSingleton = [[UserModel alloc] init];
            
            sharedSingleton.email = @"";
            sharedSingleton.password = @"";
            sharedSingleton.username = @"";
            sharedSingleton.profileImgUrl = kDefaultAvatar;
            sharedSingleton.isVerified = NO;
            sharedSingleton.isFirstTime = YES;
            sharedSingleton.userStatus = UserStatusNewUser;
            
            sharedSingleton.pinnedLocations = [[NSMutableArray alloc] init];
        }
        return sharedSingleton;
    }
}


@end
