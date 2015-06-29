//
//  PostUserInfoView.h
//  locality
//
//  Created by Brian Maci on 6/29/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProfileImageView.h"

@interface PostUserInfoView : UIView

@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userStatusLabel;
@property (weak, nonatomic) IBOutlet ProfileImageView *profileImage;

-(void) initWithImage:(NSString *)imgUrl username:(NSString *)username userStatus:(NSString *)userStatus;

@end
