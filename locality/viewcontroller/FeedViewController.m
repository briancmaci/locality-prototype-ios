//
//  FeedViewController.m
//  locality
//
//  Created by Brian Maci on 5/13/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import "FeedViewController.h"
#import "UserModel.h"
#import "config.h"
#import "ParseManager.h"

@interface FeedViewController ()

@end

@implementation FeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initSlideMenu];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) initSlideMenu {
    _feedMenu = [[FeedSliderMenuView alloc] initWithCurrentLocation:[UserModel sharedInstance].currentLocation andPinnedLocations:[UserModel sharedInstance].pinnedLocations];
    [self.view addSubview:_feedMenu];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
