//
//  LoginViewController.m
//  locality
//
//  Created by Brian Maci on 5/13/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import "LoginViewController.h"
#import "ParseManager.h"
#import "config.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initDelegates];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) initDelegates {
    self.usernameField.delegate = self;
    self.passwordField.delegate = self;
}

#pragma mark - UITextFieldDelegate Methods
-(BOOL) textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

-(IBAction)emailLoginButtonClicked:(id)sender {
    [ParseManager loginViaUsername:self.usernameField.text password:self.passwordField.text success:^(id response) {
        NSLog(@"loggedin!");
        
        PFUser *user = (PFUser *)response;
        NSLog(@"email verified? %@", user[@"emailVerified"]);
        
        //load main feed view
        
        if( [user[@"emailVerified"] boolValue] ) {
            NSLog(@"sending notification now");
            [[NSNotificationCenter defaultCenter] postNotificationName:kLoggedInNotify object:nil userInfo:nil];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"not logged in: %@", error);
    }];
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
