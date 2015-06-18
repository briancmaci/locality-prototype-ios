//
//  FeedMenuTableViewCell.h
//  locality
//
//  Created by Brian Maci on 6/4/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlexibleFeedHeaderView.h"

@interface FeedMenuTableViewCell : UITableViewCell

@property (strong, nonatomic) FlexibleFeedHeaderView *heroView;

-(void) populateWithData:(FeedLocationModel *)data;

@end
