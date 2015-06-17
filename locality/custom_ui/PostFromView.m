//
//  PostFromView.m
//  locality
//
//  Created by Brian Maci on 6/17/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import "PostFromView.h"
#import "UIImage+Tint.h"

@implementation PostFromView

-(void) awakeFromNib {
    [self initToggles];
}

-(id) awakeAfterUsingCoder:(NSCoder *)aDecoder {
    
    if( (self = [super awakeAfterUsingCoder:aDecoder]) ) {
        
        [self initToggles];
    }
    
    return self;
}

-(void) initToggles {
    //from me
    _postFromMeToggle.img.layer.cornerRadius = _postFromMeToggle.img.frame.size.width/2;
    
    //incognito
    [_postIncognitoToggle setForMultiply];
    
    [self toggleToMe:YES];
}

-(void) toggleToMe:(BOOL)yes {
    
    [self.postFromMeToggle setSelected:yes];
    [self.postIncognitoToggle setSelected:!yes];
}

-(IBAction)postFromMeTapped:(id)sender {
    [self toggleToMe:YES];
}

-(IBAction)postIncognitoTapped:(id)sender {
    [self toggleToMe:NO];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end