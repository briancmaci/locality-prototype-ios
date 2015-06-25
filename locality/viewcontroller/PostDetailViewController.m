//
//  PostDetailViewController.m
//  locality
//
//  Created by MRY on 5/22/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import "PostDetailViewController.h"
#import "config.h"

@interface PostDetailViewController ()

@end

@implementation PostDetailViewController

static NSString * const kPostHeaderNibName = @"PostDetailHeader";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initHeaderView];
    [self initPostDetailHeader];
}

- (void) initHeaderView {
    [self.header initWithTitle:NSLocalizedString(@"PostDetailHeader", nil)
                leftButtonType:IconBack
               rightButtonType:IconClose];
    
    [self.view addSubview:self.header];
}

-(void) initPostDetailHeader {
    
    _postHeader = [[[NSBundle mainBundle] loadNibNamed:kPostHeaderNibName owner:self options:nil] objectAtIndex:0];
    [_postHeaderContainer addSubview:_postHeader];
    
    [_postHeader populateWithData:_thisPost];
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
