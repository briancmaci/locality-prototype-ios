//
//  FeedSettingToggleCell.h
//  locality
//
//  Created by Brian Maci on 6/10/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeedSettingToggleCell : UITableViewCell

@property(weak, nonatomic) IBOutlet UISwitch *settingsSwitch;
@property(weak, nonatomic) IBOutlet UILabel *settingsLabel;

@property (strong, nonatomic) NSDictionary *data;

-(void) populateWithData:(NSDictionary *)data;

@end
