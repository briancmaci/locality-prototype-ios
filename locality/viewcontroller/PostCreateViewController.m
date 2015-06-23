//
//  PostCreateViewController.m
//  locality
//
//  Created by MRY on 5/25/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import "PostCreateViewController.h"
#import "PhotoUploadManager.h"
#import "ParseManager.h"
#import "AppUtilities.h"
#import "PostModel.h"
#import "UserModel.h"

@interface PostCreateViewController ()

@end

@implementation PostCreateViewController

static NSString * const kImageUploadNibName = @"ImageUploadView";
static NSString * const kPostFromNibName = @"PostFromView";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initHeaderView];
    [self initImageUploadView];
    [self initPostFromView];
    [self initCaption];
}

- (void)viewDidAppear:(BOOL)animated {
    [self startLocationServices];
}

- (void) initHeaderView {
    [self.header initWithTitle:@"POST"
                leftButtonType:IconBack
               rightButtonType:IconClose];
    
    [self.view addSubview:self.header];
}

-(void) initImageUploadView {
    
    _imageUploadView = [[[NSBundle mainBundle] loadNibNamed:kImageUploadNibName owner:self options:nil] objectAtIndex:0];
    [_imageUploadViewContainer addSubview:_imageUploadView];
    
    _imageUploadView.delegate = self;
}

-(void) initPostFromView {
    
    _postFromView = [[[NSBundle mainBundle] loadNibNamed:kPostFromNibName owner:self options:nil] objectAtIndex:0];
    [_postFromViewContainer addSubview:_postFromView];
}

- (void)startLocationServices {
    
    NSLog(@"start location services");
    if (nil == _locationManager) {
        _locationManager = [[CLLocationManager alloc] init];
        
    }
    
    _locationManager.delegate = self;
    //[_locationManager startUpdatingLocation];
    [_locationManager requestWhenInUseAuthorization];
}

- (void) initCaption {
    _captionField.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ImageUploadViewDelegate Methods
-(void) takePhotoTapped {
    [self checkCameraAccess];
}

-(void) uploadPhotoTapped {
    [self checkCameraAccess];
}

#pragma mark - CLLocationManager Delegate Methods
- (void) locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    if( status == kCLAuthorizationStatusAuthorizedWhenInUse ) {
        [_locationManager startUpdatingLocation];
    }
}


- (void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    CLLocation *location = [locations objectAtIndex:0];
    _currentLocation = location.coordinate;
    NSLog(@"location received: %f, %f", _currentLocation.latitude, _currentLocation.longitude);
    //location only needed here to show current location. We will have location on otherwise when you update the current location feed
    [_locationManager stopUpdatingLocation];
}

#pragma mark - UITextView Delegate Methods 
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}

#pragma mark - RSKImageCropper Override

-(void)imageCropViewController:(RSKImageCropViewController *)controller didCropImage:(UIImage *)croppedImage usingCropRect:(CGRect)cropRect {
    [super imageCropViewController:controller didCropImage:croppedImage usingCropRect:cropRect];
    
    [_imageUploadView setLocationImage:croppedImage];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - CTAs
-(IBAction)publishPostButtonTapped:(id)sender {
    
    
    //upload image
    if( _imageUploadView.selectedPhoto.image ) {
        [PhotoUploadManager uploadPhoto:_imageUploadView.selectedPhoto.image ofType:UserPostPhoto success:^(id response) {
            NSLog(@"URL: %@", response);
            [self createPostModelWithImageUrl:response];
            
        } failure:^(NSError *error) {
            NSLog(@"Picture Upload failure: %@", error);
        }];
    }
    
    else {
        //they have no image to upload... use default
        [self createPostModelWithImageUrl:@""];
    }
}

-(void) createPostModelWithImageUrl:(NSString *)url {
    
    //Build post model
    PostModel *newPost = [[PostModel alloc] init];
    
    if( !_postFromView.isAnonymous ) {
        newPost.username = [UserModel sharedInstance].username;
        newPost.profileImgUrl = [UserModel sharedInstance].profileImgUrl;
    }
    
    else {
        newPost.username = @"Anonymous";
        newPost.profileImgUrl = kDefaultAvatar;
    }
    
    newPost.postCaption = _captionField.text;
    
    //check if no location
    if( CLLocationCoordinate2DIsValid(_currentLocation)) {
        newPost.latitude = _currentLocation.latitude;
        newPost.longitude = _currentLocation.longitude;
    }
    
    else {
        NSLog(@"No location FOUND!");
        return;
    }
    
    newPost.postImgUrl = url;
    
    [self publishNewPost:newPost];
}

-(void)publishNewPost:(PostModel *)newPost {
    
    [ParseManager addNewPost:newPost success:^(id response) {
        NSLog(@"Post published!");
        
        //go back
        [self.navigationController popViewControllerAnimated:YES];
        
    } failure:^(NSError *error) {
        NSLog(@"Post Add Fail: %@", error);
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
