//
//  JKJokeCommentController.m
//  Joke
//
//  Created by 赖隆斌 on 14/12/27.
//  Copyright (c) 2014年 赖隆斌. All rights reserved.
//

#import "JKJokeCommentController.h"
#import "JKNetworkUtil.h"
#import "JKJokeCommentModel.h"
#import "JKLoadMoreView.h"
#import "JKJokeCommentCell.h"
#import "JKViewControllerUtil.h"

@interface JKJokeCommentController () {
    NSInteger _commentCount;
    NSInteger _commentPage;
    NSInteger _commentTotal;
}

@property (nonatomic, strong) NSMutableArray * datasource;
@property (nonatomic, strong) UIRefreshControl * refreshControl;

@end

@implementation JKJokeCommentController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.titleView = [JKViewControllerUtil customNavigationTitleLabelWithString:@"评论"];
    
    _commentCount = 0;
    _commentPage = 1;
    _commentTotal = 0;
    
    [self initRefreshControl];
    
    [self.refreshControl beginRefreshing];
    [self refreshData];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}
#pragma mark - Init & Datasource

- (void)initRefreshControl
{
    self.refreshControl = [[UIRefreshControl alloc]init];
    self.refreshControl.tintColor = [UIColor orangeColor];
    [self.refreshControl addTarget:self action:@selector(refreshAction:) forControlEvents:UIControlEventValueChanged];
    
    [self.tableView addSubview:self.refreshControl];
}

- (void)refreshData
{
    _commentPage = 1;
    
    [JKNetworkUtil requestJokeCommentWithJokeID:self.jokeModel.jokeID pageNo:_commentPage success:^(NSDictionary *jsonData) {
        [self.refreshControl endRefreshing];
        
        self.datasource = [NSMutableArray arrayWithArray:[JKJokeCommentModel commentArrayWithData:jsonData[@"items"]]];
        _commentCount = [jsonData[@"count"]longValue];
        _commentTotal = [jsonData[@"total"]longValue];
        
        [self.tableView reloadData];
        
        // 在这边添加加载更多，避免初次进入的视图错乱
        JKLoadMoreView * loadMoreView = [[NSBundle mainBundle]loadNibNamed:@"JKLoadMoreView" owner:self options:nil][0];
        loadMoreView.delegate = self;
        loadMoreView.frame = CGRectMake(0, 0, self.tableView.frame.size.width, 45);
        self.tableView.tableFooterView = loadMoreView;
    } failure:^{
        [self.refreshControl endRefreshing];
    }];
}

- (void)loadMoreData
{
    _commentPage++;
    
    
    [JKNetworkUtil requestJokeCommentWithJokeID:self.jokeModel.jokeID pageNo:_commentPage success:^(NSDictionary *jsonData) {
        
        [self.datasource  addObjectsFromArray:[JKJokeCommentModel commentArrayWithData:jsonData[@"items"]]];
        _commentCount = [jsonData[@"count"]longValue];
        _commentTotal = [jsonData[@"total"]longValue];
        
        [self.tableView reloadData];
        
        JKLoadMoreView * loadMoreView = (JKLoadMoreView *)self.tableView.tableFooterView;
        [loadMoreView stopLoadMore];
        
        [self.tableView setNeedsLayout];
    } failure:^{
        JKLoadMoreView * loadMoreView = (JKLoadMoreView *)self.tableView.tableFooterView;
        [loadMoreView stopLoadMore];
    }];
}
#pragma mark - Event
- (void)refreshAction:(UIRefreshControl *)refreshControl
{
    [self refreshData];
    
}

#pragma mark - LoadMore Delegate

- (void)loadMore
{
    [self loadMoreData];
}

#pragma mark - TableView Datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datasource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JKJokeCommentCell * cell = [tableView dequeueReusableCellWithIdentifier:@"JKJokeCommentCell" forIndexPath:indexPath];
    
    [cell initCellWithJokeCommentModel:self.datasource[indexPath.row]];
    
    return cell;
}


#pragma mark - TableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [JKJokeCommentCell cellHeightWithJokeModel:self.datasource[indexPath.row]];
}
@end
