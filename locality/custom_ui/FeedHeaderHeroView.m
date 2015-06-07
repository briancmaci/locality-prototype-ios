//
//  FeedHeaderHeroView.m
//  locality
//
//  Created by Brian Maci on 5/20/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import "FeedHeaderHeroView.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "config.h"

@implementation FeedHeaderHeroView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void) populateWithData:(FeedLocationModel *)model atIndex:(int)index {
    _model = model;
    _feedIndex = index;
    
    [self initImage];
    [self setMenuMode:NO];
    
}

-(void) initImage {
    
    if( ![_model.imgUrl isEqualToString:DEFAULT_FEED_IMAGE] ) {
        [_heroImage sd_setImageWithURL:[NSURL URLWithString:_model.imgUrl]];
    }
    
    else {
        [_heroImage setImage:[UIImage imageNamed:DEFAULT_FEED_IMAGE]];
    }
}

-(void) setMenuMode:(BOOL)yes {
    [_menuButton setHidden:!yes];
    [_settingsButton setHidden:yes];
}

#pragma mark - CTAs

-(IBAction)openFeedTapped:(id)sender {
    
    //call delegate
    if( [_delegate respondsToSelector:@selector(openFeedClicked:atIndex:)]) {
        [_delegate openFeedClicked:_model atIndex:_feedIndex];
    }
}

-(IBAction)settingsTapped:(id)sender {

    //call delegate
    if( [_delegate respondsToSelector:@selector(toFeedSettingsClicked:)]) {
        [_delegate toFeedSettingsClicked:_model];
    }
}

-(IBAction)feedMenuTapped:(id)sender {

    //call delegate
    if( [_delegate respondsToSelector:@selector(toFeedMenuClicked)]) {
        [_delegate toFeedMenuClicked];
    }
}

@end
