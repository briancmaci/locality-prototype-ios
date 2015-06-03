//
//  BusyView.m
//  locality
//
//  Created by Brian Maci on 5/21/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import "BusyView.h"
#import "config.h"

@implementation BusyView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (BusyView *)sharedInstance
{
    static BusyView *sharedBusyView;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"BusyView" owner:self options:nil];
        sharedBusyView  = [nib objectAtIndex:0];
        
        //size
        CGRect bvf = sharedBusyView.frame;
        bvf.size.width = DEVICE_WIDTH;
        bvf.size.height = DEVICE_HEIGHT;
        
        sharedBusyView.frame = bvf;
    });
    return sharedBusyView;
}

-(void)show:(BOOL)isShowing withLabel:(NSString *)label {
    
    if(isShowing) {
        self.busyLabel.text = (label == nil) ? NSLocalizedString(@"BusyDefaultLabel", nil) : label;
    }
    
    if(isShowing) [self fadeIn];
    else [self fadeOut];
}

//-(void)showInstantly:(BOOL)isShowing withLabel:(NSString *)label {
//    
//    if(isShowing) {
//        self.busyLabel.text = (label == nil) ? NSLocalizedString(@"BusyDefaultLabel", nil) : label;
//    }
//    
//    if(isShowing){
//        [self setHidden:NO];
//        [self setAlpha:1.0f];
//    }
//    else{
//        [self setHidden:YES];
//        [self setAlpha:0.0f];
//    }
//}

-(void) fadeIn{
    [self setHidden:NO];
    
    [self setAlpha:0.0f];
    [UIView animateWithDuration:0.3f animations:^{
        [self setAlpha:1.0f];
    }];
}

-(void) fadeOut{
    [UIView animateWithDuration:0.3f animations:^{
        [self setAlpha:0];
    } completion:^(BOOL finished) {
        [self setHidden:YES];
    }];
}


@end
