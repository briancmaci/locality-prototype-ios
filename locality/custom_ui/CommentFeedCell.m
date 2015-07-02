//
//  CommentFeedCell.m
//  locality
//
//  Created by Brian Maci on 6/26/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import "CommentFeedCell.h"
#import "config.h"
#import "UIColor+LocalityColor.h"

@implementation CommentFeedCell

static float const kDefaultHeight = 124.0f;
static float const kDefaultCommentHeight = 44.0f;

- (id)initWithModel:(CommentModel *)model{
    
    if( (self = [super init])) {
        //set model
        _thisComment = model;
        
        //size and place initially
        UIView *content = [[[NSBundle mainBundle] loadNibNamed:@"CommentFeedCell" owner:self options:nil] objectAtIndex:0];
        content.frame = CGRectMake(0, 0, DEVICE_WIDTH, [self getViewHeight:_thisComment.commentText]);
        [self addSubview:content];
        //size content with caption
        [self populateWithData];
        [self setBackgroundColor:[UIColor commentBackgroundColor]];
    }
    
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)populateWithData {
    
    [_postUser initWithImage:_thisComment.user.profileImageUrl username:_thisComment.user.username userStatus:_thisComment.user.userStatus];
    [_commentText setText:_thisComment.commentText];
    
}

-(float) getViewHeight:(NSString *)txt {
    CGSize maximumLabelSize = CGSizeMake(_commentText.frame.size.width, MAXFLOAT);
    
    NSStringDrawingOptions options = NSStringDrawingTruncatesLastVisibleLine |
    NSStringDrawingUsesLineFragmentOrigin;
    
    NSDictionary *attr = @{NSFontAttributeName: _commentText.font };
    CGRect labelBounds = [txt boundingRectWithSize:maximumLabelSize
                                                   options:options
                                                attributes:attr
                                                   context:nil];
    return kDefaultHeight - kDefaultCommentHeight + ceilf(labelBounds.size.height);
}

-(void) popBackground {
    [self setBackgroundColor:[UIColor whiteColor]];
}
@end
