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

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setBackgroundColor:[UIColor clearColor]];
        
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    static dispatch_once_t once;
    dispatch_once(&once, ^ {
        _context = UIGraphicsGetCurrentContext();
   
        CGContextClearRect(_context, self.bounds);
        CGContextSetFillColorWithColor(_context, [UIColor whiteColor].CGColor);
            
        CGContextSetShadowWithColor(_context, CGSizeMake( 0, kShadowOffset ), kShadowBlur, [UIColor leftNavLightColor].CGColor);
        CGContextSetLineWidth(_context, 0);
        
        CGContextMoveToPoint(_context, 0, 0);
        CGContextAddLineToPoint(_context, self.bounds.size.width, 0);
        CGContextAddLineToPoint(_context, self.bounds.size.width, self.bounds.size.height - kPointHeight - kShadowOffset);
        CGContextAddLineToPoint(_context, self.bounds.size.width/2 + kPointWidth/2, self.bounds.size.height - kPointHeight - kShadowOffset);
        CGContextAddLineToPoint(_context, self.bounds.size.width/2, self.bounds.size.height - kShadowOffset);
        CGContextAddLineToPoint(_context, self.bounds.size.width/2 - kPointWidth/2, self.bounds.size.height - kPointHeight - kShadowOffset);
        CGContextAddLineToPoint(_context, 0, self.bounds.size.height - kPointHeight - kShadowOffset);
        CGContextAddLineToPoint(_context, 0, 0);
        CGContextClosePath(_context);
        
        CGContextDrawPath(_context, kCGPathFillStroke);
     });
    //[self setNeedsDisplay];
    //UIGraphicsEndImageContext();
}

@end
