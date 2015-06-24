//
//  PostUser.m
//  locality
//
//  Created by Brian Maci on 6/24/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import "PostUser.h"
#import "UserStatusModel.h"

@implementation PostUser

-(id) initWithUserId:(NSString *)userId username:(NSString*)username userStatus:(UserStatusType)statusType andImgUrl:(NSString *)imgUrl{
    
    if( (self = [super init]) ) {
        _userId = userId;
        _username = username;
        _userStatus = [UserStatusModel stringFromUserStatusType:statusType];
        _profileImageUrl = imgUrl;
    }
    
    return self;
}


@end
