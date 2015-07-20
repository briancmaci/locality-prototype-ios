//
//  LocalityLandingViewController.m
//  locality
//
//  Created by Brian Maci on 7/16/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import "LocalityLandingViewController.h"

@interface LocalityLandingViewController ()

@end

@implementation LocalityLandingViewController

static float const kParallaxRange = 36.0f;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initParallax];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) initParallax {
    
    // Set stretch of contour lines
    _leftParallaxStretch.constant = -kParallaxRange/2;
    _rightParallaxStretch.constant = -kParallaxRange/2;
    _topParallaxStretch.constant = -kParallaxRange/2;
    _bottomParallaxStretch.constant = -kParallaxRange/2;
    
    [_contourLines setNeedsUpdateConstraints];
    
    // Set vertical effect
    UIInterpolatingMotionEffect *verticalMotionEffect =
    [[UIInterpolatingMotionEffect alloc]
     initWithKeyPath:@"center.y"
     type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
    verticalMotionEffect.minimumRelativeValue = @(-kParallaxRange);
    verticalMotionEffect.maximumRelativeValue = @(kParallaxRange);
    
    // Set horizontal effect
    UIInterpolatingMotionEffect *horizontalMotionEffect =
    [[UIInterpolatingMotionEffect alloc]
     initWithKeyPath:@"center.x"
     type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
    horizontalMotionEffect.minimumRelativeValue = @(-kParallaxRange);
    horizontalMotionEffect.maximumRelativeValue = @(kParallaxRange);
    
    // Create group to combine both
    UIMotionEffectGroup *group = [UIMotionEffectGroup new];
    group.motionEffects = @[horizontalMotionEffect, verticalMotionEffect];
    
    // Add both effects to your view
    [_contourLines addMotionEffect:group];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
