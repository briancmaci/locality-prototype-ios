//
//  FeedViewController.h
//  locality
//
//  Created by Brian Maci on 5/13/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FeedHeaderHeroView.h"

@interface FeedViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITableView *feedPostsTable;
@property (strong, nonatomic) IBOutlet FeedHeaderHeroView *headerHero;
@property (strong, nonatomic) IBOutlet UIButton *addPostButton;

@end
