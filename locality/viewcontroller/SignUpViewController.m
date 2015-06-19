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
#import "ParseManager.h"
#import "config.h"

@interface SignUpViewController ()

@end

@implementation SignUpViewController

static NSString * kSignUpEmailFormSegue = @"signupEmailFormSegue";
static NSString * kSignUpCompleteSegue = @"signupCompleteSegue";

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

-(IBAction)facebookSignupClicked:(id)sender {
    
    //testing username uniqueness
    [ParseManager isValidUsername:self.usernameField.text success:^(id response) {
        NSLog(@"parse query success");
        NSArray *matches = (NSArray *)response;
        if( matches.count ) {
            NSLog(@"Username in use");
        }
        
        else {
            NSLog(@"Go to facebook authentication process");
            [ParseManager signupUserViaFacebookWithUsername:self.usernameField.text success:^(id response) {
                NSLog(@"facebook signup success");
                
                //Not Sure If Needed
                //populate user model
                [UserModel sharedInstance].username = self.usernameField.text;
                [UserModel sharedInstance].isFirstTime = YES;
                [UserModel sharedInstance].userStatus = UserStatusNewUser;
                [[PFUser currentUser] setObject:@([UserModel sharedInstance].isFirstTime) forKey:@"isFirstTime"];
                [[PFUser currentUser] saveInBackground];
                
                //[self performSegueWithIdentifier:kSignUpCompleteSegue sender:self];
                [[NSNotificationCenter defaultCenter] postNotificationName:kLoggedInNotify object:nil userInfo:nil];
                
            } failure:^(NSError *error) {
                NSLog(@"facebook signup fail");
            }];
        }
    } failure:^(NSError *error) {
        NSLog(@"parse query fail: %@", error);
    }];
}

-(IBAction)emailSignupClicked:(id)sender {
    
    
    [ParseManager isValidUsername:self.usernameField.text success:^(id response) {
        NSLog(@"parse query success");
        NSArray *matches = (NSArray *)response;
        if( matches.count ) {
            NSLog(@"Username in use");
        }
        else {
            [self performSegueWithIdentifier:kSignUpEmailFormSegue sender:self];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"parse query fail: %@", error);
    }];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if([[segue identifier] isEqualToString:kSignUpEmailFormSegue]) {
        
        SignUpEmailFormViewController *vc = [segue destinationViewController];
        vc.incomingUsername = self.usernameField.text;
    }
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
