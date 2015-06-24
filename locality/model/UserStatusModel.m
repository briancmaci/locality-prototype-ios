//
//  UserStatusModel.m
//  locality
//
//  Created by Brian Maci on 6/19/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import "UserStatusModel.h"

@implementation UserStatusModel

static NSString * const kUserStatusNewUser = @"User";
static NSString * const kUserStatusContributor = @"Contributor";
static NSString * const kUserStatusReporter = @"Reporter";
static NSString * const kUserStatusColumnist = @"Columnist";
static NSString * const kUserStatusTrustedSource = @"Trusted Source";

+ (NSString*) stringFromUserStatusType:(UserStatusType)type {
    
    switch (type ) {
        case UserStatusNewUser:
            return kUserStatusNewUser;
            break;
            
        case UserStatusContributor:
            return kUserStatusContributor;
            break;
        
        case UserStatusReporter:
            return kUserStatusReporter;
            break;
        
        case UserStatusColumnist:
            return kUserStatusColumnist;
            break;
        
        case UserStatusTrustedSource:
            return kUserStatusTrustedSource;
            break;
    }
}

+ (UserStatusType) statusTypeFromString:(NSString *)str {
    
    if( [str isEqualToString:kUserStatusTrustedSource] ) return UserStatusTrustedSource;
    else if( [str isEqualToString:kUserStatusColumnist] ) return UserStatusColumnist;
    else if( [str isEqualToString:kUserStatusReporter] ) return UserStatusReporter;
    else if( [str isEqualToString:kUserStatusContributor] ) return UserStatusContributor;
    else return UserStatusNewUser;
}

@end
