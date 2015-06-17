//
//  FacebookManager.h
//  locality
//
//  Created by Brian Maci on 5/13/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CallbackManager.h"

@interface FacebookManager : CallbackManager

+(void) initFacebookUtils:(NSDictionary *)launchOptions;

@end
