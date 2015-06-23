//
//  HeaderIconButton.m
//  locality
//
//  Created by Brian Maci on 6/12/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import "HeaderIconButton.h"

@implementation HeaderIconButton

static float const kButtonPadding = 20.0f;

- (id)initWithType:(HeaderIconType)type {
    self = [super init];
    if (self) {
        
        _iconType = type;
        
        UIImage *btnImage = [UIImage imageNamed:[HeaderIconModel imageNameFromType:type]];
        //add image
        [self setImage:btnImage forState:UIControlStateNormal];
        self.frame = CGRectMake(0, 0, btnImage.size.width+kButtonPadding, btnImage.size.height+kButtonPadding); //increasing hit state
        
    }
    return self;
}

-(void)updateIconType:(HeaderIconType)type {
    
    _iconType = type;
    [self setImage:[UIImage imageNamed:[HeaderIconModel imageNameFromType:type]] forState:UIControlStateNormal];
}

@end
