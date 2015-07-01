//
//  PostCreateViewController.h
//  locality
//
//  Created by MRY on 5/25/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LocalityPhotoBaseViewController.h"
#import "ImageUploadView.h"
#import "PostFromView.h"

@interface PostCreateViewController : LocalityPhotoBaseViewController <ImageUploadViewDelegate, CLLocationManagerDelegate, UITextViewDelegate>

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (nonatomic) CLLocationCoordinate2D currentLocation;

@property (weak, nonatomic) IBOutlet UITextView *captionField;

@property (weak, nonatomic) IBOutlet ImageUploadView *imageUploadView;
@property (strong, nonatomic) IBOutlet PostFromView *postFromView;

@property (weak, nonatomic) IBOutlet UIButton *publishPostButton;
@end
