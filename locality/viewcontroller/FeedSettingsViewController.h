//
//  FeedSettingsViewController.h
//  locality
//
//  Created by MRY on 5/22/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <GoogleMaps/GoogleMaps.h>
#import "MapBoxManager.h"
#import "LocationRangeSlider.h"
#import "RSKImageCropViewController.h"
#import "LocalityBaseViewController.h"

@interface FeedSettingsViewController : LocalityBaseViewController <CLLocationManagerDelegate, LocationRangeSliderDelegate, UITableViewDataSource, UITableViewDelegate, UISearchDisplayDelegate, UISearchBarDelegate, UIActionSheetDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, RSKImageCropViewControllerDelegate, RMMapViewDelegate> {
    NSArray *searchResultPlaces;
    GMSPlacesClient *placesClient;
    GMSVisibleRegion visibleRegion;
    GMSCoordinateBounds *bounds;
    GMSAutocompleteFilter *filter;
    
    BOOL shouldBeginEditing;
}

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet GMSMapView *mapView;

//RMMapView
@property (weak, nonatomic) IBOutlet RMMapView *mapBoxView;

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
