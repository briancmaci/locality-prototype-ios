//
//  FeedMenuTableViewController.m
//  locality
//
//  Created by Brian Maci on 6/4/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import "FeedMenuTableViewController.h"
#import "UserModel.h"
#import "config.h"
#import "FeedMenuTableViewCell.h"
#import "FeedAddNewTableViewCell.h"
#import "FeedViewController.h"

@interface FeedMenuTableViewController ()

@property (strong, nonatomic) FeedAddNewTableViewCell *addNewCell;

@end

@implementation FeedMenuTableViewController

static NSString * const kAddNewLocationSegue = @"addNewLocationSegue";

static NSString * const kFeedMenuCellNibName = @"FeedMenuTableViewCell";
static NSString * const kFeedCellId = @"FeedMenuCell";

static NSString * const kAddNewFeedCellNibName = @"FeedAddNewTableViewCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    _menuOptions = [[NSMutableArray alloc] init];
    [self initAddNewButtonCell];
}

-(void)viewWillAppear:(BOOL)animated {
    
    [self initMenuOptionsWithCurrentLocation:[UserModel sharedInstance].currentLocationFeed andPinnedLocations:[UserModel sharedInstance].pinnedLocations];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) initMenuOptionsWithCurrentLocation:(FeedLocationModel *)currentLocation andPinnedLocations:(NSMutableArray *)pinnedLocations {
    
    [_menuOptions removeAllObjects];
    [_menuOptions addObject:currentLocation];
        
    for( int i = 0; i < [pinnedLocations count]; i++ ) {
        [_menuOptions addObject:[pinnedLocations objectAtIndex:i]];
    }
    
    [self.tableView reloadData];
}

-(void) initAddNewButtonCell {
    
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:kAddNewFeedCellNibName owner:self options:nil];
    _addNewCell = [nib objectAtIndex:0];
    _addNewCell.delegate = self;
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
            
        case IconFeedSettings:
            NSLog(@"feed settings");
            break;
            
        case IconNone:
        default:
            NSLog(@"do nothing");
            break;
    }
    
}


-(void) openFeedClicked:(FeedLocationModel *)feed atIndex:(int)index {
    //NSLog(@"Load feed #%d", index);
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    FeedViewController *vc = [storyboard instantiateViewControllerWithIdentifier:kCurrentFeedStoryboardId];
    
    vc.thisFeed = feed;
    
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - FeedAddNewDelegate Methods

-(void) addNewLocationFeed {
    [self performSegueWithIdentifier:kAddNewLocationSegue sender:self];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    //second section is just button to add new
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    
    if( section == 0 ) {
        return [_menuOptions count];
    }
    
    else return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  {
    
    return FEED_HERO_HEIGHT;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if( indexPath.section == 0 )
    {
        FeedMenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kFeedCellId];
        
        if(cell == nil )
        {
            [tableView registerNib:[UINib nibWithNibName:kFeedMenuCellNibName bundle:nil] forCellReuseIdentifier:kFeedCellId];
            cell = [tableView dequeueReusableCellWithIdentifier:kFeedCellId];
        }
        
        [cell populateWithData:[_menuOptions objectAtIndex:indexPath.row]];
        cell.heroView.delegate = self;
        
        return cell;
    }
    
    else {
        
        return _addNewCell;
        
    }
}


/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
