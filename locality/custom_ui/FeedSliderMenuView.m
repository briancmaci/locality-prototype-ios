//
//  FeedSliderMenuView.m
//  locality
//
//  Created by Brian Maci on 5/20/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import "FeedSliderMenuView.h"
#import "config.h"

@implementation FeedSliderMenuView

-(id) initWithCurrentLocation:(FeedLocationModel *)currentLocation andPinnedLocations:(NSMutableArray *)pinnedLocations {
    
    self = [super initWithFrame:CGRectMake( 0, 0, DEVICE_WIDTH, DEVICE_HEIGHT)];
    
    if( self ) {
        
        _menuOptions = [[NSMutableArray alloc] init];
        
        [_menuOptions addObject:currentLocation];
        
//        for( int i = 0; i < [pinnedLocations count]; i++ ) {
//            [_menuOptions addObject:[pinnedLocations objectAtIndex:i]];
//        }
        
        for( int i = 0; i < 2; i++ ) {
            [_menuOptions addObject:currentLocation];
        }
        
        [self buildMenu];
        
    }
    
    return self;
}

-(void) buildMenu {
    
    for( int i = 0; i < [_menuOptions count]; i++ ) {
        
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"FeedHeaderHeroView" owner:self options:nil];
        FeedHeaderHeroView *op = [nib objectAtIndex:0];
        
        //set frame
        [op setFrame:CGRectMake(0, i * FEED_HERO_HEIGHT, DEVICE_WIDTH, FEED_HERO_HEIGHT)];
        [op populateWithData:[_menuOptions objectAtIndex:i] atIndex:i];
        op.delegate = self;
        
        [self addSubview:op];
    }
}

#pragma mark - FeedHeaderHero Delegate Methods

-(void) openFeedClicked:(FeedLocationModel *)feed atIndex:(int)index {
    NSLog(@"Load feed #%d", index);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
