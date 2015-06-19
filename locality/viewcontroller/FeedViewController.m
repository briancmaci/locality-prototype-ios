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

static float headerExpandedOffset = FEED_HERO_HEIGHT - kHeaderHeight - kStatusBarHeight;
static float headerCollapsedOffset = 0;

static float scrollRangeExpanded = -(FEED_HERO_HEIGHT - kHeaderHeight);
static float scrollRangeCollapsed = 0;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //NSLog(@"Add Post Button: %@", NSStringFromCGRect(_addPostButton.frame));
    
    [self initHeroHeader];
    [self initTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) initHeroHeader {
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"FlexibleFeedHeaderView" owner:self options:nil];
    _headerHero = [nib objectAtIndex:0];
    
    [_headerHero setFrame:CGRectMake(0, 0, _headerHeroHolder.frame.size.width, _headerHeroHolder.frame.size.height)];
    [_headerHero populateWithData:_thisFeed atIndex:0 inFeedMenu:NO];
    _headerHero.delegate = self;
    
    [_headerHeroHolder addSubview:_headerHero];
    
    //[_headerHeroHolder setAlpha:0.2f];
    //NSLog(@"[FeedViewController:initHeader]");
}

-(void) initTableView {
    _feedPostsTable.delegate = self;
    _feedPostsTable.dataSource = self;
    
    //set initial content inset
    _feedPostsTable.contentInset = UIEdgeInsetsMake(headerExpandedOffset, 0, 0, 0);
}

#pragma mark - ScrollView Delegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    _flexHeaderHeight.constant = MAX( kHeaderHeight, kHeaderHeight + (FEED_HERO_HEIGHT - kHeaderHeight) * -(_feedPostsTable.contentOffset.y)/headerExpandedOffset);
    
    [_headerHeroHolder setNeedsUpdateConstraints];
    [_headerHero updateHeaderHeight:_flexHeaderHeight.constant];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    //second section is just button to add new
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //#warning Incomplete method implementation.
    
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  {
    
    //testing
    return ((arc4random() % 4) + 1) * 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"FeedPostCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
    if(cell == nil )
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.backgroundColor = (indexPath.row % 2) ? [UIColor lightGrayColor] : [UIColor greenColor];
        cell.textLabel.text = [NSString stringWithFormat:@"POST #%ld", (long)indexPath.row];
        
        //cell = [[FeedMenuTableViewCell alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, FEED_HERO_HEIGHT)];
        //cell.reuseIdentifier = CellIdentifier;
        //cell = [[FeedMenuTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    
    return cell;
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
