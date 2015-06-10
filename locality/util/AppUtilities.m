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
    
    UIFont *font = [UIFont fontWithName:@"InterstateLightCondensed" size:14.0f];
    UIFont *smallFont = [UIFont fontWithName:@"InterstateLightCondensed" size:10.0f];
    
    [attString beginEditing];
    [attString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, size.length)];
    [attString addAttribute:NSFontAttributeName value:smallFont range:NSMakeRange(size.length, unit.length)];
    [attString addAttribute:(NSString*)kCTSuperscriptAttributeName value:@"1" range:NSMakeRange(size.length, unit.length)];
    [attString endEditing];
    
    return attString;
}

@end
