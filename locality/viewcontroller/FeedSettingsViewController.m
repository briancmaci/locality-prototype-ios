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
#import "CameraOverlayView.h"

@interface FeedSettingsViewController ()

@property(nonatomic) float currentRange;
@property(nonatomic) CLLocationCoordinate2D currentLocation;

@end

@implementation FeedSettingsViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initHeaderView];
    
    [self initAutoCompleteSearch];
    [self initFeedOptionsTable];
    [self initCurrentLocationMap];
    [self initMapboxMap];
    [self initRangeSlider];
}

- (void) initHeaderView {
    [self.header initWithTitle:@"ADD NEW LOCATION"
                leftButtonType:IconBack
               rightButtonType:IconClose];
    
    [self.view addSubview:self.header];
}

- (void) initAutoCompleteSearch {
    
    //search look
    UIFont *searchFont = [UIFont fontWithName:kMainFont size:16.0f];
    [[UITextField appearanceWhenContainedIn:[UISearchBar class], nil] setFont:searchFont];
    
    placesClient = [[GMSPlacesClient alloc] init];
    
    //visibleRegion = _mapView.projection.visibleRegion;
    //bounds = [[GMSCoordinateBounds alloc] initWithCoordinate:visibleRegion.farLeft coordinate:visibleRegion.nearRight];
    filter = [[GMSAutocompleteFilter alloc] init];
    filter.type = kGMSPlacesAutocompleteTypeFilterGeocode;
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
    
    _scrollView.delegate = self;
}

- (void) initMapboxMap {
    [_mapBoxView setTileSource:[MapBoxManager sharedInstance].tileSource];
    _mapBoxView.zoom = 22;
    
}
- (void) initCurrentLocationMap {
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    [_locationManager requestWhenInUseAuthorization];
}

-(void) initRangeSlider {
    _rangeSlider = [[[NSBundle mainBundle] loadNibNamed:@"LocationRangeSlider" owner:self options:nil] objectAtIndex:0];
    [_locationRangeSliderHolder addSubview:_rangeSlider];
    
    [_rangeSlider initSliderWithRange:SLIDER_STEPS_IN_FEET];
    _rangeSlider.delegate = self;
    
    //set default current range
    _currentRange = [_rangeSlider currentRange];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - CLLocationManagerDelegate Methods

- (void) locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    if( status == kCLAuthorizationStatusAuthorizedWhenInUse ) {
        [self.locationManager startUpdatingLocation];
        
        //_mapView.myLocationEnabled = NO;
        //_mapView.settings.myLocationButton = NO;
        //_mapView.userInteractionEnabled = NO;
        
        _mapBoxView.delegate = self;
    }
}

- (void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    CLLocation *location = [locations objectAtIndex:0];
    _currentLocation = location.coordinate;
    
    //_mapView.camera = [GMSCameraPosition cameraWithTarget:_currentLocation zoom:8 bearing:0 viewingAngle:0];
    
    //map box set first circle
    [MapBoxManager sharedInstance].currentRange = [_rangeSlider currentRange];
    [MapBoxManager drawRangeCircleAt:_currentLocation rangeDiameter:[AppUtilities feetToMeters:_currentRange] onMap:_mapBoxView];
    
    //_mapBoxView.centerCoordinate = _currentLocation;
    //_mapBoxView.zoom = 8;
    //_mapBoxView.userInteractionEnabled = NO;
    
    
    //location only needed here to show current location. We will have location on otherwise when you update the current location feed
    [_locationManager stopUpdatingLocation];
    
    //[self reverseGeocodeCoordinate:currentLocation];
}

#pragma mark - LocationRangeSliderDelegate Methods
-(void) rangeUpdated:(NSDictionary *)rangeStep {
    
    _currentRange = [[rangeStep objectForKey:@"distance"] floatValue];
    
    //[GoogleMapsManager drawRangeCircleAt:_currentLocation rangeDiameter:[AppUtilities feetToMeters:_currentRange] onMap:_mapView];
    
    [MapBoxManager sharedInstance].currentRange = _currentRange;
    [MapBoxManager drawRangeCircleAt:_currentLocation rangeDiameter:[AppUtilities feetToMeters:_currentRange] onMap:_mapBoxView];
    
    //update range label
    //[_currentRangeLabel setAttributedText:[AppUtilities rangeLabel:[rangeStep objectForKey:@"unit_label"] withUnits:[[rangeStep objectForKey:@"unit"] uppercaseString]]];
    
    //NSLog(@"range updated");
}

