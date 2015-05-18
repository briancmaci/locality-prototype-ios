//
//  FacebookManager.h
//  locality
//
//  Created by Brian Maci on 5/13/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FacebookManager : NSObject

typedef void(^failureBlock)(NSError *error);
typedef void(^successBlock)(id response);

+(void) initFacebookUtils:(NSDictionary *)launchOptions;

@end
