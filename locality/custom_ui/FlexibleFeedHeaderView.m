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

-(id) initWithCoder:(NSCoder *)aDecoder {
    
    if( (self = [super initWithCoder:aDecoder])) {
        [self addSubview:
         [[[NSBundle mainBundle] loadNibNamed:@"FlexibleFeedHeaderView"
                                        owner:self
                                      options:nil] objectAtIndex:0]];
        
    }
    return self;
}

//header height
static float deltaHeight = FEED_HERO_HEIGHT - kHeaderHeight;

-(void) populateWithData:(FeedLocationModel *)model atIndex:(int)index inFeedMenu:(BOOL)isInFeedMenu {
    _model = model;
    _feedIndex = index;
    
    [self initImage];
    [self initIcons:isInFeedMenu];
    [self initLabels];
}

-(void) initImage {
    
    if( ![_model.imgUrl isEqualToString:DEFAULT_FEED_IMAGE] ) {
        [self.bgImage sd_setImageWithURL:[NSURL URLWithString:_model.imgUrl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if(cacheType == SDImageCacheTypeDisk || cacheType == SDImageCacheTypeNone) {
                self.bgImage.alpha = 0;
                [UIView animateWithDuration:0.25 animations:^{
                    [self.bgImage setAlpha:1];
                }];
            }
            
            else {
                [self.bgImage setAlpha:1];
            }
        }];
    }
    
    else {
        [self.bgImage setImage:[UIImage imageNamed:DEFAULT_FEED_IMAGE]];
        [self.shadowOverlay setHidden:YES];
    }
}

-(void) initIcons:(BOOL)isInFeedMenu {
    
    [self initWithTitle:[_model.name isEqualToString:@"_current"] ? @"CURRENT LOCATION" : [_model.name uppercaseString] leftButtonType:(isInFeedMenu ? IconNone : IconHamburger) rightButtonType:(isInFeedMenu ? IconFeedSettings : IconFeedMenu)];
    
    //move buttons
    [self updateIconsY];
}

-(void) initLabels {
    //self.titleLabel.text = [_model.name isEqualToString:@"_current"] ? @"CURRENT LOCATION" : [_model.name uppercaseString];
    _locationLabel.text = [_model.location uppercaseString];
}

-(void) onHeaderButtonClick:(UIButton *)sender {
    if([self.delegate respondsToSelector:@selector(openFeedClicked:atIndex:)]){
        [self.delegate openFeedClicked:_model atIndex:_feedIndex];
    }
}

-(void) updateIconsY {
    
    CGRect lFrame = self.leftIconButton.frame;
    lFrame.origin.y = self.feedNameTop.constant + self.titleLabel.frame.size.height/2 - self.leftIconButton.frame.size.height/2;
    self.leftIconButton.frame = lFrame;
    
    lFrame = self.rightIconButton.frame;
    lFrame.origin.y = self.feedNameTop.constant + self.titleLabel.frame.size.height/2 - self.rightIconButton.frame.size.height/2;
    self.rightIconButton.frame = lFrame;
}

#pragma mark - CTAs

-(IBAction)openFeedTapped:(id)sender {
    
    //call delegate
    if( [self.delegate respondsToSelector:@selector(openFeedClicked:atIndex:)]) {
        [self.delegate openFeedClicked:_model atIndex:_feedIndex];
    }
}

#pragma mark - Height Update on Scroll

-(void) updateHeaderHeight:(float)newHeaderHeight {
    
    self.flexHeaderHeight.constant = newHeaderHeight;
    [_locationLabel setAlpha:(newHeaderHeight - kHeaderHeight)/deltaHeight ];
    //set title and buttons
    self.feedNameTop.constant = kHeaderTitleY0 + (kHeaderTitleY1 * ((newHeaderHeight - kHeaderHeight)/FEED_HERO_HEIGHT));
    
    [self updateIconsY];
    
    [self setNeedsUpdateConstraints];
}

@end
