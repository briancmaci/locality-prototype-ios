//
//  PostCreateViewController.m
//  locality
//
//  Created by MRY on 5/25/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import "PostCreateViewController.h"

@interface PostCreateViewController ()

@end

@implementation PostCreateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)backButtonTapped:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)publishPostButtonTapped:(id)sender {

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
