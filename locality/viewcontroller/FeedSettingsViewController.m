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
#import "FeedSettingToggleCell.h"

#import <SPGooglePlacesAutocomplete/SPGooglePlacesAutocompleteQuery.h>
#import <SPGooglePlacesAutocomplete/SPGooglePlacesAutocompletePlace.h>

@interface FeedSettingsViewController ()

@property(nonatomic) float currentRange;
@property(nonatomic) CLLocationCoordinate2D currentLocation;

@end

@implementation FeedSettingsViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initAutoCompleteSearch];
    [self initFeedOptionsTable];
    [self initCurrentLocationMap];
    [self initRangeSlider];
}


- (void) initAutoCompleteSearch {
    
    searchQuery = [[SPGooglePlacesAutocompleteQuery alloc] init];
    searchQuery.radius = 100.0;
    searchQuery.key = @"AIzaSyBM-R4liycGYMxbUUAareuq-TO_okvALaU";
    shouldBeginEditing = YES;
    
}

- (void) initFeedOptionsTable {
    //grab data to fill options
    _feedOptions = [[NSMutableArray alloc] initWithArray:FEED_SETTINGS];
    
    _feedOptionsTable.delegate = self;
    _feedOptionsTable.dataSource = self;
    
    //size to fit
    _feedOptionsTableHeight.constant = FEED_SETTINGS_OPTION_HEIGHT * [_feedOptions count];
    
    //size content view
    CGRect contentRect = CGRectZero;
    for (UIView *view in _scrollView.subviews) {
        contentRect = CGRectUnion(contentRect, view.frame);
    }
    contentRect.size.height += _feedOptionsTableHeight.constant;
    _contentViewHeight.constant = contentRect.size.height;
    [_scrollView setContentSize:contentRect.size];
    
    //NSLog(@"content view: %@", NSStringFromCGSize(_scrollView.contentSize));
    //NSLog(@"content rect: %@", NSStringFromCGSize(contentRect.size));
    
    _scrollView.delegate = self;
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
    
    _mapView.camera = [GMSCameraPosition cameraWithTarget:_currentLocation zoom:8 bearing:0 viewingAngle:0];
    
    //location only needed here to show current location. We will have location on otherwise when you update the current location feed
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if( tableView == _feedOptionsTable ) return [_feedOptions count];
    else return [searchResultPlaces count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  {
    
    return 44;
}

- (SPGooglePlacesAutocompletePlace *)placeAtIndexPath:(NSIndexPath *)indexPath {
    return [searchResultPlaces objectAtIndex:indexPath.row];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if( tableView == _feedOptionsTable ) {
        static NSString *CellIdentifier = @"FeedSettingToggleCell";
        FeedSettingToggleCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
        if(cell == nil )
        {
            cell = (FeedSettingToggleCell *)[[[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:self options:nil] objectAtIndex:0];
        }
        
        [cell populateWithData:[_feedOptions objectAtIndex:indexPath.row]];
        
        return cell;
    }
    
    else {
        static NSString *cellIdentifier = @"SPGooglePlacesAutocompleteCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        
        cell.textLabel.font = [UIFont fontWithName:@"GillSans" size:16.0];
        cell.textLabel.text = [self placeAtIndexPath:indexPath].name;
        return cell;
    }
}

#pragma mark -
#pragma mark UISearchDisplayDelegate

- (void)handleSearchForSearchString:(NSString *)searchString {
    searchQuery.location = _currentLocation;
    searchQuery.input = searchString;
    NSLog(@"search string: %@", searchString);
    
    [searchQuery fetchPlaces:^(NSArray *places, NSError *error) {
        if (error) {
            //SPPresentAlertViewWithErrorAndTitle(error, @"Could not fetch Places");
            //NSLog(@"Error: %@", error);
        } else {
            searchResultPlaces = places;
            //NSLog(@"Places? %@", places);
            [self.searchDisplayController.searchResultsTableView reloadData];
        }
    }];
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    [self handleSearchForSearchString:searchString];
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

#pragma mark -
#pragma mark UISearchBar Delegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (![searchBar isFirstResponder]) {
        // User tapped the 'clear' button.
        shouldBeginEditing = NO;
        [self.searchDisplayController setActive:NO];
        //[self.mapView removeAnnotation:selectedPlaceAnnotation];
    }
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    if (shouldBeginEditing) {
        // Animate in the table view.
        NSTimeInterval animationDuration = 0.3;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:animationDuration];
        self.searchDisplayController.searchResultsTableView.alpha = 1.0;
        [UIView commitAnimations];
        
        [self.searchDisplayController.searchBar setShowsCancelButton:YES animated:YES];
    }
    BOOL boolToReturn = shouldBeginEditing;
    shouldBeginEditing = YES;
    return boolToReturn;
}

- (void)dismissSearchControllerWhileStayingActive {
    // Animate out the table view.
    NSTimeInterval animationDuration = 0.3;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:animationDuration];
    self.searchDisplayController.searchResultsTableView.alpha = 0.0;
    [UIView commitAnimations];
    
    [self.searchDisplayController.searchBar setShowsCancelButton:NO animated:YES];
    [self.searchDisplayController.searchBar resignFirstResponder];
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
