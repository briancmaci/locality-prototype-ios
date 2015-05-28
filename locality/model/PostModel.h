//
//  PostModel.h
//  locality
//
//  Created by MRY on 5/27/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PostModel : NSObject

@property (strong, nonatomic) NSDate *createdDate;
@property (strong, nonatomic) NSString *postId;

@property (nonatomic) double latitude;
@property (nonatomic) double longitude;

@property (strong, nonatomic) NSString *postCaption;
@property (strong, nonatomic) NSString *imgUrl;

@property (nonatomic) int likesCount;
@property (nonatomic) int commentsCount;
@property (nonatomic) BOOL isLikedByMe;

@end
