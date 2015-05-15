//
//  LocationRangeSlider.h
//  locality
//
//  Created by Brian Maci on 5/14/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LocationRangeSlider : UISlider

@property (strong, nonatomic) NSArray *sliderSteps;
@property (nonatomic) int stepsCount;

- (void)initSliderWithRange:(NSArray *)range;

@end
