//
//  JKLoadMoreView.h
//  Joke
//
//  Created by 赖隆斌 on 14/12/27.
//  Copyright (c) 2014年 赖隆斌. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LoadMoreDelegate <NSObject>

@optional;
- (void)loadMore;

@end

@interface JKLoadMoreView : UIView

@property (nonatomic, weak) id<LoadMoreDelegate> delegate;

- (void)stopLoadMore;

@end
