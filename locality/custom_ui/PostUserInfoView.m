//
//  PostUserInfoView.m
//  locality
//
//  Created by Brian Maci on 6/29/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import "PostUserInfoView.h"
#import "AppUtilities.h"
#import "config.h"

@implementation PostUserInfoView

-(id)initWithCoder:(NSCoder *)aDecoder{
    if ((self = [super initWithCoder:aDecoder])){
        [self addSubview:
         [[[NSBundle mainBundle] loadNibNamed:@"PostUserInfoView"
                                        owner:self
                                      options:nil] objectAtIndex:0]];
    }
    return self;
}


-(void) initWithImage:(NSString *)imgUrl username:(NSString *)username userStatus:(NSString *)userStatus {
    [AppUtilities loadFeedPostProfileImage:_profileImage fromURL:imgUrl];
    _usernameLabel.text = [username isEqualToString:@""] ? kAnonymousUsername : username;
    _userStatusLabel.text = userStatus;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