#pragma mark - GooglePlaceID Methods

- (void) getDetailsWithPlaceID:(NSString *)placeID {
    
    [placesClient lookUpPlaceID:placeID callback:^(GMSPlace *place, NSError *error) {
        if (error != nil) {
            NSLog(@"Place Details error %@", [error localizedDescription]);
            return;
        }
        
        if (place != nil) {
            //NSLog(@"Place lat %f", place.coordinate.latitude);
            //NSLog(@"Place long %f", place.coordinate.longitude);
            //NSLog(@"Place placeID %@", place.placeID);
            //NSLog(@"Place attributions %@", place.attributions);
            [self updateMapToLocation:place.coordinate];
            
        } else {
            NSLog(@"No place details for %@", placeID);
        }
    }];
    
}

-(void) updateMapToLocation:(CLLocationCoordinate2D)place {
    //_mapView.camera = [GMSCameraPosition cameraWithTarget:place zoom:14];
    _currentLocation = place;
    
    [MapBoxManager animateToPosition:_currentLocation onMap:_mapBoxView];
    [MapBoxManager drawRangeCircleAt:_currentLocation rangeDiameter:[AppUtilities feetToMeters:_currentRange] onMap:_mapBoxView];
    
    
    //add pin test
    //GMSMarker *marker = [GMSMarker markerWithPosition:_currentLocation];
    //marker.appearAnimation = kGMSMarkerAnimationPop;
    //marker.map = _mapView;
}

#pragma mark - ScrollView Delegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //bounce restricted to bottom only
    scrollView.bounces = (scrollView.contentOffset.y > 20);
    
    //remove search bar when not at top
    self.searchDisplayController.searchBar.alpha = (self.searchDisplayController.searchBar.frame.size.height - scrollView.contentOffset.y)/self.searchDisplayController.searchBar.frame.size.height;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if( tableView == _feedOptionsTable ) return [_feedOptions count] + 1;
    else return [searchResultPlaces count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  {
    
    return 44;
}

-(GMSAutocompletePrediction *)placeAtIndexPath:(NSIndexPath *)indexPath {
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
        
        cell.textLabel.font = [UIFont fontWithName:kMainFont size:16.0];
        cell.textLabel.text = [self placeAtIndexPath:indexPath].attributedFullText.string;
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if( tableView != _feedOptionsTable ) {
        [self getDetailsWithPlaceID:[self placeAtIndexPath:indexPath].placeID];
        [self dismissSearchControllerWhileStayingActive];
        
        
        shouldBeginEditing = NO;
        [self.searchDisplayController setActive:NO];
        //_mapView.camera = [GMSCameraPosition cameraWithTarget:_currentLocation zoom:14 bearing:0 viewingAngle:0];
    }
}
#pragma mark -
#pragma mark UISearchDisplayDelegate

- (void)handleSearchForSearchString:(NSString *)searchString {
    
    [placesClient autocompleteQuery:searchString
                             bounds:bounds
                             filter:filter
                           callback:^(NSArray *results, NSError *error) {
                               if (error != nil) {
                                   NSLog(@"Autocomplete error %@", [error localizedDescription]);
                                   return;
                               }
                               
                               searchResultPlaces = results;
                               [self.searchDisplayController.searchResultsTableView reloadData];
                               //for (GMSAutocompletePrediction * result in results) {
                                   //NSLog(@"Result '%@' with placeID %@", result.attributedFullText.string, result.placeID);
                               //}
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
//        NSTimeInterval animationDuration = 0.3;
//        [UIView beginAnimations:nil context:NULL];
//        [UIView setAnimationDuration:animationDuration];
//        self.searchDisplayController.searchResultsTableView.alpha = 1.0;
//        [UIView commitAnimations];
//        
//        [self.searchDisplayController.searchBar setShowsCancelButton:YES animated:YES];

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




#pragma mark - Camera Access Flow

-(IBAction)checkCameraAccess:(id)sender {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if(authStatus == AVAuthorizationStatusAuthorized)
    {
        [self showPictureOptions];
    }
    else if(authStatus == AVAuthorizationStatusNotDetermined)
    {
        NSLog(@"%@", @"Camera access not determined. Ask for permission.");
        
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted)
         {
             if(granted)
             {
                 NSLog(@"Granted access to %@", AVMediaTypeVideo);
                 [self showPictureOptions];
             }
             else
             {
                 NSLog(@"Not granted access to %@", AVMediaTypeVideo);
                 [self camDenied];
             }
         }];
    }
    else if (authStatus == AVAuthorizationStatusRestricted)
    {
        // My own Helper class is used here to pop a dialog in one simple line.
        [self camDenied];
    }
    else
    {
        [self camDenied];
    }
}

- (void)camDenied
{
    NSLog(@"%@", @"Denied camera access");
    
    NSString *alertText;
    NSString *alertButton;
    
    BOOL canOpenSettings = (&UIApplicationOpenSettingsURLString != NULL);
    if (canOpenSettings)
    {
        alertText = NSLocalizedString(@"CameraAccessPrivacyYouPrevent", nil);
        alertButton = @"Go";
    }
    else
    {
        alertText = NSLocalizedString(@"CameraAccessPrivacyUsPrevent", nil);
        
        alertButton = @"OK";
    }
    
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"model.me"
                          message:alertText
                          delegate:self
                          cancelButtonTitle:alertButton
                          otherButtonTitles:nil];
    alert.tag = 3491832;
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 3491832)
    {
        BOOL canOpenSettings = (&UIApplicationOpenSettingsURLString != NULL);
        if (canOpenSettings)
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    }
}

