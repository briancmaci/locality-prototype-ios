//
//  AppUtilities.h
//  locality
//
//  Created by Brian Maci on 5/15/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>

@interface AppUtilities : NSObject

+(float) feetToMeters:(float)valueInFeet;
+(float) metersToFeet:(float)valueInMeters;

+(NSMutableAttributedString *) rangeLabel:(NSString *)size withUnits:(NSString *)unit;
+(NSString *) locationLabelFromAddress:(GMSAddress *)address;

+(void) loadProfileImage:(UIImageView *)imgView;
+(void) loadFeedPostProfileImage:(UIImageView *)imgView fromURL:(NSString *)imgUrl;
+(void) loadPostImage:(NSString *)imgUrl intoView:(UIImageView *)imgView;

@end
