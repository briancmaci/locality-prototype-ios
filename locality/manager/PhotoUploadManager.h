//
//  PhotoUploadManager.h
//  locality
//
//  Created by Brian Maci on 6/17/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CallbackManager.h"

@interface PhotoUploadManager : CallbackManager

//enum types
typedef enum {
    
    ProfilePhoto,
    LocationFeedPhoto,
    UserPostPhoto
    
} PhotoType;


+(void) uploadPhoto:(UIImage *)image ofType:(PhotoType)type success:(successBlock)successBlock failure:(failureBlock)failureBlock;

@end
