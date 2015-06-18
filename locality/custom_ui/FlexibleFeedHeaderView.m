//
//  FeedHeaderHeroView.m
//  locality
//
//  Created by Brian Maci on 5/20/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import "FlexibleFeedHeaderView.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "config.h"
#import "GoogleMapsManager.h"

@implementation FlexibleFeedHeaderView

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
    [self initIcons];
    [self initLabels];
    [self setMenuMode:NO];
    
}

-(void) initImage {
    
    if( ![_model.imgUrl isEqualToString:DEFAULT_FEED_IMAGE] ) {
        [self.bgImage sd_setImageWithURL:[NSURL URLWithString:_model.imgUrl]];
    }
    
    else {
        [self.bgImage setImage:[UIImage imageNamed:DEFAULT_FEED_IMAGE]];
    }
}

-(void) initIcons {
    [self initWithTitle:[_model.name isEqualToString:@"_current"] ? @"CURRENT LOCATION" : [_model.name uppercaseString] leftButtonType:IconHamburger rightButtonType:IconFeedSettings];
}

-(void) initLabels {
    //self.titleLabel.text = [_model.name isEqualToString:@"_current"] ? @"CURRENT LOCATION" : [_model.name uppercaseString];
    _locationLabel.text = [_model.location uppercaseString];
}

-(void) setMenuMode:(BOOL)yes {
    //[_menuButton setHidden:!yes];
    //[_settingsButton setHidden:yes];
}

#pragma mark - CTAs

-(IBAction)openFeedTapped:(id)sender {
    
    //call delegate
    if( [self.delegate respondsToSelector:@selector(openFeedClicked:atIndex:)]) {
        [self.delegate openFeedClicked:_model atIndex:_feedIndex];
    }
}

//-(IBAction)settingsTapped:(id)sender {
//
//    //call delegate
//    if( [self.delegate respondsToSelector:@selector(toFeedSettingsClicked:)]) {
//        [self.delegate toFeedSettingsClicked:_model];
//    }
//}
//
//-(IBAction)feedMenuTapped:(id)sender {
//
//    //call delegate
//    if( [self.delegate respondsToSelector:@selector(toFeedMenuClicked)]) {
//        [self.delegate toFeedMenuClicked];
//    }
//}

@end
