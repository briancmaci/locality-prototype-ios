//
//  PostFeedCell.h
//  locality
//
//  Created by Brian Maci on 6/19/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "PostFeedCellView.h"
#import "PostModel.h"

@interface PostFeedCell : UITableViewCell

- (id)initWithModelByTime:(PostModel *)model;
- (id)initWithModelByProximity:(PostModel *)model from:(CLLocationCoordinate2D)center;

@property (strong, nonatomic) UIImageView *postImage;
@property (strong, nonatomic) PostFeedCellView *postContent;

@property (strong, nonatomic) PostModel *thisModel;
@property (nonatomic) BOOL hasImage;

@end
