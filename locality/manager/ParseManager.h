//
//  ParseManager.h
//  locality
//
//  Created by Brian Maci on 5/13/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface ParseManager : NSObject

typedef void(^failureBlock)(NSError *error);
typedef void(^successBlock)(id response);

+(void) signupUserViaEmail:(NSString *)email username:(NSString *)username password:(NSString *)password success:(successBlock)successBlock failure:(failureBlock)failureBlock;
+(void) loginViaUsername:(NSString *)username password:(NSString *)password success:(successBlock)successBlock failure:(failureBlock)failureBlock;
@end
