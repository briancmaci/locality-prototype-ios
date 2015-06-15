//
//  LocalityBaseViewController.m
//  locality
//
//  Created by Brian Maci on 6/12/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import "LocalityBaseViewController.h"
#import "SlideNavigationController.h"

@interface LocalityBaseViewController ()

@end

@implementation LocalityBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSLog(@"localitybase viewDidLoad");
    [self loadHeaderView];
        
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) loadHeaderView {
    _header = [[LocalityHeaderView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, kHeaderHeight)];
    //[self.view addSubview:_header];
    
    _header.delegate = self;
}

#pragma mark - LocalityHeaderViewDelegate Methods

-(void) iconClicked:(HeaderIconButton *)sender {
    
    switch(sender.iconType) {
        
        case IconBack:
            [self.navigationController popViewControllerAnimated:YES];
            break;
        
        case IconClose:
            NSLog(@"Close Button Clicked");
            break;
            
        case IconHamburger:
            [[SlideNavigationController sharedInstance] openMenu:MenuLeft withCompletion:^{
                //menu left on complete
                NSLog(@"left menu opened");
            }];
            break;
    }
    
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
