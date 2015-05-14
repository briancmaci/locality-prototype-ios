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
#import <Parse/Parse.h>
#import <ParseFacebookUtilsV4/PFFacebookUtils.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import "config.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

static NSString *kMainFeedStoryboardId = @"mainFeedVC";
static NSString *kLoginStoryboardId = @"loginVC";


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [self initParse];
    
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
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateRootView:) name:kLoggedInNotify object:nil];
            [self showLoginView];
        }
    }
}

-(void) showMainFeedView
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    self.mainFeedVC = [storyboard instantiateViewControllerWithIdentifier:kMainFeedStoryboardId];
    self.window.rootViewController = self.mainFeedVC;
    
    //[FacebookManager getFacebookInfo];
}

-(void) showLoginView
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    //MRYActiveDirectoryLoginViewController *adViewController = [storyboard instantiateViewControllerWithIdentifier:@"mryADLoginVC"];
    //self.window.rootViewController = adViewController;
    
    self.loginVC = [storyboard instantiateViewControllerWithIdentifier:kLoginStoryboardId];
    self.window.rootViewController = self.loginVC;
    //[self.window addSubview:self.fbLoginViewController.view];
    //NSLog(@"FERSBERK!");
}

-(void)updateRootView:(NSNotification *)notification {
    
    [self showMainFeedView];
    NSLog(@"Update root view!");
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kLoggedInNotify object:nil];
}


- (void)initParse {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Info" ofType:@"plist"];
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
    NSString *appID = [dict objectForKey:@"ParseApplicationID"];
    NSString *clientKey = [dict objectForKey:@"ParseClientKey"];
    NSLog(@"init parse with: %@, %@", appID, clientKey);
    
    [Parse setApplicationId:appID clientKey:clientKey];
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
