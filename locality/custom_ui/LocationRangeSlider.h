//
//  LocationRangeSlider.h
//  locality
//
//  Created by Brian Maci on 5/14/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LocationRangeSliderDelegate <NSObject>

-(void)rangeUpdated:(NSDictionary *)rangeStep;

@end

@interface LocationRangeSlider : UIView

@property (weak, nonatomic) id<LocationRangeSliderDelegate> delegate;

@property (strong, nonatomic) NSArray *sliderSteps;
@property (nonatomic) int stepsCount;

@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UILabel *rangeLabel;

@property (weak, nonatomic) IBOutlet UIView *tickMarkView;

@property (nonatomic) int currentStep;

- (void)initSliderWithRange:(NSArray *)range;
- (float) currentRange;

@end
