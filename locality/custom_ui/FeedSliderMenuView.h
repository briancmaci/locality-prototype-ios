//
//  FeedSliderMenuView.h
//  locality
//
//  Created by Brian Maci on 5/20/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FeedLocationModel.h"
#import "FeedHeaderHeroView.h"
#import "config.h"

@interface FeedSliderMenuView : UIView <FeedHeaderHeroDelegate>

-(id) initWithCurrentLocation:(FeedLocationModel *)currentLocation andPinnedLocations:(NSMutableArray *)pinnedLocations;

@property (strong, nonatomic) NSMutableArray *menuOptions;

@end
