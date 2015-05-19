//
//  UserModel.h
//  locality
//
//  Created by Brian Maci on 5/13/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FeedLocationModel.h"

@interface UserModel : NSObject

@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSString *username;
@property (strong, nonatomic) NSString *password;

@property (nonatomic) BOOL isVerified;
@property (nonatomic) BOOL isFirstTime;

//feeds
@property (strong, nonatomic) FeedLocationModel *currentLocation;
@property (strong, nonatomic) NSMutableArray *pinnedLocations;

+ (UserModel *)sharedInstance;

@end
