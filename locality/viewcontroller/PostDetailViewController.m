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
#import "UserModel.h"
#import "CommentFeedCell.h"
#import "ParseManager.h"
#import "DataManager.h"

@interface PostDetailViewController ()

@end

@implementation PostDetailViewController

static NSString * const kPostDetailHeaderString = @"PostDetailHeader";
static NSString * const kNoCommentsLabelString = @"NoCommentsLabel";

static NSString * const kAddCommentCellNibName = @"AddCommentCell";
static NSString * const kCommentCellNibName = @"CommentFeedCell";
static NSString * const kCommentCellId = @"CommentFeedCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initHeaderView];
    [self initNoCommentsLabel];
    [self initPostDetailHeader];
    [self initTableView];
    [self initAddCommentCell];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [self loadComments];
}

- (void) initHeaderView {
    [self.header initWithTitle:NSLocalizedString(kPostDetailHeaderString, nil)
                leftButtonType:IconBack
               rightButtonType:IconClose];
    
    [self.view addSubview:self.header];
}

- (void) initNoCommentsLabel {
    [_noCommentsLabel setText:NSLocalizedString(kNoCommentsLabelString, nil)];
}

- (void) initTableView {
    _commentsTable.delegate = self;
    _commentsTable.dataSource = self;
    
    [_commentsTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    _isAddingComment = NO;
}


-(void) initPostDetailHeader {
    [_postHeader populateWithData:_thisPost];
    [_postHeader setBackgroundColor:[UIColor clearColor]];
    [_postHeader setOpaque:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - LoadComments

- (void) loadComments {
    [ParseManager getCommentsForPostWithId:_thisPost.postId success:^(id response) {
        _postComments = [DataManager parseCommentFeedIntoModelArray:response];
        [_commentsTable reloadData];
        
        //set table bottom
        [self scrollToBottomOfTableViewWithNewComment:NO animated:NO];
        
        //check for empty
        [_noCommentsLabel setHidden:[_postComments count]];
    } failure:^(NSError *error) {
        //NSLog(@"Comments Get Fail: %@", [error localizedDescription]);
    }];
}

#pragma mark - Custom Methods

-(void)scrollToBottomOfTableViewWithNewComment:(BOOL)addNewShowing animated:(BOOL)animated {
    [_commentsTable scrollRectToVisible:CGRectMake(0,
                                                   [self tableHeight] + (addNewShowing ? _addCommentCell.bounds.size.height : 0 ) - _commentsTable.bounds.size.height,
                                                   _commentsTable.bounds.size.width,
                                                   _commentsTable.bounds.size.height) animated:animated];
}

#pragma mark - TableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if( section == 0 ) return [_postComments count];
    else return _isAddingComment ? 1 : 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  {
    
    if( indexPath.section == 0 ) return [self heightForBasicCellAtIndexPath:indexPath];
    else return _commentsTable.frame.size.height;
}

- (CGFloat)heightForBasicCellAtIndexPath:(NSIndexPath *)indexPath {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sizingCell = [[CommentFeedCell alloc] initWithModel:[_postComments objectAtIndex:0]];
    });
    CommentModel *c = [_postComments objectAtIndex:indexPath.row];
    
    return [_sizingCell getViewHeight:c.commentText];
}

- (CGFloat)calculateHeightForConfiguredSizingCell:(UITableViewCell *)sizingCell {
    [sizingCell setNeedsLayout];
    [sizingCell layoutIfNeeded];
    
    CGSize size = [sizingCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    
    return size.height; // Add 1.0f for the cell separator height
}

- (CommentFeedCell *)basicCellAtIndexPath:(NSIndexPath *)indexPath {
    
    CommentFeedCell *cell = [[CommentFeedCell alloc] initWithModel:[_postComments objectAtIndex:indexPath.row]];
    if( indexPath.row == 0) {
        [cell.pinline setHidden:YES];
    }
    else [cell.pinline setHidden:NO];
    return cell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if( indexPath.section == 0 ) return [self basicCellAtIndexPath:indexPath];
    else return _addCommentCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //Do nothing
}

-(void) initAddCommentCell {
    _addCommentCell = [[[NSBundle mainBundle] loadNibNamed:kAddCommentCellNibName owner:self options:nil] objectAtIndex:0];
    _addCommentCell.delegate = self;
}

-(IBAction)writeCommentTapped:(id)sender {
    
    [self addNewCommentCell];
}

-(void) addNewCommentCell {
    [_noCommentsLabel setHidden:YES];
    
    _isAddingComment = YES;
    
    //move table to bottom
    //[self scrollToBottomOfTableViewWithNewComment:YES animated:YES];
    //[_commentsTable setContentOffset:_commentsTable.contentOffset animated:NO];
    [_commentsTable setContentOffset:CGPointMake( 0, [self tableHeight] - kStatusBarHeight )];
    
    //activate cell
    [_commentsTable beginUpdates];
    [_addCommentCell activate];
    NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:0 inSection:1];
    [_commentsTable insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationBottom];
    [_commentsTable endUpdates];
    
    
}

#pragma mark - AddCommentDelegate
-(void)commentToPost:(NSString *)commentText {
    
    //build comment and push to parse
    CommentModel *newComment = [[CommentModel alloc] init];
    newComment.commentText = commentText;
    newComment.postId = _thisPost.postId;
    
    //create user based on whether or not they want anonymous
    newComment.user = [[PostUser alloc] initWithUserId:[PFUser currentUser].objectId
                                              username:[UserModel sharedInstance].username
                                            userStatus:[UserModel sharedInstance].userStatus
                                             andImgUrl:[UserModel sharedInstance].profileImgUrl];
    
    [ParseManager addNewComment:newComment success:^(id response) {
        //NSLog(@"Comment posted!");
        
        [self pushNewCommentToTable:newComment];
    } failure:^(NSError *error) {
        NSLog(@"Comment post fail: %@", [error localizedDescription]);
    }];
}

-(void) pushNewCommentToTable:(CommentModel *)newComment {
    _isAddingComment = NO;
    
    [_addCommentCell.commentField resignFirstResponder];
    
    //remove addNewComment first.
    [CATransaction begin];
    [_commentsTable beginUpdates];
    
    [CATransaction setCompletionBlock:^{
        //new comment push
        [_postComments addObject:newComment];
        NSIndexPath *newCommentPath = [NSIndexPath indexPathForRow:[_postComments count] - 1 inSection:0];
        
        [_commentsTable insertRowsAtIndexPaths:[NSArray arrayWithObject:newCommentPath] withRowAnimation:UITableViewRowAnimationLeft];
        
        //animate background
        CommentFeedCell *c = (CommentFeedCell *)[_commentsTable cellForRowAtIndexPath:newCommentPath];
        [c popBackground];
        
        [self scrollToBottomOfTableViewWithNewComment:NO animated:YES];
        _commentsTable.scrollEnabled = YES;
        
    }];
    
    NSIndexPath *addNewIndexPath = [NSIndexPath indexPathForRow:0 inSection:1];
    [_commentsTable deleteRowsAtIndexPaths:[NSArray arrayWithObject:addNewIndexPath] withRowAnimation:UITableViewRowAnimationFade];
    [_commentsTable endUpdates];
    [CATransaction commit];
}

-(float) tableHeight {
    float height = 0;
    CommentModel *c;
    
    for( int i = 0; i < [_postComments count]; i++ ) {
        c = [_postComments objectAtIndex:i];
        height += [_sizingCell getViewHeight:c.commentText];
    }

    return height;
}


@end
