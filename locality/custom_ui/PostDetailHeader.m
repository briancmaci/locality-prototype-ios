//
//  PostDetailHeader.m
//  locality
//
//  Created by Brian Maci on 6/25/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import "PostDetailHeader.h"
#import "AppUtilities.h"
#import "config.h"

@implementation PostDetailHeader

static float const kDefaultHeight = 136.0f;
static float const kDefaultCaptionHeight = 48.0f;


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
    
    [_postCaption sizeToFit];
}

-(void) drawBackground {
    
    //draw background
    _drawingBackground = [[PostDetailHeaderBackgroundView alloc] initWithFrame:_bgContainer.frame];
    [_bgContainer addSubview:_drawingBackground];
    [_bgContainer setNeedsDisplay];
}

@end
