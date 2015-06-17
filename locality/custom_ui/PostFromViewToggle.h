//
//  PostFromViewToggle.h
//  locality
//
//  Created by Brian Maci on 6/17/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PostFromViewToggle : UIView

@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UIImageView *check;
@property (strong, nonatomic) UIImage *initialImage;

@property (nonatomic) BOOL isSelected;
@property (nonatomic) BOOL imageIsMultiplied;

-(void) setSelected:(BOOL)yes;
-(void) setForMultiply;
@end
