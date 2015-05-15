//
//  CurrentFeedInitializeViewController.m
//  locality
//
//  Created by Brian Maci on 5/14/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import "CurrentFeedInitializeViewController.h"
#import "config.h"
#import "FlickrManager.h"
#import "GoogleMapsManager.h"
#import <CoreData/CoreData.h>
#import "AppUtilities.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface CurrentFeedInitializeViewController ()

@end

@implementation CurrentFeedInitializeViewController

static NSString * kLocationFormat = @"You are currently in %@, %@";
CLLocationCoordinate2D currentLocation;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initCurrentLocationMap];
    [self initRangeSlider];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) initCurrentLocationMap {
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    [self.locationManager requestWhenInUseAuthorization];
}

- (void) reverseGeocodeCoordinate:(CLLocationCoordinate2D)coordinate {
    self.geocoder = [[GMSGeocoder alloc] init];
    
    [self.geocoder reverseGeocodeCoordinate:coordinate completionHandler:^(GMSReverseGeocodeResponse *response, NSError *error) {
        GMSAddress *address = response.firstResult;
        
        NSLog(@"%@, %@", address.locality, address.administrativeArea);
        self.currentLocationLabel.text = [NSString stringWithFormat:kLocationFormat, address.locality, address.administrativeArea];
    }];
}

-(void) initRangeSlider {
    [self.rangeSlider initSliderWithRange:SLIDER_STEPS_IN_FEET];
}


#pragma mark - CLLocationManagerDelegate Methods

- (void) locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    if( status == kCLAuthorizationStatusAuthorizedWhenInUse ) {
        [self.locationManager startUpdatingLocation];
        
        self.currentLocationView.myLocationEnabled = YES;
        self.currentLocationView.settings.myLocationButton = YES;
    }
}

- (void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    CLLocation *location = [locations objectAtIndex:0];
    currentLocation = location.coordinate;
    
    self.currentLocationView.camera = [GMSCameraPosition cameraWithTarget:currentLocation zoom:15 bearing:0 viewingAngle:0];
    
    [self.locationManager stopUpdatingLocation];
    
    [self reverseGeocodeCoordinate:currentLocation];
}

#pragma mark - Range Slider CTA
-(IBAction)rangeSliderChanged:(LocationRangeSlider *)sender {
    float newStep = roundf(sender.value);
    
    sender.value = newStep;
    
    NSLog(@"step: %f, value: %@", newStep, [[sender.sliderSteps objectAtIndex:newStep] objectForKey:@"distance"]);
    float currentRange = [[[sender.sliderSteps objectAtIndex:newStep] objectForKey:@"distance"] floatValue];
    
    
    //test points
    //CLLocationCoordinate2D annArbor = CLLocationCoordinate2DMake(42.2708333, -83.7263889);
    //CLLocationCoordinate2D cantonMichigan = CLLocationCoordinate2DMake(42.308658, -83.48211);
    //CLLocationCoordinate2D dubai = CLLocationCoordinate2DMake(25.276987, 55.296249);
    //CLLocationCoordinate2D endwellNY = CLLocationCoordinate2DMake(42.112852500000000000, -76.021033999999980000);
    
    //update map
    [GoogleMapsManager drawRangeCircleAt:currentLocation rangeDiameter:[AppUtilities feetToMeters:currentRange] onMap:self.currentLocationView];
    
    //get photo
    
    
    [FlickrManager getImagesForLocation:currentLocation success:^(id response) {
        NSLog(@"we got pictures!");
        
        //load random into image
        [self.defaultImage sd_setImageWithURL:[NSURL URLWithString:[response objectAtIndex:(int)(arc4random() % [response count])]]];
    } failure:^(NSError *error) {
        NSLog(@"flickr error: %@", error);
    }];
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
