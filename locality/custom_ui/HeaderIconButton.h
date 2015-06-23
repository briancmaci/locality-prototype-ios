//
//  HeaderIconButton.h
//  locality
//
//  Created by Brian Maci on 6/12/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderIconModel.h"

@interface HeaderIconButton : UIButton

@property (nonatomic) HeaderIconType iconType;

- (id)initWithType:(HeaderIconType)type;
-(void)updateIconType:(HeaderIconType)type;

@end
