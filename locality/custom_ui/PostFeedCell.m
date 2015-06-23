//
//  PostFeedCell.m
//  locality
//
//  Created by Brian Maci on 6/19/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import "PostFeedCell.h"
#import "config.h"
#import "AppUtilities.h"

@implementation PostFeedCell

- (id)initWithModel:(PostModel *)model{
    
    //set model
    _thisModel = model;
    _hasImage = ![_thisModel.postImgUrl isEqualToString:@""];
    
    //size content with caption
    [self initImage];
    [self initCellViewContent];
    
    //size and place initially
    float cellHeight = _postContent.frame.size.height + (_hasImage ? (DEVICE_WIDTH * IMAGE_RATIO) : 0);
    
    self = [super initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, cellHeight)];
    self.frame = CGRectMake(0, 0, DEVICE_WIDTH, cellHeight);
    
    [self addSubview:_postImage];
    [self addSubview:_postContent];
    
    return self;
}

- (id)initWithModelByTime:(PostModel *)model {
    
    self = [self initWithModel:model];
    
    //flesh out search for time
    
    return self;
}

-(id)initWithModelByProximity:(PostModel *)model from:(CLLocationCoordinate2D)center {
    
    self = [self initWithModel:model];
    
    CLLocation *origin = [[CLLocation alloc] initWithLatitude:center.latitude longitude:center.longitude];
    CLLocation *here = [[CLLocation alloc] initWithLatitude:model.latitude longitude:model.longitude];
    
    CLLocationDistance distance = [here distanceFromLocation:origin];
    
    //NSLog(@"distance away! %f", distance);
    
    _postContent.filterView.filterLabel.attributedText = [AppUtilities rangeLabel:[NSString stringWithFormat:@"%i", (int)([AppUtilities metersToFeet:distance] + 0.5f)] withUnits:@"ft"];
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) initImage {
    if( !_hasImage ) return;
    
    _postImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_WIDTH * IMAGE_RATIO)];
    [AppUtilities loadPostImage:_thisModel.postImgUrl intoView:_postImage];
}

- (void) initCellViewContent {
    
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PostFeedCellView" owner:self options:nil];
    _postContent = [nib objectAtIndex:0];
    [_postContent populateWithData:_thisModel];
    [_postContent setFrame:CGRectMake(0, _hasImage ? _postImage.frame.size.height : 0, DEVICE_WIDTH, [_postContent getViewHeight:_thisModel.postCaption])];

}

@end
