//
//  AppDelegate.m
//  locality
//
//  Created by Brian Maci on 5/7/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import "AppDelegate.h"
#import "ParseManager.h"
#import "FacebookManager.h"
#import "FlickrManager.h"
#import "GoogleMapsManager.h"
#import <Parse/Parse.h>
#import <ParseFacebookUtilsV4/PFFacebookUtils.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FlickrKit/FlickrKit.h>
#import "config.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

static NSString *kLoginNavStoryboardId = @"loginNavigationVC";

static NSString *kCurrentFeedInitStoryboardId = @"currentFeedInitVC";
static NSString *kCurrentFeedStoryboardId = @"mainFeedVC";


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //initialize APIs
    [FlickrManager initFlickr];
    [ParseManager initParse];
    [GoogleMapsManager initGoogleMaps];
    [FacebookManager initFacebookUtils:launchOptions];
    
    [self loadInitialView];
    
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                    didFinishLaunchingWithOptions:launchOptions];
    //return YES;
}

- (void)loadInitialView {
    if ([PFUser currentUser]){
        if( ([[PFUser currentUser][@"emailVerified"] boolValue]) || [PFFacebookUtils isLinkedWithUser:[PFUser currentUser]] ) {
            [self showMainFeedView];
        }
        
        else{
            //no valid current user
            [self showLoginView];
        }
    }
    
    else{
        //no current user at all
        [self showLoginView];
    }
}

-(void) showMainFeedView
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    //check if it's the first time
    if( [[[PFUser currentUser] objectForKey:@"isFirstTime"] boolValue] ) {
        self.currentFeedInitVC = [storyboard instantiateViewControllerWithIdentifier:kCurrentFeedInitStoryboardId];
        self.mainFeedNavVC = [[MainFeedNavigationController alloc] initWithRootViewController:self.currentFeedInitVC];
    }
    
    else {
        self.currentFeedVC = [storyboard instantiateViewControllerWithIdentifier:kCurrentFeedStoryboardId];
        self.mainFeedNavVC = [[MainFeedNavigationController alloc] initWithRootViewController:self.currentFeedVC];
    }
    self.window.rootViewController = self.mainFeedNavVC;
    
}

-(void) showLoginView
{
    //add login notification listener for auth success
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateRootView:) name:kLoggedInNotify object:nil];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    self.loginNavVC = [storyboard instantiateViewControllerWithIdentifier:kLoginNavStoryboardId];
    self.window.rootViewController = self.loginNavVC;
}

-(void)updateRootView:(NSNotification *)notification {
    NSLog(@"Update root view!");
    [self showMainFeedView];
    
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kLoggedInNotify object:nil];
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                                          openURL:url
                                                sourceApplication:sourceApplication
                                                       annotation:annotation];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    [FBSDKAppEvents activateApp];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
