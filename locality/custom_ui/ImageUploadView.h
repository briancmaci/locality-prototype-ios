//
//  ImageUploadView.h
//  locality
//
//  Created by Brian Maci on 6/16/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ImageUploadViewDelegate <NSObject>

-(void) takePhotoTapped;
-(void) uploadPhotoTapped;

@end

@interface ImageUploadView : UIView

@property (weak, nonatomic) id<ImageUploadViewDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIView *takePhotoView;
@property (weak, nonatomic) IBOutlet UIView *uploadPhotoView;
@property (weak, nonatomic) IBOutlet UIImageView *selectedPhoto;

-(void) setLocationImage:(UIImage *)image;

@end
