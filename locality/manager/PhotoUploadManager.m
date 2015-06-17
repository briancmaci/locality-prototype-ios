//
//  PhotoUploadManager.m
//  locality
//
//  Created by Brian Maci on 6/17/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import "PhotoUploadManager.h"
#import <Parse/Parse.h>

@implementation PhotoUploadManager

static NSString * const kLocationFeedRoot = @"location_";
static NSString * const kProfileRoot = @"profile_";
static NSString * const kUserPostRoot = @"post_";

static float const kImageQuality = 0.5f;

+(void) uploadPhoto:(UIImage *)image ofType:(PhotoType)type success:(successBlock)successBlock failure:(failureBlock)failureBlock {
    
    NSData * imageData = UIImageJPEGRepresentation(image, kImageQuality);
    PFFile *imageFile = [PFFile fileWithName:[PhotoUploadManager buildPhotoURLForType:type] data:imageData];
    
    [imageFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        
        if( !error ) {
            //we have the object
            successBlock(imageFile.url);
        }
        
        else {
            failureBlock(error);
        }
    }];
}

+(NSString *)buildPhotoURLForType:(PhotoType)type {
    NSString * typeStr;
    
    switch (type) {
        case LocationFeedPhoto:
            typeStr = kLocationFeedRoot;
            break;
            
        case ProfilePhoto:
            typeStr = kProfileRoot;
            break;
            
        case UserPostPhoto:
            typeStr = kUserPostRoot;
    }
    
    return [NSString stringWithFormat:@"%@%@.jpg", typeStr, [[NSUUID UUID] UUIDString]];
}


@end
