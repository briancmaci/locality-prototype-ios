//
//  LocalityHeaderView.m
//  locality
//
//  Created by Brian Maci on 6/12/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import "LocalityHeaderView.h"
#import "UIColor+LocalityColor.h"
#import "config.h"

@implementation LocalityHeaderView

static float const kTitleHeight = 20.0f;
static float const kStatusBarOffset = 10.0f;

-(id) initWithFrame:(CGRect)frame {
    
    if( self = [super initWithFrame:frame] ) {
        [self initHeaderViewStage];
    }
    return self;
}

-(void) initHeaderViewStage {
    
    //default background & foreground
    [self setBackgroundColor:[UIColor blueUIColor]];
    [self setTintColor:[UIColor whiteColor]];
    
    //set bg image
    _bgImage = [[UIImageView alloc] initWithFrame:self.frame];
    [self addSubview:_bgImage];
    
    //set title
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, kHeaderHeight/2 + kStatusBarOffset - kTitleHeight/2, DEVICE_WIDTH, kTitleHeight)];
    [_titleLabel setFont:[UIFont fontWithName:kMainFont size:kHeaderFontSize]];
    [_titleLabel setTextColor:[UIColor whiteColor]];
    [_titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self addSubview:_titleLabel];
    
    //set back button
    
}


#pragma mark - Custom Methods
-(void) updateWithBackgroundImage:(UIImage *)bg {
    
    [_bgImage setImage:bg];
}

-(void) initWithTitle:(NSString *)title leftButtonType:(HeaderIconType)leftType rightButtonType:(HeaderIconType)rightType; {
    
    [self setTitle:title];
    [self setLeftButton:leftType];
    [self setRightButton:rightType];
}

- (void) setTitle:(NSString *)title {
    if( ![title isEqualToString:kNavBarTitleUseLogo]) {
        [_titleLabel setText:[title uppercaseString]];
    }
    
    else {
        //set logo
        [_titleLabel setText:@""];
        
        //place logo
        //        UIImageView *headerLogo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"header_logo"]];
        //
        //        CGRect centeredFrame = CGRectMake((DEVICE_WIDTH/2) - (headerLogo.frame.size.width/2) , (kNavBarHeight/2) - (headerLogo.frame.size.height/2) + 6.0f, headerLogo.frame.size.width, headerLogo.frame.size.height);
        //        headerLogo.frame = centeredFrame;
        //
        //        [self addSubview:headerLogo];
    }
}


- (void) setLeftButton:(HeaderIconType)type {
    
    HeaderIconButton *b = [[HeaderIconButton alloc] initWithType:type];
    b.frame = CGRectMake(kHeaderButtonIndent, (kHeaderHeight - b.frame.size.height)/2 + kStatusBarOffset, b.frame.size.width, b.frame.size.height);
    [self bindEventFor:b];
    [self addSubview:b];
}

- (void) setRightButton:(HeaderIconType)type {
    
    HeaderIconButton *b = [[HeaderIconButton alloc] initWithType:type];
    b.frame = CGRectMake(DEVICE_WIDTH - kHeaderButtonIndent - b.frame.size.width, (kHeaderHeight - b.frame.size.height)/2 + kStatusBarOffset, b.frame.size.width, b.frame.size.height);
    [self bindEventFor:b];
    [self addSubview:b];
}

-(void) bindEventFor:(HeaderIconButton *)b {
    //bind button event
    [b addTarget:self action:@selector(onIconClick:) forControlEvents:UIControlEventTouchUpInside];
}



-(void) onIconClick:(HeaderIconButton *)sender {
    if([self.delegate respondsToSelector:@selector(iconClicked:)]){
        [self.delegate iconClicked:sender];
    }
}


@end
