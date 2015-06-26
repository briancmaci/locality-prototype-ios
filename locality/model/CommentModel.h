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

@property (strong, nonatomic) NSString *postId;
@property (strong, nonatomic) NSString *commentId;
@property (strong, nonatomic) NSString *commentText;
@property (strong, nonatomic) PostUser *user;

@end
