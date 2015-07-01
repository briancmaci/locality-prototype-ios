//
//  FeedMenuTableViewCell.m
//  locality
//
//  Created by Brian Maci on 6/4/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import "FeedMenuTableViewCell.h"
#import "config.h"

@implementation FeedMenuTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    //[self initHeaderHero];
    
}

- (id) initWithFrame:(CGRect)frame {
    if( (self = [super initWithFrame:frame])) {
        [self addSubview:
         [[[NSBundle mainBundle] loadNibNamed:@"FeedMenuTableViewCell"
                                        owner:self
                                      options:nil] objectAtIndex:0]];
        
        [self initHeaderHero];
    }
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) initHeaderHero {
    //NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"FlexibleFeedHeaderView" owner:self options:nil];
    //_heroView = [nib objectAtIndex:0];
    
    //set frame
    [_heroView setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [self setNeedsLayout];
    //NSLog(@"frame? %@", NSStringFromCGRect(self.frame));
    
    //[self addSubview:_heroView];
}

-(void) populateWithData:(FeedLocationModel *)data {
    [_heroView populateWithData:data atIndex:0 inFeedMenu:YES];
}

@end
