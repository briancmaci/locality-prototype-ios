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

//@property (weak, nonatomic) id <FlexibleFeedHeaderDelegate> delegate;

//@property (weak, nonatomic) IBOutlet UIButton *menuButton;
//@property (weak, nonatomic) IBOutlet UIButton *settingsButton;
@property (weak, nonatomic) IBOutlet UIButton *openFeedButton;
//@property (weak, nonatomic) IBOutlet UIImageView *heroImage;
//@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *flexHeaderHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *feedNameTop;

@property (strong, nonatomic) FeedLocationModel *model;
@property (nonatomic) int feedIndex;

-(void) populateWithData:(FeedLocationModel *)model atIndex:(int)index;
-(void) setMenuMode:(BOOL)yes;

@end
