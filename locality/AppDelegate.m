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
#import "MapBoxManager.h"
#import "SlideNavigationController.h"
#import "SlideNavigationContorllerAnimatorSlideAndFade.h"
#import "LocalityLeftMenuViewController.h"
#import <Parse/Parse.h>
#import <ParseFacebookUtilsV4/PFFacebookUtils.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FlickrKit/FlickrKit.h>
#import "config.h"
#import "BusyView.h"
#import "DataManager.h"
#import "UserModel.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //initialize APIs
    [FlickrManager initFlickr];
    [ParseManager initParse];
    [GoogleMapsManager initGoogleMaps];
    [MapBoxManager initMapBox];
    [FacebookManager initFacebookUtils:launchOptions];
    
    [self.window makeKeyAndVisible];
    
    [self initStatusBar];
    [self initSlideNavigation];
    [self initStoryboardAccess];
    [self initBusyView];
    [self loadInitialView];
    
    
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                    didFinishLaunchingWithOptions:launchOptions];
    //return YES;
}

-(void) initStatusBar {
    
    //not sure where this will be. design dependent.
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

-(void) initSlideNavigation {
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LocalityLeftMenuViewController *leftMenu = (LocalityLeftMenuViewController *)[mainStoryboard instantiateViewControllerWithIdentifier:kLeftMenuStoryboardId];
    
    [SlideNavigationController sharedInstance].leftMenu = leftMenu;
    
    //set offset
    [SlideNavigationController sharedInstance].portraitSlideOffset = kSlideOffset;
    [SlideNavigationController sharedInstance].avoidSwitchingToSameClassViewController = YES;
    
    //set animation style
    id <SlideNavigationContorllerAnimator> revealAnimator = [[SlideNavigationContorllerAnimatorSlideAndFade alloc] init];
    [SlideNavigationController sharedInstance].menuRevealAnimator = revealAnimator;
}

-(void) initStoryboardAccess {
    
    //just setting the storyboard to a class var for easy access.
    _storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
}

-(void) initBusyView {
    
    //overlay to indicate the app is thinking. Design dependent. (May be just a status bar rather than full-screen).
    [[BusyView sharedInstance] setHidden:YES];
    [self.window addSubview:[BusyView sharedInstance]];
    
}

- (void)loadInitialView {
    if ([PFUser currentUser]){
        if( ([[PFUser currentUser][@"emailVerified"] boolValue]) || [PFFacebookUtils isLinkedWithUser:[PFUser currentUser]] ) {
            [self showMainFeedView];
        }
        
        else{
            //no valid current Parse user
            [self showLoginLandingView];
        }
    }
    
    else{
        //no user at all
        [self showLoginLandingView];
    }
}

-(void) showMainFeedView
{
    
    
    //check if it's the first time
    if( [[[PFUser currentUser] objectForKey:@"isFirstTime"] boolValue] ) {
        [[SlideNavigationController sharedInstance] popAllAndSwitchToViewController:[_storyboard instantiateViewControllerWithIdentifier:kCurrentFeedInitStoryboardId] withCompletion:nil];
    }
    
    else {
        
        //grab user data
        [DataManager parseUserDataIntoModel:[PFUser currentUser]];
        
        FeedViewController *currentFeedVC = [_storyboard instantiateViewControllerWithIdentifier:kCurrentFeedStoryboardId];
        currentFeedVC.isCurrentLocationFeed = YES;
        currentFeedVC.thisFeed = [UserModel sharedInstance].currentLocationFeed;
        
        //for now... let's push the feedMenu THEN the currentFeed to go back. Ultimately the Feed Menu VC and the Feed VC will be one view controller, with an expand/collapse animation between the two states.
        [[SlideNavigationController sharedInstance] popAllAndSwitchToViewController:[_storyboard instantiateViewControllerWithIdentifier:kFeedMenuStoryboardId] withCompletion:nil];
        [[SlideNavigationController sharedInstance] pushViewController:currentFeedVC animated:NO];
    }
}

-(void) showLoginLandingView
{
    //add login notification listener for auth success
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateRootView:) name:kLoggedInNotify object:nil];
    
    [[SlideNavigationController sharedInstance] popAllAndSwitchToViewController:[_storyboard instantiateViewControllerWithIdentifier:kLoginLandingStoryboardId] withCompletion:nil];
}

-(void)updateRootView:(NSNotification *)notification {
    
    //user is now authenticated, move on in.
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
