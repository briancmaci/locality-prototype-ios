//
//  CallbackManager.h
//  locality
//
//  Created by Brian Maci on 6/17/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CallbackManager : NSObject

typedef void(^failureBlock)(NSError *error);
typedef void(^successBlock)(id response);

@end
