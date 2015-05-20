//
//  FeedSliderMenuView.m
//  locality
//
//  Created by Brian Maci on 5/20/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import "FeedSliderMenuView.h"
#import "FeedHeaderHeroView.h"

@implementation FeedSliderMenuView

static float kHeroHeight = 170.0f;

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
        [op setFrame:CGRectMake(0, i * kHeroHeight, DEVICE_WIDTH, kHeroHeight)];
        [op populateWithData:[_menuOptions objectAtIndex:i]];
        [self addSubview:op];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
