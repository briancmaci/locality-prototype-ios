//
//  LocalityLeftMenuViewController.m
//  locality
//
//  Created by Brian Maci on 6/19/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import "LocalityLeftMenuViewController.h"
#import "UserModel.h"
#import "AppUtilities.h"

@interface LocalityLeftMenuViewController ()

@end

@implementation LocalityLeftMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initProfileImage];
    [self initLabels];
}

- (void) viewDidLayoutSubviews {
    [_profileImage updateImageMask];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) initProfileImage {
    [AppUtilities loadProfileImage:_profileImage];
}

-(void) initLabels {
    [_usernameLabel setText:[UserModel sharedInstance].username];
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
