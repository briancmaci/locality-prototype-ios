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

-(id)initWithCoder:(NSCoder *)aDecoder{
    if ((self = [super initWithCoder:aDecoder])){
        [self addSubview:
         [[[NSBundle mainBundle] loadNibNamed:@"PostDetailHeader"
                                        owner:self
                                      options:nil] objectAtIndex:0]];
        
        [self setBackgroundColor:[UIColor clearColor]];
        [self setOpaque:NO];
    }
    return self;
}

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
    
    //set post user info
    [_postUserInfo initWithImage:thisModel.user.profileImageUrl
                        username:thisModel.user.username
                      userStatus:thisModel.user.userStatus];
    
    _postCaption.text = thisModel.postCaption;
    
    [_postCaption sizeToFit];
}

@end
