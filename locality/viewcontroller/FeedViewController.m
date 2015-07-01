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
#import "DataManager.h"
#import "PostFeedCell.h"
#import "PostDetailViewController.h"

@interface FeedViewController ()

@end

@implementation FeedViewController

static float headerExpandedOffset = FEED_HERO_HEIGHT - kHeaderHeight - 0;
static NSString * const kPostFeedCellIdentifier = @"PostFeedCellIdentifier";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initSortByType];
    [self initHeroHeader];
    [self initTableView];
}

- (void)viewDidAppear:(BOOL)animated {
    
    [self loadFeedPosts];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) loadFeedPosts {
    
    //load feed
    [ParseManager getPostsWithinRange:_thisFeed.range atCoordinate:CLLocationCoordinate2DMake(_thisFeed.latitude, _thisFeed.longitude) sortedBy:_currentSortByType success:^(id response) {
        //NSLog(@"Post count: %lu", (unsigned long)[response count]);
        _feedPosts = [DataManager parsePostFeedIntoModelArray:response];
        
        [_feedPostsTable reloadData];
        
    } failure:^(NSError *error) {
        NSLog(@"Post query error.");
    }];
    
}

-(void) initSortByType {
    _currentSortByType = SortProximity;
}

-(void) initHeroHeader {
    //NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"FlexibleFeedHeaderView" owner:self options:nil];
    //_headerHero = [nib objectAtIndex:0];
    
    //[_headerHero setFrame:CGRectMake(0, 0, _headerHeroHolder.frame.size.width, _headerHeroHolder.frame.size.height)];
    [_headerHero populateWithData:_thisFeed atIndex:0 inFeedMenu:NO];
    _headerHero.delegate = self;
    
    //[_headerHeroHolder addSubview:_headerHero];
    
    //[_headerHeroHolder setAlpha:0.2f];
    //NSLog(@"[FeedViewController:initHeader]");
}

-(void) initTableView {
    _feedPostsTable.delegate = self;
    _feedPostsTable.dataSource = self;
    
    //set initial content inset
    _feedPostsTable.contentInset = UIEdgeInsetsMake(headerExpandedOffset, 0, 0, 0);
    [_feedPostsTable registerClass:[PostFeedCell class] forCellReuseIdentifier:kPostFeedCellIdentifier];
}

#pragma mark - ScrollView Delegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    _flexHeaderHeight.constant = MAX( kHeaderHeight, kHeaderHeight + (FEED_HERO_HEIGHT - kHeaderHeight) * -(_feedPostsTable.contentOffset.y)/headerExpandedOffset);
    
    [_headerHero setNeedsUpdateConstraints];
    [_headerHero updateHeaderHeight:_flexHeaderHeight.constant];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [_feedPosts count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  {
    
    return [self heightForBasicCellAtIndexPath:indexPath];
}

- (CGFloat)heightForBasicCellAtIndexPath:(NSIndexPath *)indexPath {
    static PostFeedCell *sizingCell = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sizingCell = [[PostFeedCell alloc] initWithModelByTime:[_feedPosts objectAtIndex:0]];
    });
    
    PostModel *p = [_feedPosts objectAtIndex:indexPath.row];
    return [sizingCell.postContent getViewHeight:p.postCaption] + ([p.postImgUrl isEqualToString:@""] ? 0 : (DEVICE_WIDTH * IMAGE_RATIO));
}

- (CGFloat)calculateHeightForConfiguredSizingCell:(UITableViewCell *)sizingCell {
    [sizingCell setNeedsLayout];
    [sizingCell layoutIfNeeded];
    
    CGSize size = [sizingCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    
    return size.height; // Add 1.0f for the cell separator height
}

- (PostFeedCell *)basicCellAtIndexPath:(NSIndexPath *)indexPath {
    
    //init based on current sort by
    PostFeedCell *cell;
    switch (_currentSortByType ) {
            
        case SortProximity:
            cell = [[PostFeedCell alloc] initWithModelByProximity:[_feedPosts objectAtIndex:indexPath.row] from:CLLocationCoordinate2DMake(_thisFeed.latitude, _thisFeed.longitude)];
            break;
        
        case SortTime:
            cell = [[PostFeedCell alloc] initWithModelByTime:[_feedPosts objectAtIndex:indexPath.row]];
            break;
        
        case SortActivity:
            //for now...
            cell = [[PostFeedCell alloc] initWithModelByTime:[_feedPosts objectAtIndex:indexPath.row]];
            break;
    }
    
    return cell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self basicCellAtIndexPath:indexPath];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    PostDetailViewController *vc = (PostDetailViewController *)[mainStoryboard instantiateViewControllerWithIdentifier:kPostDetailStoryboardId];
    vc.thisPost = [_feedPosts objectAtIndex:indexPath.row];
    
    [self.navigationController pushViewController:vc animated:YES];
}

@end
