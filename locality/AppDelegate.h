//
//  AppDelegate.h
//  locality
//
//  Created by Brian Maci on 5/7/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginViewController.h"
#import "FeedViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) FeedViewController *mainFeedVC;
@property (strong, nonatomic) LoginViewController *loginVC;

@end

