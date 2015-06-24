//
//  AboutViewController.h
//  locality
//
//  Created by Brian Maci on 6/24/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import "LocalityBaseViewController.h"

@interface AboutViewController : LocalityBaseViewController

@property (weak, nonatomic) IBOutlet UILabel *aboutCopy;
@property (weak, nonatomic) IBOutlet UILabel *aboutShareLabel;
@property (weak, nonatomic) IBOutlet UIButton *fbButton;
@property (weak, nonatomic) IBOutlet UIButton *twButton;
@property (weak, nonatomic) IBOutlet UIButton *gpButton;

@end
