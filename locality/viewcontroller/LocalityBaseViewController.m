//
//  LocalityBaseViewController.m
//  locality
//
//  Created by Brian Maci on 6/12/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import "LocalityBaseViewController.h"
#import "SlideNavigationController.h"
#import "CameraOverlayView.h"

@interface LocalityBaseViewController ()

@end

@implementation LocalityBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSLog(@"localitybase viewDidLoad");
    [self loadHeaderView];
        
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) loadHeaderView {
    _header = [[LocalityHeaderView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, kHeaderHeight)];
    //[self.view addSubview:_header];
    
    _header.delegate = self;
}

#pragma mark - LocalityHeaderViewDelegate Methods

-(void) iconClicked:(HeaderIconButton *)sender {
    
    switch(sender.iconType) {
        
        case IconBack:
            [self.navigationController popViewControllerAnimated:YES];
            break;
        
        case IconClose:
            NSLog(@"Close Button Clicked");
            break;
            
        case IconHamburger:
            [[SlideNavigationController sharedInstance] openMenu:MenuLeft withCompletion:^{
                //menu left on complete
                NSLog(@"left menu opened");
            }];
            break;
    }
    
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
                          initWithTitle:@"locality"
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
//    [_imageUploadView setLocationImage:croppedImage];
//    [self.navigationController popViewControllerAnimated:YES];
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
