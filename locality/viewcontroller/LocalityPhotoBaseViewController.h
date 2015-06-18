//
//  LocalityPhotoBaseViewController.h
//  locality
//
//  Created by Brian Maci on 6/18/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import "LocalityBaseViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "RSKImageCropViewController.h"

@interface LocalityPhotoBaseViewController : LocalityBaseViewController <UIActionSheetDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, RSKImageCropViewControllerDelegate, RSKImageCropViewControllerDataSource>

-(void)checkCameraAccess;

@end
