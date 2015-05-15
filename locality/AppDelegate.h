//
//  AppDelegate.h
//  locality
//
//  Created by Brian Maci on 5/7/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainFeedNavigationController.h"
#import "LoginViewController.h"
#import "FeedViewController.h"
#import "CurrentFeedInitializeViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) MainFeedNavigationController *mainFeedNavVC;
@property (strong, nonatomic) UINavigationController *loginNavVC;

@property (strong, nonatomic) FeedViewController *currentFeedVC;
@property (strong, nonatomic) CurrentFeedInitializeViewController *currentFeedInitVC;

@end

