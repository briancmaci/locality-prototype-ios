//
//  FeedMenuViewController.m
//  locality
//
//  Created by MRY on 5/25/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import "FeedMenuViewController.h"
#import "UserModel.h"

@interface FeedMenuViewController ()

@end

@implementation FeedMenuViewController

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
