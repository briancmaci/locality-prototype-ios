//
//  LeftMenuOptionTableViewCell.m
//  locality
//
//  Created by Brian Maci on 6/24/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import "LeftMenuOptionTableViewCell.h"
#import "UIColor+LocalityColor.h"

@implementation LeftMenuOptionTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if((self = [super initWithCoder:aDecoder])) {
        [self buildSelectionView];
    }
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    
}

- (void) buildSelectionView {
    UIView *bgColorView = [[UIView alloc] init];
    bgColorView.backgroundColor = [UIColor leftNavSelectedColor];
    [self setSelectedBackgroundView:bgColorView];
}

@end
