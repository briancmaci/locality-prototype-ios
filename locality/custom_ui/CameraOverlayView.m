//
//  CameraOverlayView.m
//  modelme
//
//  Created by bmaci on 2/10/15.
//  Copyright (c) 2015 mry. All rights reserved.
//

#import "CameraOverlayView.h"
#import "config.h"

@implementation CameraOverlayView

- (void)awakeFromNib {
    // Initialization code
    [self resetOverlayView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showCameraOverlay) name:@"_UIImagePickerControllerUserDidRejectItem" object:nil ];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)showCameraOverlay {
    self.hidden = NO;
}

-(IBAction)takePicture:(id)sender {
    [self.pickerReference takePicture];
    [self setHidden:YES];
}

-(IBAction)toggleCamera:(id)sender {
    
    if( self.pickerReference.cameraDevice == UIImagePickerControllerCameraDeviceFront) {
        self.pickerReference.cameraDevice = UIImagePickerControllerCameraDeviceRear;
    }
    
    else if( self.pickerReference.cameraDevice == UIImagePickerControllerCameraDeviceRear) {
        self.pickerReference.cameraDevice = UIImagePickerControllerCameraDeviceFront;
    }
    
}

-(IBAction)closeCamera:(id)sender {
    [self.pickerReference dismissViewControllerAnimated:YES completion:nil];
}

-(IBAction)toggleGrid:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    
    [self.gridOverlay setHidden:!sender.selected];
}

-(IBAction)toggleFlash:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    
    self.pickerReference.cameraFlashMode = (sender.selected ? UIImagePickerControllerCameraFlashModeOn : UIImagePickerControllerCameraFlashModeOff);
}

-(void) resetOverlayView {
    
    CGRect cf = self.frame;
    cf.size.width = DEVICE_WIDTH;
    cf.size.height = DEVICE_HEIGHT;
    self.frame = cf;
    
    [self.gridOverlay setHidden:YES];
    self.gridButton.selected = NO;
    
    self.pickerReference.cameraFlashMode = UIImagePickerControllerCameraFlashModeOff;
    self.flashButton.selected = NO;
    
    self.hidden = NO;
}

@end
