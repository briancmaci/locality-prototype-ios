//
//  FeedAddNewTableViewCell.h
//  locality
//
//  Created by Brian Maci on 6/4/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FeedAddNewDelegate <NSObject>

-(void) addNewLocationFeed;

@end

@interface FeedAddNewTableViewCell : UITableViewCell

@property (weak, nonatomic) id<FeedAddNewDelegate> delegate;

@end
