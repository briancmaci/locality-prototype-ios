//
//  FeedViewController.h
//  locality
//
//  Created by Brian Maci on 5/13/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FeedHeaderHeroView.h"
#import "FeedLocationModel.h"
#import "FlexibleFeedHeaderView.h"

@interface FeedViewController : UIViewController <FeedHeaderHeroDelegate>

@property (strong, nonatomic) FeedHeaderHeroView *headerHero;
@property (strong, nonatomic) IBOutlet UITableView *feedPostsTable;
@property (strong, nonatomic) IBOutlet UIButton *addPostButton;
@property (strong, nonatomic) IBOutlet UIView *headerHeroHolder;

//coming up
@property (strong, nonatomic) FlexibleFeedHeaderView *flexHeaderView;

@property (strong, nonatomic) FeedLocationModel *thisFeed;
@property (nonatomic) BOOL isCurrentLocationFeed;

@end
