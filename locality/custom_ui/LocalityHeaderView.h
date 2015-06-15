//
//  LocalityHeaderView.h
//  locality
//
//  Created by Brian Maci on 6/12/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderIconButton.h"

@protocol LocalityHeaderViewDelegate <NSObject>

//delegate methods
-(void)iconClicked:(HeaderIconButton *)sender;

@end

@interface LocalityHeaderView : UIView

@property (weak, nonatomic) id<LocalityHeaderViewDelegate> delegate;

@property (strong, nonatomic) UIImageView *bgImage;
@property (strong, nonatomic) UILabel *titleLabel;

-(void) updateWithBackgroundImage:(UIImage *)bg;
-(void) initWithTitle:(NSString *)title leftButtonType:(HeaderIconType)leftType rightButtonType:(HeaderIconType)rightType;

@end
