//
//  LocalityLeftMenuViewController.h
//  locality
//
//  Created by Brian Maci on 6/19/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProfileImageView.h"

@interface LocalityLeftMenuViewController : UIViewController

@property(weak, nonatomic) IBOutlet ProfileImageView *profileImage;
@property(weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property(weak, nonatomic) IBOutlet UILabel *userStatusLabel;

@property(weak, nonatomic) IBOutlet UILabel *likesLabel;
@property(weak, nonatomic) IBOutlet UILabel *postsLabel;
@property(weak, nonatomic) IBOutlet UIImageView *postsIcon;

@property(weak, nonatomic) IBOutlet NSLayoutConstraint *postsIconRightConstraint;

@end
