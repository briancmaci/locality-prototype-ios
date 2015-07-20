//
//  LocalityLandingViewController.h
//  locality
//
//  Created by Brian Maci on 7/16/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LocalityLandingViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *contourLines;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftParallaxStretch;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightParallaxStretch;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topParallaxStretch;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomParallaxStretch;



@end
