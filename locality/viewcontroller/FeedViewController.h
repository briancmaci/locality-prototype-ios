//
//  FeedViewController.h
//  locality
//
//  Created by Brian Maci on 5/13/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlexibleFeedHeaderView.h"
#import "FeedLocationModel.h"
#import "FlexibleFeedHeaderView.h"
#import "LocalityBaseViewController.h"

@interface FeedViewController : LocalityBaseViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) FlexibleFeedHeaderView *headerHero;
@property (strong, nonatomic) IBOutlet UITableView *feedPostsTable;
@property (strong, nonatomic) IBOutlet UIButton *addPostButton;
@property (strong, nonatomic) IBOutlet UIView *headerHeroHolder;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *flexHeaderHeight;
//coming up
@property (strong, nonatomic) FlexibleFeedHeaderView *flexHeaderView;

@property (strong, nonatomic) FeedLocationModel *thisFeed;
@property (nonatomic) BOOL isCurrentLocationFeed;

@end
