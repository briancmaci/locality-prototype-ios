//
//  CameraOverlayView.h
//  modelme
//
//  Created by bmaci on 2/10/15.
//  Copyright (c) 2015 mry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CameraOverlayView : UIView

@property (strong, nonatomic) UIImagePickerController *pickerReference;

@property (strong, nonatomic) IBOutlet UIButton *takePictureButton;
@property (strong, nonatomic) IBOutlet UIButton *flashButton;
@property (strong, nonatomic) IBOutlet UIButton *cameraToggleButton;
@property (strong, nonatomic) IBOutlet UIButton *gridButton;
@property (strong, nonatomic) IBOutlet UIButton *closeButton;
@property (strong, nonatomic) IBOutlet UIImageView *gridOverlay;

-(IBAction)takePicture:(id)sender;
-(IBAction)toggleCamera:(id)sender;
-(IBAction)closeCamera:(id)sender;
-(IBAction)toggleGrid:(UIButton *)sender;
-(IBAction)toggleFlash:(UIButton *)sender;

@end
