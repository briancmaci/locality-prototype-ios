//
//  FeedSettingToggleCell.m
//  locality
//
//  Created by Brian Maci on 6/10/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import "FeedSettingToggleCell.h"
#import "config.h"

@implementation FeedSettingToggleCell

- (void)awakeFromNib {
    // Initialization code
    
    [self initStage];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) initStage {
    _settingsSwitch.transform = CGAffineTransformMakeScale(0.8, 0.8);
}

-(void) populateWithData:(NSDictionary *)data {
    
    _data = data;
    
    [_settingsLabel setText:[data objectForKey:@"label"]];
    [_settingsSwitch setOn:[[data objectForKey:@"default"] boolValue]];
}

@end
