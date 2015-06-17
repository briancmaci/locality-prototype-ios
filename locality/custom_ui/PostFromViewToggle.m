//
//  PostFromViewToggle.m
//  locality
//
//  Created by Brian Maci on 6/17/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import "PostFromViewToggle.h"
#import "UIColor+LocalityColor.h"
#import "UIImage+Tint.h"

@implementation PostFromViewToggle

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)setSelected:(BOOL)yes {
    
    [self setBackgroundColor:yes ? [UIColor redUIColor] : [UIColor lightGrayUIColor]];
    [_label setTextColor:yes ? [UIColor whiteColor] : [UIColor blueUIColor]];
    [_check setHidden:!yes];
    
    if( _imageIsMultiplied ) {
        _img.image = [_initialImage tintedImageWithColor:self.backgroundColor];
    }
    
    _isSelected = yes;
}

-(void)setForMultiply {
    _imageIsMultiplied = YES;
    _initialImage = _img.image;
}

@end
