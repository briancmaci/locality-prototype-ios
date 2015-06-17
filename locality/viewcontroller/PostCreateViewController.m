//
//  PostCreateViewController.m
//  locality
//
//  Created by MRY on 5/25/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import "PostCreateViewController.h"

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

#pragma mark - RSKImageCropper Override

-(void)imageCropViewController:(RSKImageCropViewController *)controller didCropImage:(UIImage *)croppedImage usingCropRect:(CGRect)cropRect {
    [super imageCropViewController:controller didCropImage:croppedImage usingCropRect:cropRect];
    
    [_imageUploadView setLocationImage:croppedImage];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - CTAs
-(IBAction)publishPostButtonTapped:(id)sender {

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
