//
//  FeedAddNewTableViewCell.m
//  locality
//
//  Created by Brian Maci on 6/4/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import "FeedAddNewTableViewCell.h"

@implementation FeedAddNewTableViewCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(IBAction)addNewLocationTapped:(id)sender {
    
    if( [_delegate respondsToSelector:@selector(addNewLocationFeed)] ) {
        [_delegate addNewLocationFeed];
    }
}

@end
