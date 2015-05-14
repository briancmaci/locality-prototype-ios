//
//  SignUpViewController.h
//  locality
//
//  Created by Brian Maci on 5/13/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignUpViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIButton *fbSignupButton;
@property (weak, nonatomic) IBOutlet UIButton *emailSignupButton;

@property (weak, nonatomic) IBOutlet UITextField *usernameField;

@end
