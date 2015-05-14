//
//  LoginViewController.h
//  locality
//
//  Created by Brian Maci on 5/13/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIButton *fbLogin;
@property (weak, nonatomic) IBOutlet UIButton *emailLogin;
@property (weak, nonatomic) IBOutlet UIButton *signupButton;

@property (weak, nonatomic) IBOutlet UIButton *termsButton;
@property (weak, nonatomic) IBOutlet UIButton *privacyButton;
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

-(IBAction)emailLoginButtonClicked:(id)sender;

@end
