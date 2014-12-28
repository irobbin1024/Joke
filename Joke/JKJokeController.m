//
//  JKJokeController.m
//  Joke
//
//  Created by 赖隆斌 on 12/26/14.
//  Copyright (c) 2014 赖隆斌. All rights reserved.
//

#import "JKJokeController.h"
#import "JKViewControllerUtil.h"
#import "JKJokeCell.h"
#import "JKNetworkUtil.h"
#import "JKShowImageView.h"
#import "JKJokeCommentController.h"

@interface JKJokeController () {
    NSInteger _jokeCount;
    NSInteger _jokePage;
    NSInteger _jokeTotal;
}

@property (nonatomic, strong) NSMutableArray * datasource;
@property (nonatomic, strong) UIRefreshControl * refreshControl;

@end

@implementation JKJokeController

#pragma mark - ViewController LifeCycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.titleView = [JKViewControllerUtil navigationTitleLabelWithJokeType:self.jokeType];
    
    _jokeCount = 0;
    _jokePage = 1;
    _jokeTotal = 0;
    
    [self initRefreshControl];
    
    [self.refreshControl beginRefreshing];
    [self refreshData];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.navigationController.hidesBarsOnSwipe = YES;
    
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
    _jokePage = 1;
    
    [JKNetworkUtil requestJokeWithJokeType:self.jokeType pageNo:_jokePage success:^(NSDictionary *jsonData) {
        [self.refreshControl endRefreshing];
        
        self.datasource = [NSMutableArray arrayWithArray:[JKJokeModel jokeArrayWithData:jsonData[@"items"]]];
        _jokeCount = [jsonData[@"count"]longValue];
        _jokeTotal = [jsonData[@"total"]longValue];
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
    _jokePage++;
    
    
    [JKNetworkUtil requestJokeWithJokeType:self.jokeType pageNo:_jokePage success:^(NSDictionary *jsonData) {
        
        [self.datasource  addObjectsFromArray:[JKJokeModel jokeArrayWithData:jsonData[@"items"]]];
        _jokeCount = [jsonData[@"count"]longValue];
        _jokeTotal = [jsonData[@"total"]longValue];
        
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

#pragma mark - JokeCellActions Delegate
- (void)showJokeImageAction:(JKJokeModel *)jokeModel
{
    [JKShowImageView showWithImageURL:[jokeModel largeImageURL]];
}

- (void)showCommentAction:(JKJokeModel *)jokeModel
{
    JKJokeCommentController * commentController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"JKJokeCommentController"];
    commentController.jokeModel = jokeModel;
    [self.navigationController pushViewController:commentController animated:YES];
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
    JKJokeCell * cell = [tableView dequeueReusableCellWithIdentifier:@"jokeCell" forIndexPath:indexPath];
    cell.delegate = self;
    
    [cell initCellWithJokeModel:self.datasource[indexPath.row]];
    
    return cell;
}


#pragma mark - TableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [JKJokeCell cellHeightWithJokeModel:self.datasource[indexPath.row]];
}
@end
