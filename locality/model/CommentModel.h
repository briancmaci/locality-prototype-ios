//
//  CommentModel.h
//  locality
//
//  Created by Brian Maci on 6/26/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PostUser.h"

@interface CommentModel : NSObject

#define kCommentText @"commentText"
#define kCommentPostId @"postId"
#define kCommentUser @"user"

@property (strong, nonatomic) NSString *postId;
@property (strong, nonatomic) NSString *commentId;
@property (strong, nonatomic) NSString *commentText;
@property (strong, nonatomic) PostUser *user;
@property (strong, nonatomic) NSDate *createdDate;

@end
