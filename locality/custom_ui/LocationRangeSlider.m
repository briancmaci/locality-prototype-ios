//
//  LocationRangeSlider.m
//  locality
//
//  Created by Brian Maci on 5/14/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import "LocationRangeSlider.h"
#import "AppUtilities.h"
#import "config.h"

@implementation LocationRangeSlider

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)initSliderWithRange:(NSArray *)range {
    
    _sliderSteps = range;
    _stepsCount = (int)[_sliderSteps count] - 1;
    
    [self initLabels];
    [self initSlider];
}

- (void) initSlider {
    
    _slider.minimumValue = 0;
    _slider.maximumValue = _stepsCount;
    
    //init custom knob
    [_slider setThumbImage:[UIImage imageNamed:kSwitchSliderKnob] forState:UIControlStateNormal];
}

- (void) initLabels {

    //set min and max to dictionary values of slider steps
    [_minLabel setAttributedText:[AppUtilities rangeLabel:[[_sliderSteps objectAtIndex:0] objectForKey:@"unit_label"] withUnits:[[[_sliderSteps objectAtIndex:0] objectForKey:@"unit"] uppercaseString]]];
    [_maxLabel setAttributedText:[AppUtilities rangeLabel:[[_sliderSteps objectAtIndex:_stepsCount] objectForKey:@"unit_label"] withUnits:[[[_sliderSteps objectAtIndex:_stepsCount] objectForKey:@"unit"] uppercaseString]]];
}

-(IBAction)rangeSliderChanged:(UISlider *)sender {
    float newStep = roundf(sender.value);
    
    sender.value = newStep;
    
    //NSLog(@"step: %f, value: %@", newStep, [[_sliderSteps objectAtIndex:newStep] objectForKey:@"distance"]);
    _currentRange = [[[_sliderSteps objectAtIndex:newStep] objectForKey:@"distance"] floatValue];
    
    
    //test points
    //CLLocationCoordinate2D annArbor = CLLocationCoordinate2DMake(42.2708333, -83.7263889);
    //CLLocationCoordinate2D cantonMichigan = CLLocationCoordinate2DMake(42.308658, -83.48211);
    //CLLocationCoordinate2D dubai = CLLocationCoordinate2DMake(25.276987, 55.296249);
    //CLLocationCoordinate2D endwellNY = CLLocationCoordinate2DMake(42.112852500000000000, -76.021033999999980000);
    
    //update map with delegate
    //[GoogleMapsManager drawRangeCircleAt:currentLocation rangeDiameter:[AppUtilities feetToMeters:currentRange] onMap:self.currentLocationView];
    
    if ( [_delegate respondsToSelector:@selector(rangeUpdated:)] ) {
        [_delegate rangeUpdated:[_sliderSteps objectAtIndex:newStep]];
    }
}


@end
