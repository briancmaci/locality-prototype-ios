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

@class SPGooglePlacesAutocompleteQuery;

@interface FeedSettingsViewController : UIViewController <CLLocationManagerDelegate, LocationRangeSliderDelegate, UITableViewDataSource, UITableViewDelegate, UISearchDisplayDelegate, UISearchBarDelegate> {
    NSArray *searchResultPlaces;
    SPGooglePlacesAutocompleteQuery *searchQuery;
    //MKPointAnnotation *selectedPlaceAnnotation;
    
    BOOL shouldBeginEditing;
}

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet GMSMapView *mapView;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) GMSGeocoder *geocoder;

@property (weak, nonatomic) IBOutlet LocationRangeSlider *rangeSlider;
@property (weak, nonatomic) IBOutlet UILabel *currentRangeLabel;

//settings options tableview
@property (weak, nonatomic) IBOutlet UITableView *feedOptionsTable;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *feedOptionsTableHeight;

@property (strong, nonatomic) NSMutableArray *feedOptions;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewHeight;

@end
