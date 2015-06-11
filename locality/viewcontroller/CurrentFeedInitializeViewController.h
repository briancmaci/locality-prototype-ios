//
//  CurrentFeedInitializeViewController.h
//  locality
//
//  Created by Brian Maci on 5/14/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>
#import "LocationRangeSlider.h"

@interface CurrentFeedInitializeViewController : UIViewController <CLLocationManagerDelegate, LocationRangeSliderDelegate>

@property (weak, nonatomic) IBOutlet GMSMapView *currentLocationView;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) GMSGeocoder *geocoder;

@property (strong, nonatomic) IBOutlet UILabel *currentLocationLabel;
@property (strong, nonatomic) IBOutlet LocationRangeSlider *rangeSlider;
@property (strong, nonatomic) IBOutlet UILabel *currentRangeLabel;
@property (strong, nonatomic) IBOutlet UIImageView *defaultImage;


@end
