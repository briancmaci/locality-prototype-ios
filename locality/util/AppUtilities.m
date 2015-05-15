//
//  AppUtilities.m
//  locality
//
//  Created by Brian Maci on 5/15/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import "AppUtilities.h"

@implementation AppUtilities

static const float metersPerFoot = 0.3048;

+(float) feetToMeters:(float)valueInFeet {
    return metersPerFoot * valueInFeet;
}

@end
