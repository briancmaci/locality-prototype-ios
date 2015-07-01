//
//  PostFromView.m
//  locality
//
//  Created by Brian Maci on 6/17/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import "PostFromView.h"
#import "UIImage+Tint.h"
#import "AppUtilities.h"

@implementation PostFromView

-(id) initWithCoder:(NSCoder *)aDecoder {
    if( (self = [super initWithCoder:aDecoder])) {
        
        [self addSubview:
         [[[NSBundle mainBundle] loadNibNamed:@"PostFromView"
                                        owner:self
                                      options:nil] objectAtIndex:0]];
        
    }
    
    return self;
}

-(id) awakeAfterUsingCoder:(NSCoder *)aDecoder {
    
    if( (self = [super awakeAfterUsingCoder:aDecoder]) ) {
        
        [self initToggles];
    }
    
    return self;
}

-(void) initToggles {
    
    NSLog(@"init toggles");
    //from me
    [AppUtilities loadProfileImage:_postFromMeToggle.img];
    
    //incognito
    [_postIncognitoToggle setForMultiply];
    
    [self toggleToMe:YES];
}

-(void) toggleToMe:(BOOL)yes {
    
    [self.postFromMeToggle setSelected:yes];
    [self.postIncognitoToggle setSelected:!yes];
    
    _isAnonymous = !yes;
}

-(IBAction)postFromMeTapped:(id)sender {
    [self toggleToMe:YES];
}

-(IBAction)postIncognitoTapped:(id)sender {
    [self toggleToMe:NO];
}

@end
