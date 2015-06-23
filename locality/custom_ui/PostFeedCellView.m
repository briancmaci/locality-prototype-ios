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
    
    [AppUtilities loadFeedPostProfileImage:_profileImage fromURL:thisModel.profileImgUrl];
    _postCaption.text = thisModel.postCaption;
    _usernameLabel.text = thisModel.username;
    
    [_postCaption sizeToFit];
}

@end
