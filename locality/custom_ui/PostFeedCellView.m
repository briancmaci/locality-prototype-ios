//
//  PostFeedCellView.m
//  locality
//
//  Created by Brian Maci on 6/19/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import "PostFeedCellView.h"
#import "AppUtilities.h"
#import "config.h"
#import "ParseManager.h"

@implementation PostFeedCellView


static float const kDefaultHeight = 166.0f;
static float const kDefaultCaptionHeight = 32.0f;

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(float) getViewHeight:(NSString *)caption {
    
    CGSize maximumLabelSize = CGSizeMake(_postCaption.frame.size.width, MAXFLOAT);
    
    NSStringDrawingOptions options = NSStringDrawingTruncatesLastVisibleLine |
    NSStringDrawingUsesLineFragmentOrigin;
    
    NSDictionary *attr = @{NSFontAttributeName: _postCaption.font };
    CGRect labelBounds = [caption boundingRectWithSize:maximumLabelSize
                                                             options:options
                                                          attributes:attr
                                                             context:nil];
    
    return kDefaultHeight - kDefaultCaptionHeight + ceilf(labelBounds.size.height);
}

-(void) populateWithData:(PostModel *)thisModel {
    
    _thisPost = thisModel;
    
    [AppUtilities loadFeedPostProfileImage:_profileImage fromURL:thisModel.user.profileImageUrl];
    _postCaption.text = thisModel.postCaption;
    _usernameLabel.text = [thisModel.user.username isEqualToString:@""] ? kAnonymousUsername : thisModel.user.username;
    
    [_likeButton setSelected:_thisPost.isLikedByMe];
    
    [_postCaption sizeToFit];
}

#pragma mark - CTAs

-(IBAction)onLikeTapped:(id)sender {
    if(!_thisPost.isLikedByMe) {
        [ParseManager likePost:_thisPost.postId success:^(id response) {
            NSLog(@"Like it!");
            [sender setSelected:YES];
            _thisPost.isLikedByMe = YES;
        } failure:^(NSError *error) {
            NSLog(@"Like FAIL");
        }];
    }
    
    else {
        
        [ParseManager unlikePost:_thisPost.postId success:^(id response) {
            NSLog(@"Unlike it!");
            [sender setSelected:NO];
            _thisPost.isLikedByMe = NO;
        } failure:^(NSError *error) {
            NSLog(@"Unlike FAIL");
        }];
    
    }
}

@end
