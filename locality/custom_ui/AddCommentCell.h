//
//  AddCommentCell.h
//  locality
//
//  Created by Brian Maci on 7/1/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PostUserInfoView.h"

@protocol AddCommentDelegate <NSObject>

-(void)commentToPost:(NSString *)commentText;

@end
@interface AddCommentCell : UITableViewCell <UITextViewDelegate>

@property (weak, nonatomic) id<AddCommentDelegate> delegate;

@property (weak, nonatomic) IBOutlet PostUserInfoView *postUser;
@property (weak, nonatomic) IBOutlet UITextView *commentField;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *postButtonBottomConstraint;

-(void) activate;

@end
