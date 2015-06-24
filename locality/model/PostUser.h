//
//  PostUser.h
//  locality
//
//  Created by Brian Maci on 6/24/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserStatusModel.h"

@interface PostUser : NSObject

#define kPostUserId @"uid"
#define kPostUserStatus @"status"
#define kPostUsername @"name"
#define kPostProfileImgUrl @"url"

@property (strong, nonatomic) NSString *userId;
@property (strong, nonatomic) NSString *username;
@property (strong, nonatomic) NSString *userStatus;
@property (strong, nonatomic) NSString *profileImageUrl;

-(id) initWithUserId:(NSString *)userId username:(NSString*)username userStatus:(UserStatusType)statusType andImgUrl:(NSString *)imgUrl;

@end
