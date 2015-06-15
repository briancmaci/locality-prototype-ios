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

static NSString * const tickImg = @"location_range_slider_bg_tick";

//- (id)initWithCoder:(NSCoder *)aDecoder {
//    if ((self = [[NSBundle mainBundle] loadNibNamed:@"LocationRangeSlider" owner:self options:nil][0])) {
//        //location range slider  nib loaded
//    }
//    return self;
//}

- (void)initSliderWithRange:(NSArray *)range {
    
    _sliderSteps = range;
    _stepsCount = (int)[_sliderSteps count] - 1;
    
    [self initSlider];
}

- (void) initSlider {
    
    _slider.minimumValue = 0;
    _slider.maximumValue = _stepsCount;
    
    //set default step and range to middle
    _currentStep = _stepsCount/2;
    
    //init custom knob
    [_slider setThumbImage:[UIImage imageNamed:kSwitchSliderKnob] forState:UIControlStateNormal];
    
    //set tickmark image
    [_tickMarkView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:tickImg]]];
    
    //set range label
    [self updateRangeLabel];
}

- (void) updateRangeLabel {

    //set min and max to dictionary values of slider steps
    [_rangeLabel setAttributedText:[AppUtilities rangeLabel:[[_sliderSteps objectAtIndex:_currentStep] objectForKey:@"unit_label"] withUnits:[[[_sliderSteps objectAtIndex:_currentStep] objectForKey:@"unit"] uppercaseString]]];
}

-(IBAction)rangeSliderChanged:(UISlider *)sender {
    int newStep = roundf(sender.value);
    
    sender.value = newStep;
    //NSLog(@"_current step: %d, newStep : %d", _currentStep, newStep);
    
    if( _currentStep == newStep ) return;
    
    _currentStep = newStep;
    [self updateRangeLabel];
    
    //test points
    //CLLocationCoordinate2D annArbor = CLLocationCoordinate2DMake(42.2708333, -83.7263889);
    //CLLocationCoordinate2D cantonMichigan = CLLocationCoordinate2DMake(42.308658, -83.48211);
    //CLLocationCoordinate2D dubai = CLLocationCoordinate2DMake(25.276987, 55.296249);
    //CLLocationCoordinate2D endwellNY = CLLocationCoordinate2DMake(42.112852500000000000, -76.021033999999980000);
    
    if ( [_delegate respondsToSelector:@selector(rangeUpdated:)] ) {
        [_delegate rangeUpdated:[_sliderSteps objectAtIndex:_currentStep]];
    }
}

-(float)currentRange {
    return [[[_sliderSteps objectAtIndex:_currentStep] objectForKey:@"distance"] floatValue];
}


@end
