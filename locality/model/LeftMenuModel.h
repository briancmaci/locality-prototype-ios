//
//  LeftMenuModel.h
//  locality
//
//  Created by Brian Maci on 6/24/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LeftMenuModel : NSObject

typedef enum {
    
    ViewSegue,
    Action,
    LeftMenuTypeUnknown
    
} LeftMenuType;

typedef enum {
    
    StyleLight,
    StyleDark
    
} LeftMenuStyleType;

+(LeftMenuType)typeFromPListString:(NSString *)typeString;
+(LeftMenuStyleType)styleTypeFromPListString:(NSString *)styleString;

@end
