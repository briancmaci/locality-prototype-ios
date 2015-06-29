//
//  ProfileImageView.m
//  locality
//
//  Created by Brian Maci on 6/23/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import "ProfileImageView.h"

@implementation ProfileImageView

-(id) initWithCoder:(NSCoder *)aDecoder {
    
    if( (self = [super initWithCoder:aDecoder])) {
        [self updateImageMask];
    }
    
    return self;
}

-(void) updateImageMask {
    [self setNeedsLayout];
    //[self layoutIfNeeded];
    self.layer.cornerRadius = self.frame.size.width/2;
    self.layer.masksToBounds = YES;
}

@end
