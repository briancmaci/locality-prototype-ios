//
//  PostFeedCellView.h
//  locality
//
//  Created by Brian Maci on 6/19/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProfileImageView.h"
#import "LikePostButton.h"
#import "CommentButton.h"
#import "PostModel.h"
#import "PostFilterView.h"

@interface PostFeedCellView : UIView

@property (weak, nonatomic) IBOutlet ProfileImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userStatusLabel;

@property (weak, nonatomic) IBOutlet UILabel *postCaption;

@property (weak, nonatomic) IBOutlet LikePostButton *likeButton;
@property (weak, nonatomic) IBOutlet CommentButton *commentButton;
@property (weak, nonatomic) IBOutlet PostFilterView *filterView;

@property (weak, nonatomic) IBOutlet UIView *pinline;

@property (strong, nonatomic) PostModel *thisPost;

-(void) populateWithData:(PostModel *)thisModel;
-(float) getViewHeight:(NSString *)caption;
@end
