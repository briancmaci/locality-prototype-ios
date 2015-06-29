//
//  PostDetailHeaderBackgroundView.m
//  locality
//
//  Created by Brian Maci on 6/26/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import "PostDetailHeaderBackgroundView.h"
#import "UIColor+LocalityColor.h"

@implementation PostDetailHeaderBackgroundView

static float const kPointHeight = 5.0f;
static float const kPointWidth = 10.0f;
static float const kShadowOffset = 1.0f;
static float const kShadowBlur = 0.6f;

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        //[self drawBackground];
        [self setBackgroundColor:[UIColor clearColor]];
        [self setOpaque:NO];
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    //static dispatch_once_t once;
    //dispatch_once(&once, ^ {
    CGContextClearRect(UIGraphicsGetCurrentContext(), self.bounds);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    
        CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
            
        CGContextSetShadowWithColor(context, CGSizeMake( 0, kShadowOffset ), kShadowBlur, [UIColor leftNavLightColor].CGColor);
        CGContextSetLineWidth(context, 0);
        
        CGContextMoveToPoint(context, 0, 0);
        CGContextAddLineToPoint(context, self.bounds.size.width, 0);
        CGContextAddLineToPoint(context, self.bounds.size.width, self.bounds.size.height - kPointHeight - kShadowOffset);
        CGContextAddLineToPoint(context, self.bounds.size.width/2 + kPointWidth/2, self.bounds.size.height - kPointHeight - kShadowOffset);
        CGContextAddLineToPoint(context, self.bounds.size.width/2, self.bounds.size.height - kShadowOffset);
        CGContextAddLineToPoint(context, self.bounds.size.width/2 - kPointWidth/2, self.bounds.size.height - kPointHeight - kShadowOffset);
        CGContextAddLineToPoint(context, 0, self.bounds.size.height - kPointHeight - kShadowOffset);
        CGContextAddLineToPoint(context, 0, 0);
        CGContextClosePath(context);
        
        CGContextDrawPath(context, kCGPathFillStroke);
    //});
    //[self setNeedsDisplay];
    //UIGraphicsEndImageContext();
}


@end
