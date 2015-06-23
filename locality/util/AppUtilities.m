//
//  AppUtilities.m
//  locality
//
//  Created by Brian Maci on 5/15/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import "AppUtilities.h"
#import <CoreText/CTStringAttributes.h>
#import <CoreText/CoreText.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "UserModel.h"
#import "config.h"

@implementation AppUtilities

static const float metersPerFoot = 0.3048;

+(float) feetToMeters:(float)valueInFeet {
    return metersPerFoot * valueInFeet;
}

+(float) metersToFeet:(float)valueInMeters {
    return valueInMeters * (1/metersPerFoot);
}

+(NSMutableAttributedString *) rangeLabel:(NSString *)size withUnits:(NSString *)unit {
    //NSLog(@"size %@, unit %@", size, unit);
    //NSLog (@"Font families: %@", [UIFont familyNames]);
    NSString *string = [NSString stringWithFormat:@"%@%@", size, unit];
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:string];
    
    UIFont *font = [UIFont fontWithName:kMainFont size:14.0f];
    UIFont *smallFont = [UIFont fontWithName:kMainFont size:9.0f];
    
    [attString beginEditing];
    [attString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, size.length)];
    [attString addAttribute:NSFontAttributeName value:smallFont range:NSMakeRange(size.length, unit.length)];
    [attString addAttribute:(NSString*)kCTSuperscriptAttributeName value:@"1" range:NSMakeRange(size.length, unit.length)];
    [attString endEditing];
    
    return attString;
}

+(NSString *)locationLabelFromAddress:(GMSAddress *)address {
    
    return [NSString stringWithFormat:@"— %@, %@ —", address.locality ? address.locality : address.subLocality, address.administrativeArea ? address.administrativeArea : address.country];
}

+(void) loadProfileImage:(UIImageView *)imgView {
    
    if( ![[UserModel sharedInstance].profileImgUrl isEqualToString:kDefaultAvatar] ) {
        [imgView sd_setImageWithURL:[NSURL URLWithString:[UserModel sharedInstance].profileImgUrl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if(cacheType == SDImageCacheTypeDisk || cacheType == SDImageCacheTypeNone) {
                imgView.alpha = 0;
                [UIView animateWithDuration:0.25 animations:^{
                    [imgView setAlpha:1];
                }];
            }
            
            else {
                [imgView setAlpha:1];
            }
        }];
    }
    
    else {
        [imgView setImage:[UIImage imageNamed:kDefaultAvatar]];
    }
    
}

+(void) loadFeedPostProfileImage:(UIImageView *)imgView fromURL:(NSString *)imgUrl {
    if( ![imgUrl isEqualToString:kDefaultAvatar] ) {
        [imgView sd_setImageWithURL:[NSURL URLWithString:imgUrl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if(cacheType == SDImageCacheTypeDisk || cacheType == SDImageCacheTypeNone) {
                imgView.alpha = 0;
                [UIView animateWithDuration:0.25 animations:^{
                    [imgView setAlpha:1];
                }];
            }
            
            else {
                [imgView setAlpha:1];
            }
        }];
    }
    
    else {
        [imgView setImage:[UIImage imageNamed:kDefaultAvatar]];
    }
}

+(void) loadPostImage:(NSString *)imgUrl intoView:(UIImageView *)imgView {
    
    [imgView sd_setImageWithURL:[NSURL URLWithString:imgUrl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if(cacheType == SDImageCacheTypeDisk || cacheType == SDImageCacheTypeNone) {
            imgView.alpha = 0;
            [UIView animateWithDuration:0.25 animations:^{
                [imgView setAlpha:1];
            }];
        }
            
        else {
            [imgView setAlpha:1];
        }
    }];
}

@end
