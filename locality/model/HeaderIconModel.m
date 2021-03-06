//
//  HeaderIconModel.m
//  locality
//
//  Created by Brian Maci on 6/12/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import "HeaderIconModel.h"

@implementation HeaderIconModel

+(NSString *)imageNameFromType:(HeaderIconType)t {
    
    switch (t) {
        case IconBack:
            return kIconBack;
            break;
        
        case IconClose:
            return kIconClose;
            break;
        
        case IconHamburger:
            return kIconHamburger;
            break;
            
        case IconFeedSettings:
            return kIconFeedSettings;
            break;
        
        case IconFeedMenu:
            return kIconFeedMenu;
            break;
        
        case IconNone:
            return @"";
            break;
            
        default:
            return @"";
            break;
    }
}

@end
