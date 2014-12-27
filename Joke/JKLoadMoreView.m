//
//  JKLoadMoreView.m
//  Joke
//
//  Created by 赖隆斌 on 14/12/27.
//  Copyright (c) 2014年 赖隆斌. All rights reserved.
//

#import "JKLoadMoreView.h"

@interface JKLoadMoreView ()

@property (weak, nonatomic) IBOutlet UIButton *loadMoreButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicatorView;

@end

@implementation JKLoadMoreView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.indicatorView.hidden = YES;
}

- (IBAction)loadMoreAction:(id)sender
{
    self.loadMoreButton.hidden = YES;
    self.indicatorView.hidden = NO;
    
    [self.indicatorView startAnimating];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(loadMore)]) {
        [self.delegate loadMore];
    }
}

- (void)stopLoadMore
{
    self.loadMoreButton.hidden = NO;
    self.indicatorView.hidden = YES;
    [self.indicatorView stopAnimating];
}
@end
