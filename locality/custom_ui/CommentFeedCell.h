//
//  CommentFeedCell.h
//  locality
//
//  Created by Brian Maci on 6/26/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PostUserInfoView.h"
#import "CommentModel.h"

@interface CommentFeedCell : UITableViewCell

@property (weak, nonatomic) IBOutlet PostUserInfoView *postUser;
@property (weak, nonatomic) IBOutlet UILabel *commentText;
@property (weak, nonatomic) IBOutlet UIView *pinline;

@property (strong, nonatomic) CommentModel *thisComment;

-(id)initWithModel:(CommentModel *)comment;
-(float) getViewHeight:(NSString *)txt;

-(void) popBackground;

@end
