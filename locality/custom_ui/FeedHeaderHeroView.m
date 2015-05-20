//
//  FeedHeaderHeroView.m
//  locality
//
//  Created by Brian Maci on 5/20/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import "FeedHeaderHeroView.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation FeedHeaderHeroView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void) populateWithData:(FeedLocationModel *)model {
    _model = model;
    
    [self initImage];
    [self setMenuMode:NO];
    
}

-(void) initImage {
    [_heroImage sd_setImageWithURL:[NSURL URLWithString:_model.imgUrl]];
}

-(void) setMenuMode:(BOOL)yes {
    [_menuButton setHidden:!yes];
    [_settingsButton setHidden:yes];
}

@end
