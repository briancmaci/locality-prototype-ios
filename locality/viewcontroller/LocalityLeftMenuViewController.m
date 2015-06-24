//
//  LocalityLeftMenuViewController.m
//  locality
//
//  Created by Brian Maci on 6/19/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import "LocalityLeftMenuViewController.h"
#import "UserModel.h"
#import "LeftMenuModel.h"
#import "AppUtilities.h"
#import "config.h"
#import "UIColor+LocalityColor.h"
#import "LeftMenuOptionTableViewCell.h"
#import "FeedMenuTableViewController.h"
#import "AboutViewController.h"
#import "SettingsViewController.h"
#import "SlideNavigationController.h"

@interface LocalityLeftMenuViewController ()

@end

@implementation LocalityLeftMenuViewController

static NSString * const kLeftMenuOptionId = @"LeftMenuOptionCell";
static float kMenuOptionHeight = 42;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initProfileImage];
    [self initLabels];
    [self initMenuOptions];
}

- (void) viewDidLayoutSubviews {
    [_profileImage updateImageMask];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) initProfileImage {
    [AppUtilities loadProfileImage:_profileImage];
}

-(void) initLabels {
    [_usernameLabel setText:[UserModel sharedInstance].username];
    
    //version
    [_versionLabel setText:[NSString stringWithFormat:NSLocalizedString(@"VersionLabel", nil), [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]]];
    
    //terms
    [_termsPrivacyButton setTitle:NSLocalizedString(@"TermsLabel", nil) forState:UIControlStateNormal];
}

-(void) initMenuOptions {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"leftMenuOptions" ofType:@"plist"];
    _menuOptions = [[NSMutableArray alloc] initWithContentsOfFile:path];
    
    _menuOptionsTable.delegate = self;
    _menuOptionsTable.dataSource = self;
    
    //set height
    _menuOptionsHeightConstraint.constant = [_menuOptions count] * kMenuOptionHeight;
    [_menuOptionsTable layoutIfNeeded];
    
    [_menuOptionsTable setScrollEnabled:NO];
}

#pragma mark - UITableViewDelegate Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_menuOptions count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  {
    
    return kMenuOptionHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LeftMenuOptionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kLeftMenuOptionId];
        
    if(cell == nil )
    {
        cell = [[LeftMenuOptionTableViewCell alloc] init];
    }
    
    NSDictionary *thisOption = [_menuOptions objectAtIndex:indexPath.row];
    
    [cell.optionLabel setText:NSLocalizedString([thisOption objectForKey:@"title"], nil)];
    
    switch ([LeftMenuModel styleTypeFromPListString:[thisOption objectForKey:@"style"]]) {
        case StyleLight:
            [cell.optionLabel setTextColor:[UIColor leftNavLightColor]];
            break;
        
        case StyleDark:
            [cell.optionLabel setTextColor:[UIColor leftNavDarkColor]];
            break;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //deselect
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *thisOption = [_menuOptions objectAtIndex:indexPath.row];
    
    //check for segue or action
    switch([LeftMenuModel typeFromPListString:[thisOption objectForKey:@"nav_type"]]) {
            
        case ViewSegue:
            [self gotoViewControllerWithId:[thisOption objectForKey:@"storyboard_id"]];
            break;
        
        case Action:
            [self triggerActionWithId:[thisOption objectForKey:@"action_id"]];
            break;
            
        case LeftMenuTypeUnknown:
            NSLog(@"PList error... LeftMenuTypeUnknown");
            break;
    }
}

-(void) gotoViewControllerWithId:(NSString *)storyboardId {
    
    LocalityBaseViewController *mainVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:storyboardId];
    
    
    //take care of page initialization if need be
    if( [storyboardId isEqualToString:kFeedMenuStoryboardId]) {
        
    }
    
    [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:mainVC withSlideOutAnimation:NO andCompletion:nil];
}

-(void) triggerActionWithId:(NSString *)actionId {

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
