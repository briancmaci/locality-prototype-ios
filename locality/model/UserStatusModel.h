//
//  UserStatusModel.h
//  locality
//
//  Created by Brian Maci on 6/19/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserStatusModel : NSObject

//enum types
typedef enum {
    
    UserStatusNewUser,
    UserStatusContributor,
    UserStatusReporter,
    UserStatusColumnist,
    UserStatusTrustedSource
    
} UserStatusType;

+ (NSString*) stringFromUserStatusType:(UserStatusType)type;
+ (UserStatusType) statusTypeFromString:(NSString *)str;

@end
