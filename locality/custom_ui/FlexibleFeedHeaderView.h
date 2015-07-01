//
//  FeedHeaderHeroView.h
//  locality
//
//  Created by Brian Maci on 5/20/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FeedLocationModel.h"
#import "LocalityHeaderView.h"

@protocol FlexibleFeedHeaderDelegate <LocalityHeaderViewDelegate>

@optional
-(void) openFeedClicked:(FeedLocationModel *)feed atIndex:(int)index;


@end

@interface FlexibleFeedHeaderView : LocalityHeaderView

@property (weak, nonatomic) IBOutlet UIButton *openFeedButton;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UIImageView *shadowOverlay;

@property (strong, nonatomic) FeedLocationModel *model;
@property (nonatomic) int feedIndex;

-(void) populateWithData:(FeedLocationModel *)model atIndex:(int)index inFeedMenu:(BOOL)isInFeedMenu;

-(void) updateHeaderHeight:(float)newHeaderHeight;

@end
