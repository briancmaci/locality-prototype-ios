//
//  FacebookManager.m
//  locality
//
//  Created by Brian Maci on 5/13/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import "FacebookManager.h"
#import <ParseFacebookUtilsV4/PFFacebookUtils.h>

@implementation FacebookManager

+(void) initFacebookUtils:(NSDictionary *)launchOptions {
    [PFFacebookUtils initializeFacebookWithApplicationLaunchOptions:launchOptions];
}

@end