#pragma mark - Camera Flow Methods

- (void) showPictureOptions
{
    NSString *actionSheetTitle = nil; //Action Sheet Title
    NSString *destructiveTitle = nil; //Action Sheet Button Titles
    NSString *other1 = @"Take Picture";
    NSString *other2 = @"Browse Photo Library";
    NSString *cancelTitle = @"Cancel";
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:actionSheetTitle
                                  delegate:self
                                  cancelButtonTitle:cancelTitle
                                  destructiveButtonTitle:destructiveTitle
                                  otherButtonTitles:other1, other2, nil];
    
    
    [actionSheet showInView:self.view];
    
    
    // ActionSheet styling. (ios8 has a work-around).
    
    SEL selector = NSSelectorFromString(@"_alertController");
    if ([actionSheet respondsToSelector:selector])
    {
        UIAlertController *alertController = [actionSheet valueForKey:@"_alertController"];
        if ([alertController isKindOfClass:[UIAlertController class]])
        {
            alertController.view.tintColor = [UIColor blackColor];
            // font styling in UIAlertController is not working here
        }
    }
    else
    {
        // use other methods for iOS 7 or older.
        for (UIView *subview in actionSheet.subviews) {
            if ([subview isKindOfClass:[UIButton class]]) {
                UIButton *button = (UIButton *)subview;
                [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                button.titleLabel.font = [UIFont fontWithName:kMainFont size:20];
            }
        }
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [self takePhoto];
    } else if (buttonIndex == 1) {
        [self selectPhoto];
    }
}

- (void) selectPhoto
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = NO;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
    
}

- (void) takePhoto
{
    //use CameraOverlayView
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CameraOverlayView" owner:self options:nil];
    CameraOverlayView *cameraOverlayView = (CameraOverlayView *)[nib objectAtIndex:0];
    
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = NO;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    picker.cameraDevice = UIImagePickerControllerCameraDeviceFront;
    picker.cameraFlashMode = UIImagePickerControllerCameraFlashModeOff;
    [picker setShowsCameraControls:NO];
    picker.cameraOverlayView = cameraOverlayView;
    cameraOverlayView.pickerReference = picker;
    
    [self presentViewController:picker animated:YES completion:^{
    }];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:^{
        
        UIImage *image = (UIImage *)[info valueForKey:UIImagePickerControllerOriginalImage];
        [self showImageCropper:image];
        
        
    }];
}

-(void)showImageCropper:(UIImage *)image {
    RSKImageCropViewController *imageCropVC = [[RSKImageCropViewController alloc] initWithImage:image];
    imageCropVC.delegate = self;
    [self.navigationController pushViewController:imageCropVC animated:YES];
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
