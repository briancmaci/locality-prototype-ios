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

+(void) initParse;

//authentication + signup
+(void) signupUserViaEmail:(NSString *)email username:(NSString *)username password:(NSString *)password success:(successBlock)successBlock failure:(failureBlock)failureBlock;
+(void) loginViaUsername:(NSString *)username password:(NSString *)password success:(successBlock)successBlock failure:(failureBlock)failureBlock;
+(void) signupUserViaFacebookWithUsername:(NSString *)username success:(successBlock)successBlock failure:(failureBlock)failureBlock;
+(void) loginViaFacebook:(NSString *)username password:(NSString *)password success:(successBlock)successBlock failure:(failureBlock)failureBlock;


//queries
+(void) isValidUsername:(NSString *)username success:(successBlock)successBlock failure:(failureBlock)failureBlock;

@end
