//
//  FeedViewController.m
//  locality
//
//  Created by Brian Maci on 5/13/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import "FeedViewController.h"
#import "UserModel.h"
#import "config.h"
#import "ParseManager.h"

@interface FeedViewController ()

@end

@implementation FeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //NSLog(@"Add Post Button: %@", NSStringFromCGRect(_addPostButton.frame));
    [self initHeroHeader];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) initHeroHeader {
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"FeedHeaderHeroView" owner:self options:nil];
    _headerHero = [nib objectAtIndex:0];
    
    [_headerHero setFrame:CGRectMake(0, 0, DEVICE_WIDTH, FEED_HERO_HEIGHT)];
    [_headerHero populateWithData:_thisFeed atIndex:0];
    [_headerHero setMenuMode:YES];
    _headerHero.delegate = self;
    
    [self.view addSubview:_headerHero];
    
    //NSLog(@"[FeedViewController:initHeader]");
}

#pragma mark - FeedHeaderHeroDelegate Methods

-(void)toFeedMenuClicked {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)toFeedSettingsClicked:(FeedLocationModel *)feed {
    //do nothing
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
