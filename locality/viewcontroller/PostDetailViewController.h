//
//  PostDetailViewController.h
//  locality
//
//  Created by MRY on 5/22/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LocalityBaseViewController.h"
#import "PostModel.h"
#import "PostDetailHeader.h"
#import "AddCommentCell.h"
#import "CommentFeedCell.h"

@interface PostDetailViewController : LocalityBaseViewController <UITableViewDelegate, UITableViewDataSource, AddCommentDelegate>

@property (weak, nonatomic) IBOutlet PostDetailHeader *postHeader;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *postHeaderHeightConstraint;

@property (weak, nonatomic) IBOutlet UILabel *noCommentsLabel;

@property (weak, nonatomic) IBOutlet UITableView *commentsTable;
@property (weak, nonatomic) IBOutlet UIButton *writeCommentButton;

@property (strong, nonatomic) PostModel *thisPost;
@property (strong, nonatomic) NSMutableArray *postComments;

@property (strong, nonatomic) AddCommentCell *addCommentCell;
@property (nonatomic) BOOL isAddingComment;
@end
