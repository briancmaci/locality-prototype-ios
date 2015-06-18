//
//  FlexibleFeedHeaderView.h
//  locality
//
//  Created by Brian Maci on 6/18/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import "LocalityHeaderView.h"
#import "FeedLocationModel.h"

@interface FlexibleFeedHeaderView : LocalityHeaderView

-(id) initWithFrame:(CGRect)frame andModel:(FeedLocationModel *)model;

@property (strong, nonatomic) FeedLocationModel *model;

@end
