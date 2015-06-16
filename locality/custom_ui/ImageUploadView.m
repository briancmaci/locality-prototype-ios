//
//  ImageUploadView.m
//  locality
//
//  Created by Brian Maci on 6/16/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import "ImageUploadView.h"

@implementation ImageUploadView

-(id) initWithCoder:(NSCoder *)aDecoder {
    
    if( self = [super initWithCoder:aDecoder]) {
        [self initView];
    }
    
    return self;
}

-(void) initView {
    
    [_selectedPhoto setUserInteractionEnabled:NO];
}

-(void) setLocationImage:(UIImage *)image {
    [_selectedPhoto setImage:image];
}


#pragma mark - CTA Methods

-(IBAction)takePhotoButtonTapped:(id)sender {
    
    if( [_delegate respondsToSelector:@selector(takePhotoTapped)] ) {
        [_delegate takePhotoTapped];
    }
}

-(IBAction)uploadPhotoButtonTapped:(id)sender {
    if( [_delegate respondsToSelector:@selector(uploadPhotoTapped)] ) {
        [_delegate uploadPhotoTapped];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
