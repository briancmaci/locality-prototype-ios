//
//  LocationRangeSlider.m
//  locality
//
//  Created by Brian Maci on 5/14/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import "LocationRangeSlider.h"

@implementation LocationRangeSlider

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)initSliderWithRange:(NSArray *)range {
    
    self.sliderSteps = range;
    self.stepsCount = (int)[self.sliderSteps count] - 1;
        
    [self buildSlider];
}

- (void) buildSlider {
    
    self.minimumValue = 0;
    self.maximumValue = self.stepsCount;

}

@end
