//
//  LocalityBaseViewController.h
//  locality
//
//  Created by Brian Maci on 6/12/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LocalityHeaderView.h"
#import "config.h"

@interface LocalityBaseViewController : UIViewController <LocalityHeaderViewDelegate>

@property (strong, nonatomic) LocalityHeaderView *header;
@end
