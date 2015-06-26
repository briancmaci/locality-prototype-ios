//
//  PostDetailViewController.m
//  locality
//
//  Created by MRY on 5/22/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import "PostDetailViewController.h"
#import "config.h"
#import "CommentModel.h"
#import "CommentFeedCell.h"

@interface PostDetailViewController ()

@end

@implementation PostDetailViewController

static NSString * const kPostHeaderNibName = @"PostDetailHeader";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initHeaderView];
    [self initPostDetailHeader];
    [self initTableView];
}

- (void) viewDidLayoutSubviews {
    
    //set anything to be drawn post autolayout
    [_postHeader drawBackground];
    //[_postHeaderContainer setNeedsDisplay];
}

- (void) initHeaderView {
    [self.header initWithTitle:NSLocalizedString(@"PostDetailHeader", nil)
                leftButtonType:IconBack
               rightButtonType:IconClose];
    
    [self.view addSubview:self.header];
}

- (void) initTableView {
    _commentsTable.delegate = self;
    _commentsTable.dataSource = self;
    
    [_commentsTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
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

#pragma mark - TableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [_postComments count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  {
    
    return [self heightForBasicCellAtIndexPath:indexPath];
}

- (CGFloat)heightForBasicCellAtIndexPath:(NSIndexPath *)indexPath {
    static CommentFeedCell *sizingCell = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sizingCell = [[CommentFeedCell alloc] init];
    });
    
    CommentModel *c = [_postComments objectAtIndex:indexPath.row];
    return sizingCell.frame.size.height;
}

- (CGFloat)calculateHeightForConfiguredSizingCell:(UITableViewCell *)sizingCell {
    [sizingCell setNeedsLayout];
    [sizingCell layoutIfNeeded];
    
    CGSize size = [sizingCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    
    return size.height; // Add 1.0f for the cell separator height
}

- (CommentFeedCell *)basicCellAtIndexPath:(NSIndexPath *)indexPath {
    
    //init based on current sort by
    CommentFeedCell *cell = [[CommentFeedCell alloc] init];
    
    return cell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self basicCellAtIndexPath:indexPath];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //Do nothing
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
