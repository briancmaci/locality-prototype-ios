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
#import "ParseManager.h"
#import <CoreData/CoreData.h>
#import "AppUtilities.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UserModel.h"
#import "BusyView.h"

@interface CurrentFeedInitializeViewController ()

@end

@implementation CurrentFeedInitializeViewController

static NSString * kLocationFormat = @"You are currently in %@, %@";
static NSString * kCurrentFeedSegue = @"currentFeedViewSegue";

CLLocationCoordinate2D currentLocation;
NSString *flickrDefaultImage;
float currentRange;

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
        
        //NSLog(@"%@, %@", address.locality, address.administrativeArea);
        self.currentLocationLabel.text = [NSString stringWithFormat:kLocationFormat, address.locality, address.administrativeArea];
    }];
}

-(void) initRangeSlider {
    [self.rangeSlider initSliderWithRange:SLIDER_STEPS_IN_FEET];
    _rangeSlider.delegate = self;
}


#pragma mark - CLLocationManagerDelegate Methods

- (void) locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    if( status == kCLAuthorizationStatusAuthorizedWhenInUse ) {
        [self.locationManager startUpdatingLocation];
        
        self.currentLocationView.myLocationEnabled = YES;
        self.currentLocationView.settings.myLocationButton = YES;
        self.currentLocationView.userInteractionEnabled = NO;
    }
}

- (void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    CLLocation *location = [locations objectAtIndex:0];
    currentLocation = location.coordinate;
    
    self.currentLocationView.camera = [GMSCameraPosition cameraWithTarget:currentLocation zoom:15 bearing:0 viewingAngle:0];
    
    [self.locationManager stopUpdatingLocation];
    
    [self reverseGeocodeCoordinate:currentLocation];
}

#pragma mark - LocationRangeSliderDelegate Methods
-(void) rangeUpdated:(NSDictionary *)rangeStep {
    
    currentRange = [[rangeStep objectForKey:@"distance"] floatValue];
    //[GoogleMapsManager drawRangeCircleAt:currentLocation rangeDiameter:[AppUtilities feetToMeters:currentRange] onMap:self.currentLocationView];
    
    //update range label
    [_currentRangeLabel setAttributedText:[AppUtilities rangeLabel:[rangeStep objectForKey:@"unit_label"] withUnits:[[rangeStep objectForKey:@"unit"] uppercaseString]]];
}

#pragma mark - Create Current Feed CTA
-(IBAction) createCurrentFeed:(id)sender {
    
    [UserModel sharedInstance].currentLocation = [[FeedLocationModel alloc] initWithLocation:currentLocation andName:kCurrentFeedName];
    [[UserModel sharedInstance].currentLocation setImgUrl:flickrDefaultImage ? flickrDefaultImage : DEFAULT_FEED_IMAGE];
    [[UserModel sharedInstance].currentLocation setRange:currentRange];
    
    [[BusyView sharedInstance] show:YES withLabel:@"INITIALIZING"];
    
    [ParseManager updateCurrentFeed:[UserModel sharedInstance].currentLocation success:^(id response) {
        [[BusyView sharedInstance] show:NO withLabel:nil];
        NSLog(@"LOCATION SAVED!");
        
        //go to feed
        [self performSegueWithIdentifier:kCurrentFeedSegue sender:self];
        
    } failure:^(NSError *error) {
        NSLog(@"Location Save Fail: %@", error);
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
