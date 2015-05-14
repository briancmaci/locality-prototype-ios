//
//  SignUpViewController.m
//  locality
//
//  Created by Brian Maci on 5/13/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import "SignUpViewController.h"
#import "UserModel.h"
#import "SignUpEmailFormViewController.h"

@interface SignUpViewController ()

@end

@implementation SignUpViewController

static NSString * kSignupEmailFormSegue = @"signupEmailFormSegue";

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
}

#pragma mark - UITextFieldDelegate Methods
-(BOOL) textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

-(IBAction)emailSignupClicked:(id)sender {
    
    [self performSegueWithIdentifier:kSignupEmailFormSegue sender:self];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if([[segue identifier] isEqualToString:kSignupEmailFormSegue]) {
        
        SignUpEmailFormViewController *vc = [segue destinationViewController];
        vc.incomingUsername = self.usernameField.text;
    }
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
