//
//  JKJokeCommentController.h
//  Joke
//
//  Created by 赖隆斌 on 14/12/27.
//  Copyright (c) 2014年 赖隆斌. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JKJokeModel.h"
#import "JKLoadMoreView.h"

@interface JKJokeCommentController : UITableViewController <LoadMoreDelegate>

@property (nonatomic, strong) JKJokeModel * jokeModel;

@end
