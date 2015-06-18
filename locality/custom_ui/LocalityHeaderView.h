//
//  LocalityHeaderView.h
//  locality
//
//  Created by Brian Maci on 6/12/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderIconButton.h"
#import "FeedLocationModel.h"

@protocol LocalityHeaderViewDelegate <NSObject>

//delegate methods
-(void)iconClicked:(HeaderIconButton *)sender;

@optional
-(void)openFeedClicked:(FeedLocationModel *)model atIndex:(int)index;

@end

@interface LocalityHeaderView : UIView

@property (weak, nonatomic) id<LocalityHeaderViewDelegate> delegate;

@property (strong, nonatomic) IBOutlet UIImageView *bgImage;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;

@property (strong, nonatomic) HeaderIconButton *leftIconButton;
@property (strong, nonatomic) HeaderIconButton *rightIconButton;

-(void) updateWithBackgroundImage:(UIImage *)bg;
-(void) initWithTitle:(NSString *)title leftButtonType:(HeaderIconType)leftType rightButtonType:(HeaderIconType)rightType;

@end
