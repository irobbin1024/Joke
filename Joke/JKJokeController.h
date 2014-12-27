//
//  JKJokeController.h
//  Joke
//
//  Created by 赖隆斌 on 12/26/14.
//  Copyright (c) 2014 赖隆斌. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JKViewControllerUtil.h"
#import "JKJokeCell.h"
#import "JKLoadMoreView.h"


@interface JKJokeController : UITableViewController <UITableViewDataSource, UITableViewDelegate, JokeCellActionsDelegate, LoadMoreDelegate>

@property (nonatomic, assign) JokeType jokeType;

@end
