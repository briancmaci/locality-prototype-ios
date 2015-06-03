//
//  BusyView.h
//  locality
//
//  Created by Brian Maci on 5/21/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BusyView : UIView

@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) IBOutlet UILabel *busyLabel;

+ (BusyView *)sharedInstance;

-(void)show:(BOOL)isShowing withLabel:(NSString *)label;

@end
