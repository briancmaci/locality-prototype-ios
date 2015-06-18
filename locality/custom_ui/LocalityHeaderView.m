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
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, kHeaderTitleY0, DEVICE_WIDTH, kHeaderTitleHeight)];
    [_titleLabel setFont:[UIFont fontWithName:kMainFont size:kHeaderFontSize]];
    [_titleLabel setTextColor:[UIColor whiteColor]];
    [_titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self addSubview:_titleLabel];
    
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
    
    if( type == IconNone ) return;
    
    _leftIconButton = [[HeaderIconButton alloc] initWithType:type];
    _leftIconButton.frame = CGRectMake(kHeaderButtonIndent,
                                       kHeaderTitleY0 + kHeaderTitleHeight/2 - _leftIconButton.frame.size.height/2,
                                       _leftIconButton.frame.size.width,
                                       _leftIconButton.frame.size.height);
    
    [self bindEventFor:_leftIconButton];
    [self addSubview:_leftIconButton];
}

- (void) setRightButton:(HeaderIconType)type {
    
    if( type == IconNone ) return;
    
    _rightIconButton = [[HeaderIconButton alloc] initWithType:type];
    _rightIconButton.frame = CGRectMake(DEVICE_WIDTH - kHeaderButtonIndent - _rightIconButton.frame.size.width,
                                        kHeaderTitleY0 + kHeaderTitleHeight/2 - _rightIconButton.frame.size.height/2,
                                        _rightIconButton.frame.size.width,
                                        _rightIconButton.frame.size.height);
    
    [self bindEventFor:_rightIconButton];
    [self addSubview:_rightIconButton];
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
