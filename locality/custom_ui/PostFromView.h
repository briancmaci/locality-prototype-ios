//
//  PostFromView.h
//  locality
//
//  Created by Brian Maci on 6/17/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PostFromViewToggle.h"

@interface PostFromView : UIView

@property (weak, nonatomic) IBOutlet PostFromViewToggle *postFromMeToggle;
@property (weak, nonatomic) IBOutlet PostFromViewToggle *postIncognitoToggle;

@end
