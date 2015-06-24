//
//  LeftMenuModel.m
//  locality
//
//  Created by Brian Maci on 6/24/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import "LeftMenuModel.h"

@implementation LeftMenuModel

static NSString * const kTypeSegue = @"ViewSegue";
static NSString * const kTypeAction = @"Action";

static NSString * const kStyleLight = @"light";
static NSString * const kStyleDark = @"dark";

+(LeftMenuType)typeFromPListString:(NSString *)typeString {
    
    if( [typeString isEqualToString:kTypeSegue] ) {
        return ViewSegue;
    }
    
    else if( [typeString isEqualToString:kTypeAction] ) {
        return Action;
    }
    
    else return LeftMenuTypeUnknown;
}

+(LeftMenuStyleType)styleTypeFromPListString:(NSString *)styleString {
    
    if( [styleString isEqualToString:kStyleLight] ) {
        return StyleLight;
    }
    
    else return StyleDark;
}


@end
