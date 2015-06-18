//
//  HeaderIconModel.h
//  locality
//
//  Created by Brian Maci on 6/12/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "config.h"

@interface HeaderIconModel : NSObject

//enum types
typedef enum {
    
    IconBack,
    IconClose,
    IconHamburger,
    IconFeedSettings,
    IconFeedMenu,
    IconNone
    
} HeaderIconType;

+(NSString *)imageNameFromType:(HeaderIconType)t;

@end
