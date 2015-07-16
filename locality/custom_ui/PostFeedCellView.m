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
static float const kCaptionLineSpacing = 3.0f;

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(float) getViewHeight:(NSString *)caption {
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:caption];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineSpacing:kCaptionLineSpacing];
    [attributedString addAttribute:NSParagraphStyleAttributeName
                             value:style
                             range:NSMakeRange(0, [caption length])];
    
    CGSize maximumLabelSize = CGSizeMake(_postCaption.frame.size.width, MAXFLOAT);
    
    CGRect labelBounds = [attributedString boundingRectWithSize:maximumLabelSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
    
    
    return kDefaultHeight - kDefaultCaptionHeight + ceilf(labelBounds.size.height);
}

-(void) populateWithData:(PostModel *)thisModel {
    
    _thisPost = thisModel;
    
    [_postUser initWithImage:_thisPost.user.profileImageUrl username:_thisPost.user.username userStatus:_thisPost.user.userStatus];
    
    [self setAttributedCaptionText];
    
    [_postCaption sizeToFit];
    
    [_likeButton setSelected:_thisPost.isLikedByMe];
}

-(void) setAttributedCaptionText {
    
    _postCaption.lineBreakMode = NSLineBreakByWordWrapping;
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:_thisPost.postCaption];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineSpacing:kCaptionLineSpacing];
    [attributedString addAttribute:NSParagraphStyleAttributeName
                             value:style
                             range:NSMakeRange(0, [_thisPost.postCaption length])];
    
    _postCaption.attributedText = attributedString;
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
