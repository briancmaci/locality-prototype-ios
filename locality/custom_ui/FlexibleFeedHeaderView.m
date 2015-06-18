//
//  FlexibleFeedHeaderView.m
//  locality
//
//  Created by Brian Maci on 6/18/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import "FlexibleFeedHeaderView.h"
#import "config.h"

@implementation FlexibleFeedHeaderView

-(id) initWithFrame:(CGRect)frame andModel:(FeedLocationModel *)model {
    
    //set new height
    CGRect flexFrame = frame;
    flexFrame.size.height = FEED_HERO_HEIGHT;
    
    if ((self = [super initWithFrame:flexFrame] )) {
        
        _model = model;
        [self initFlexHeaderStage];
    }
    
    return self;
}

-(void) initFlexHeaderStage {
    
}

@end
