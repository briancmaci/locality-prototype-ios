//
//  AboutViewController.m
//  locality
//
//  Created by Brian Maci on 6/24/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initHeaderView];
    [self initStage];
}

- (void) initHeaderView {
    [self.header initWithTitle:NSLocalizedString(@"AboutHeader", nil)
                leftButtonType:IconHamburger
               rightButtonType:IconNone];
    
    [self.view addSubview:self.header];
}

- (void) initStage {
    _aboutCopy.numberOfLines = 0;
    
    [_aboutCopy setText:NSLocalizedString(@"AboutCopy", nil)];
    [_aboutShareLabel setText:NSLocalizedString(@"AboutShareLabel", nil)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
