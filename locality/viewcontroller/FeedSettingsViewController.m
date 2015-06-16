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

static NSString * const kLocationSliderNibName = @"LocationRangeSlider";
static NSString * const kImageUploadNibName = @"ImageUploadView";


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initHeaderView];
    
    [self initAutoCompleteSearch];
    [self initFeedOptionsTable];
    [self initCurrentLocationMap];
    [self initMapboxMap];
    [self initRangeSlider];
    [self initImageUploadView];
    [self initLocationName];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self registerForKeyboardNotifications];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self cancelKeyboardNotifications];
}

- (void) initHeaderView {
    [self.header initWithTitle:@"ADD NEW LOCATION"
                leftButtonType:IconBack
               rightButtonType:IconClose];
    
    [self.view addSubview:self.header];
}

- (void) initLocationName {
    _locationName.delegate = self;
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
    [_feedOptionsTable reloadData];
    
    //size content view by adding all pieces
    float contentHeight = 0.0f;
    
    contentHeight += self.searchDisplayController.searchBar.frame.size.height;
    contentHeight += _mapBoxView.frame.size.height;
    contentHeight += _rangeSliderContainer.frame.size.height;
    contentHeight += _locationNameContainer.frame.size.height;
    contentHeight += _imageUploadViewContainer.frame.size.height;
    contentHeight += _feedOptionsTableHeight.constant;
    contentHeight += _scrollButtonContainer.frame.size.height;
    contentHeight += 80.0f; //bottom padding
    
    _contentViewHeight.constant = contentHeight;
    [_scrollView setContentSize:CGSizeMake( DEVICE_WIDTH, contentHeight)];
    
    _scrollView.delegate = self;
}

- (void) initMapboxMap {
    
    [_mapBoxView setTileSource:[MapBoxManager sharedInstance].tileSource];
    [MapBoxManager setCurrentMapDelegate:_mapBoxView];
    
    [MapBoxManager sharedInstance].delegate = self;
    
    _mapBoxView.zoom = 22;
    
    _mapBoxView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _mapBoxView.userInteractionEnabled = YES;
    
}
- (void) initCurrentLocationMap {
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    [_locationManager requestWhenInUseAuthorization];
}

-(void) initRangeSlider {
    _rangeSlider = [[[NSBundle mainBundle] loadNibNamed:kLocationSliderNibName owner:self options:nil] objectAtIndex:0];
    [_rangeSliderContainer addSubview:_rangeSlider];
    
    [_rangeSlider initSliderWithRange:SLIDER_STEPS_IN_FEET];
    _rangeSlider.delegate = self;
    
    //set default current range
    _currentRange = [_rangeSlider currentRange];
}

-(void) initImageUploadView {
    
    _imageUploadView = [[[NSBundle mainBundle] loadNibNamed:kImageUploadNibName owner:self options:nil] objectAtIndex:0];
    [_imageUploadViewContainer addSubview:_imageUploadView];
    
    _imageUploadView.delegate = self;
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
        
        //_mapBoxView.delegate = self;
    }
}

#pragma mark - ImageUploadViewDelegate Methods 

//These both go through the action sheet flow that checks for camera access

- (void) takePhotoTapped {
    [self checkCameraAccess];
}

- (void) uploadPhotoTapped {
    [self checkCameraAccess];
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

#pragma mark - MapBoxManagerDelegate Methods 

-(void) onMapTapped:(CLLocationCoordinate2D)center {
    _currentLocation = center;
    [MapBoxManager drawRangeCircleAt:_currentLocation rangeDiameter:[AppUtilities feetToMeters:_currentRange] onMap:_mapBoxView];
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
            [self updateMapToLocation:place.coordinate];
            
        } else {
            NSLog(@"No place details for %@", placeID);
        }
    }];
    
}

-(void) updateMapToLocation:(CLLocationCoordinate2D)place {
    //_mapView.camera = [GMSCameraPosition cameraWithTarget:place zoom:14];
    _currentLocation = place;
    [MapBoxManager drawRangeCircleAt:_currentLocation rangeDiameter:[AppUtilities feetToMeters:_currentRange] onMap:_mapBoxView];
}

#pragma mark - ScrollView Delegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //bounce restricted to bottom only
    scrollView.bounces = (scrollView.contentOffset.y > 20);
    
    //remove search bar when not at top
    self.searchDisplayController.searchBar.alpha = (self.searchDisplayController.searchBar.frame.size.height - scrollView.contentOffset.y)/self.searchDisplayController.searchBar.frame.size.height;
}

