//
//  UIColor+LocalityColor.m
//  locality
//
//  Created by Brian Maci on 6/12/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import "UIColor+LocalityColor.h"

@implementation UIColor (LocalityColor)

+(UIColor *)blueUIColor {
    return [UIColor colorWithRed:61.0f/255.0f
                           green:68.0f/255.0f
                            blue:74.0f/255.0f
                           alpha:1.0f];
}

+(UIColor *)orangeUIColor {
    return [UIColor colorWithRed:255.0f/255.0f
                           green:125.0f/255.0f
                            blue:108.0f/255.0f
                           alpha:1.0f];
}

+(UIColor *)mapCircleColor {
    return [UIColor colorWithRed:255.0f/255.0f
                           green:125.0f/255.0f
                            blue:108.0f/255.0f
                           alpha:0.2f];
}

+(UIColor *)lightGrayUIColor {
    return [UIColor colorWithRed:205.0f/255.0f
                           green:215.0f/255.0f
                            blue:219.0f/255.0f
                           alpha:1.0f];
}

+(UIColor *)redUIColor {
    return [UIColor colorWithRed:180.0f/255.0f
                           green:0.0f/255.0f
                            blue:38.0f/255.0f
                           alpha:1.0f];
}

+(UIColor *)leftNavLightColor {
    return [UIColor colorWithRed:204.0f/255.0f
                           green:204.0f/255.0f
                            blue:204.0f/255.0f
                           alpha:1.0f];
}

+(UIColor *)leftNavDarkColor {
    return [UIColor colorWithRed:75.0f/255.0f
                           green:81.0f/255.0f
                            blue:85.0f/255.0f
                           alpha:1.0f];
}

+(UIColor *)leftNavSelectedColor {
    return [UIColor colorWithRed:0.0f/255.0f
                           green:0.0f/255.0f
                            blue:0.0f/255.0f
                           alpha:0.5f];
}

@end
