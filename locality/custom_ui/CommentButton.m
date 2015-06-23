//
//  CommentButton.m
//  locality
//
//  Created by Brian Maci on 6/23/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import "CommentButton.h"
#import "UIColor+LocalityColor.h"

@implementation CommentButton

-(id) initWithCoder:(NSCoder *)aDecoder {
    
    if( (self = [super initWithCoder:aDecoder])) {
        
        self.layer.cornerRadius = self.frame.size.height/2;
        self.layer.borderColor = [[UIColor blueUIColor] CGColor];
        self.layer.borderWidth = 1.0f;
    }
    
    return self;
}

@end
