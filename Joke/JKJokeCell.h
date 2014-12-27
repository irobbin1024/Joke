//
//  JKJokeCell.h
//  Joke
//
//  Created by 赖隆斌 on 12/26/14.
//  Copyright (c) 2014 赖隆斌. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JKJokeModel.h"

@protocol JokeCellActionsDelegate <NSObject>

@optional
- (void)showJokeImageAction:(JKJokeModel *)jokeModel;

@end

@interface JKJokeCell : UITableViewCell

@property (nonatomic, weak) id<JokeCellActionsDelegate> delegate;

- (void)initCellWithJokeModel:(JKJokeModel *)jokeModel;

+ (CGFloat)cellHeightWithJokeModel:(JKJokeModel *)jokeModel;

@end
