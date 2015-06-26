//
//  PostDetailHeader.h
//  locality
//
//  Created by Brian Maci on 6/25/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProfileImageView.h"
#import "PostModel.h"
#import "PostDetailHeaderBackgroundView.h"

@interface PostDetailHeader : UIView

@property (strong, nonatomic) PostDetailHeaderBackgroundView *drawingBackground;
@property (weak, nonatomic) IBOutlet UIView *bgContainer;
@property (weak, nonatomic) IBOutlet ProfileImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userStatusLabel;

@property (weak, nonatomic) IBOutlet UILabel *postCaption;

@property (strong, nonatomic) PostModel *thisPost;

-(void) populateWithData:(PostModel *)thisModel;
-(void) drawBackground;

@end
