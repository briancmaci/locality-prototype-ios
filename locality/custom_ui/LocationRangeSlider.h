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

@property (strong, nonatomic) IBOutlet UISlider *slider;
@property (strong, nonatomic) IBOutlet UILabel *minLabel;
@property (strong, nonatomic) IBOutlet UILabel *maxLabel;

@property (nonatomic) float currentRange;

- (void)initSliderWithRange:(NSArray *)range;

@end
