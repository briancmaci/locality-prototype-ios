//
//  SignUpEmailFormViewController.m
//  locality
//
//  Created by Brian Maci on 5/13/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import "SignUpEmailFormViewController.h"
#import "ParseManager.h"
#import "UserModel.h"

@interface SignUpEmailFormViewController ()

@end

@implementation SignUpEmailFormViewController

static NSString *kBodyFormat = @"Almost done, %@!";

static NSString * kSignUpCompleteSegue = @"signupCompleteSegue";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initDelegates];
    [self populateBody];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) initDelegates {
    self.emailField.delegate = self;
    self.passwordField.delegate = self;
    self.passwordConfirmField.delegate = self;
}

-(void) populateBody {
    self.bodyField.text = [NSString stringWithFormat:kBodyFormat, self.incomingUsername];
}

#pragma mark - UITextFieldDelegate Methods
-(BOOL) textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)onSubmitClicked:(id)sender {
    
    NSLog(@"test parse signup here");
    [ParseManager signupUserViaEmail:self.emailField.text username:self.incomingUsername password:self.passwordField.text success:^(id response) {
        NSLog(@"SUCCESS!");
        
        //on success do...
        
        //populate user model
        [UserModel sharedInstance].username = self.incomingUsername;
        [UserModel sharedInstance].email = self.emailField.text;
        [UserModel sharedInstance].password = self.passwordField.text;
        [UserModel sharedInstance].isFirstTime = YES;
        
        [self performSegueWithIdentifier:kSignUpCompleteSegue sender:self];
        
        //set isFirstTime
        [[PFUser currentUser] setObject:@([UserModel sharedInstance].isFirstTime) forKey:@"isFirstTime"];
        [[PFUser currentUser] saveInBackground];
        
    } failure:^(NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}
@end
