//
//  FeedMenuTableViewController.h
//  locality
//
//  Created by Brian Maci on 6/4/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlexibleFeedHeaderView.h"
#import "FeedAddNewTableViewCell.h"

@interface FeedMenuTableViewController : UITableViewController <FeedHeaderHeroDelegate, FeedAddNewDelegate>

@property (strong, nonatomic) NSMutableArray *menuOptions;

@end
