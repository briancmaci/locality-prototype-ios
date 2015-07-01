//
//  AddCommentCell.m
//  locality
//
//  Created by Brian Maci on 7/1/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import "AddCommentCell.h"
#import "UserModel.h"
#import "UserStatusModel.h"
#import "config.h"

@implementation AddCommentCell

static const float kTablePadding = 20.0f;
static const float kPostButtonPadding = 10.0f;

- (void)awakeFromNib {
    // Initialization code
    
    [self initPostUser];
    [self initTextView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) initPostUser {
    
    [_postUser initWithImage:[UserModel sharedInstance].profileImgUrl
                    username:[UserModel sharedInstance].username
                  userStatus:[UserStatusModel stringFromUserStatusType:[UserModel sharedInstance].userStatus]];
}

-(void) initTextView {
    
    _commentField.delegate = self;
    
}

-(void) activate {
    _commentField.text = @"";
    [_commentField becomeFirstResponder];
    
    [self listenForKeyboard:YES];
}

-(void) listenForKeyboard:(BOOL)yes {
    if(yes) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onKeyboardShow:) name:UIKeyboardDidShowNotification object:nil];
    }
    
    else {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    }
}

-(void) onKeyboardShow:(NSNotification *)notification {
    
    //kill notification
    [self listenForKeyboard:NO];
    
    NSDictionary* keyboardInfo = [notification userInfo];
    NSValue* keyboardFrameBegin = [keyboardInfo valueForKey:UIKeyboardFrameBeginUserInfoKey];
    CGRect keyboardFrameBeginRect = [keyboardFrameBegin CGRectValue];
    
    //set new post button offset
    _postButtonBottomConstraint.constant = keyboardFrameBeginRect.size.height - kPostDetailFooterHeight + kTablePadding + kPostButtonPadding;
    [self layoutIfNeeded];
}

-(IBAction)onPostCommentTapped:(id)sender {
    
    if( [_delegate respondsToSelector:@selector(commentToPost:)]) {
        [_delegate commentToPost:_commentField.text];
    }
}

@end
