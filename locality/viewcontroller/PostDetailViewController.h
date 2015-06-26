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

@interface PostDetailViewController : LocalityBaseViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIView *postHeaderContainer;
@property (strong, nonatomic) PostDetailHeader *postHeader;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *postHeaderHeightConstraint;

@property (weak, nonatomic) IBOutlet UITableView *commentsTable;
@property (weak, nonatomic) IBOutlet UIButton *writeCommentButton;

@property (strong, nonatomic) PostModel *thisPost;
@property (strong, nonatomic) NSMutableArray *postComments;
@end