#pragma mark - Keyboard Notifications

- (void)registerForKeyboardNotifications {
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
}

- (void)cancelKeyboardNotifications {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardDidHideNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
    
}

- (void)keyboardWillShow:(NSNotification *)notification {
    
    NSDictionary* info = [notification userInfo];
    
    CGSize keyboardSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    CGPoint locOrigin = _locationName.frame.origin;
    CGFloat locHeight = _locationName.frame.size.height;
    
    CGRect visibleRect = _scrollView.frame;
    
    visibleRect.size.height -= keyboardSize.height;
    
    if (!CGRectContainsPoint(visibleRect, locOrigin)){
        CGPoint scrollPoint = CGPointMake(0.0, keyboardSize.height - locOrigin.y - locHeight );
        
        [_scrollView setContentOffset:scrollPoint animated:YES];
        
    }
    //CGPoint scrollPoint = _scrollView.contentOffset;
    //scrollPoint.y += keyboardSize.height;
    
    //[_scrollView setContentOffset:scrollPoint animated:YES];
    
}

- (void)keyboardWillBeHidden:(NSNotification *)notification {
    
    [self.scrollView setContentOffset:CGPointZero animated:YES];
    
}

#pragma mark - UITextFieldDelegate Methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
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


#pragma mark - CTA

-(IBAction)saveLocationTapped:(id)sender {

}


#pragma mark - Camera Access Flow

-(void)checkCameraAccess{
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
    picker.cameraDevice = UIImagePickerControllerCameraDeviceRear;
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
    RSKImageCropViewController *imageCropVC = [[RSKImageCropViewController alloc] initWithImage:image cropMode:RSKImageCropModeCustom];
    //RSKImageCropViewController *imageCropVC = [[RSKImageCropViewController alloc] initWithImage:image];
    
    imageCropVC.delegate = self;
    imageCropVC.dataSource = self;
    [self.navigationController pushViewController:imageCropVC animated:YES];
}

#pragma mark - RSKImageCropperDelegate Methods

// Crop image has been canceled.
- (void)imageCropViewControllerDidCancelCrop:(RSKImageCropViewController *)controller
{
    [self.navigationController popViewControllerAnimated:YES];
}

// The original image has been cropped.
- (void)imageCropViewController:(RSKImageCropViewController *)controller
                   didCropImage:(UIImage *)croppedImage
                  usingCropRect:(CGRect)cropRect
{
    [_imageUploadView setLocationImage:croppedImage];
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - RSKImageCropperDataSource Methods

-(CGRect)imageCropViewControllerCustomMaskRect:(RSKImageCropViewController *)controller {
    
    CGSize maskSize = CGSizeMake(DEVICE_WIDTH, DEVICE_WIDTH*IMAGE_RATIO);
    
    CGFloat viewWidth = CGRectGetWidth(controller.view.frame);
    CGFloat viewHeight = CGRectGetHeight(controller.view.frame);
    
    CGRect maskRect = CGRectMake((viewWidth - maskSize.width) * 0.5f,
                                 (viewHeight - maskSize.height) * 0.5f,
                                 maskSize.width,
                                 maskSize.height);
    
    return maskRect;
}

// Returns a custom path for the mask.
- (UIBezierPath *)imageCropViewControllerCustomMaskPath:(RSKImageCropViewController *)controller
{
    CGRect rect = controller.maskRect;
    CGPoint point1 = CGPointMake(CGRectGetMinX(rect), CGRectGetMaxY(rect));
    CGPoint point2 = CGPointMake(CGRectGetMaxX(rect), CGRectGetMaxY(rect));
    CGPoint point3 = CGPointMake(CGRectGetMaxX(rect), CGRectGetMinY(rect));
    CGPoint point4 = CGPointMake(CGRectGetMinX(rect), CGRectGetMinY(rect));
    
    UIBezierPath *rectPath = [UIBezierPath bezierPath];
    [rectPath moveToPoint:point1];
    [rectPath addLineToPoint:point2];
    [rectPath addLineToPoint:point3];
    [rectPath addLineToPoint:point4];
    [rectPath closePath];
    
    return rectPath;
}


-(CGRect)imageCropViewControllerCustomMovementRect:(RSKImageCropViewController *)controller {
    
    return controller.maskRect;
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
