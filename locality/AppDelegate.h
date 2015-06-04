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
#import "FeedMenuTableViewController.h"
#import "CurrentFeedInitializeViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UINavigationController *loginNavVC;
@property (strong, nonatomic) FeedViewController *currentFeedVC;
@property (strong, nonatomic) FeedMenuTableViewController *feedMenuVC;
@property (strong, nonatomic) CurrentFeedInitializeViewController *currentFeedInitVC;

@end

