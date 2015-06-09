//
//  FeedSettingsViewController.m
//  locality
//
//  Created by MRY on 5/22/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import "FeedSettingsViewController.h"
#import "AppUtilities.h"
#import "config.h"
#import "GoogleMapsManager.h"

@interface FeedSettingsViewController ()

@property(nonatomic) float currentRange;
@property(nonatomic) CLLocationCoordinate2D currentLocation;

@end

@implementation FeedSettingsViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initCurrentLocationMap];
    [self initRangeSlider];
}

- (void) initCurrentLocationMap {
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    [_locationManager requestWhenInUseAuthorization];
}

-(void) initRangeSlider {
    [self.rangeSlider initSliderWithRange:SLIDER_STEPS_IN_FEET];
    _rangeSlider.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - CLLocationManagerDelegate Methods

- (void) locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    if( status == kCLAuthorizationStatusAuthorizedWhenInUse ) {
        [self.locationManager startUpdatingLocation];
        
        _mapView.myLocationEnabled = YES;
        _mapView.settings.myLocationButton = YES;
        _mapView.userInteractionEnabled = NO;
    }
}

- (void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    CLLocation *location = [locations objectAtIndex:0];
    _currentLocation = location.coordinate;
    
    _mapView.camera = [GMSCameraPosition cameraWithTarget:_currentLocation zoom:15 bearing:0 viewingAngle:0];
    
    [_locationManager stopUpdatingLocation];
    
    //[self reverseGeocodeCoordinate:currentLocation];
}

#pragma mark - LocationRangeSliderDelegate Methods
-(void) rangeUpdated:(NSDictionary *)rangeStep {
    
    _currentRange = [[rangeStep objectForKey:@"distance"] floatValue];
    [GoogleMapsManager drawRangeCircleAt:_currentLocation rangeDiameter:[AppUtilities feetToMeters:_currentRange] onMap:_mapView];
    
    //update range label
    [_currentRangeLabel setAttributedText:[AppUtilities rangeLabel:[rangeStep objectForKey:@"unit_label"] withUnits:[[rangeStep objectForKey:@"unit"] uppercaseString]]];
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
