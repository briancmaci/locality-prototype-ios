//
//  PostDetailHeader.h
//  locality
//
//  Created by Brian Maci on 6/25/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PostUserInfoView.h"
#import "PostModel.h"
#import "PostDetailHeaderBackgroundView.h"

@interface PostDetailHeader : UIView

@property (weak, nonatomic) IBOutlet PostDetailHeaderBackgroundView *drawingBackground;
@property (weak, nonatomic) IBOutlet PostUserInfoView *postUserInfo;

@property (weak, nonatomic) IBOutlet UILabel *postCaption;

@property (strong, nonatomic) PostModel *thisPost;

-(void) populateWithData:(PostModel *)thisModel;

@end
