//
//  PostModel.h
//  locality
//
//  Created by MRY on 5/27/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PostUser.h"

@interface PostModel : NSObject

#define kPostImgUrl @"postImgUrl"
#define kCaption @"caption"
#define kPostLocation @"postLocation"
#define kPostUser @"user"

#define kLikes @"likes"
#define kCommentsCount @"commentsCount"

@property (strong, nonatomic) NSDate *createdDate;
@property (strong, nonatomic) NSString *postId;

@property (nonatomic) double latitude;
@property (nonatomic) double longitude;

@property (strong, nonatomic) NSString *postCaption;
@property (strong, nonatomic) NSString *postImgUrl;

//User info
//@property (nonatomic) BOOL isAnonymous;

// If no username - make anonymous
@property (strong, nonatomic) PostUser *user;

//Get list of liked users, take count and bool if user has liked
@property (nonatomic) int likesCount;
@property (nonatomic) BOOL isLikedByMe;

@property (nonatomic) int commentsCount;


@end
