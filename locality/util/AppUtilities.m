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
#import "config.h"

@implementation AppUtilities

static const float metersPerFoot = 0.3048;

+(float) feetToMeters:(float)valueInFeet {
    return metersPerFoot * valueInFeet;
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

@end
