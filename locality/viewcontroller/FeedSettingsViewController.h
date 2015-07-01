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
#import "ImageUploadView.h"
#import "RSKImageCropViewController.h"
#import "LocalityPhotoBaseViewController.h"

@interface FeedSettingsViewController : LocalityPhotoBaseViewController <CLLocationManagerDelegate, LocationRangeSliderDelegate, UITableViewDataSource, UITableViewDelegate, UISearchDisplayDelegate, UISearchBarDelegate, ImageUploadViewDelegate, MapBoxManagerDelegate, UITextFieldDelegate, UIScrollViewDelegate> {
    NSArray *searchResultPlaces;
    GMSPlacesClient *placesClient;
    GMSVisibleRegion visibleRegion;
    GMSCoordinateBounds *bounds;
    GMSAutocompleteFilter *filter;
    
    BOOL shouldBeginEditing;
}

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

//@property (weak, nonatomic) IBOutlet GMSMapView *mapView;

//RMMapView
@property (weak, nonatomic) IBOutlet RMMapView *mapBoxView;

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) GMSGeocoder *geocoder;

@property (strong, nonatomic) LocationRangeSlider *rangeSlider;
@property (weak, nonatomic) IBOutlet UIView *rangeSliderContainer;

@property (weak, nonatomic) IBOutlet UITextField *locationName;
@property (strong, nonatomic) IBOutlet UIView *locationNameContainer;

@property (weak, nonatomic) IBOutlet ImageUploadView *imageUploadView;

@property (weak, nonatomic) IBOutlet UIView *scrollButtonContainer;

//settings options tableview
@property (weak, nonatomic) IBOutlet UITableView *feedOptionsTable;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *feedOptionsTableHeight;

@property (strong, nonatomic) NSMutableArray *feedOptions;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewHeight;


@end
