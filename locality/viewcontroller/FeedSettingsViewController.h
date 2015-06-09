//
//  FeedSettingsViewController.h
//  locality
//
//  Created by MRY on 5/22/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Google-Maps-iOS-SDK/GoogleMaps.h>
#import "LocationRangeSlider.h"

@interface FeedSettingsViewController : UIViewController <CLLocationManagerDelegate, LocationRangeSliderDelegate>

@property (weak, nonatomic) IBOutlet GMSMapView *mapView;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) GMSGeocoder *geocoder;

@property (strong, nonatomic) IBOutlet LocationRangeSlider *rangeSlider;
@property (strong, nonatomic) IBOutlet UILabel *currentRangeLabel;


@end
