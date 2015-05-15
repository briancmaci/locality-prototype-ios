//
//  CurrentFeedInitializeViewController.m
//  locality
//
//  Created by Brian Maci on 5/14/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import "CurrentFeedInitializeViewController.h"

@interface CurrentFeedInitializeViewController ()

@end

@implementation CurrentFeedInitializeViewController

static NSString * kLocationFormat = @"You are currently in %@, %@";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initCurrentLocationMap];
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
    
    self.currentLocationView.camera = [GMSCameraPosition cameraWithTarget:location.coordinate zoom:15 bearing:0 viewingAngle:0];
    
    [self.locationManager stopUpdatingLocation];
    
    [self reverseGeocodeCoordinate:location.coordinate];
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
