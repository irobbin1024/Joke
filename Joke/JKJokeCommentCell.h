//
//  JKJokeCommentCell.h
//  Joke
//
//  Created by 赖隆斌 on 14/12/28.
//  Copyright (c) 2014年 赖隆斌. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "JKJokeCommentModel.h"

@interface JKJokeCommentCell : UITableViewCell

- (void)initCellWithJokeCommentModel:(JKJokeCommentModel *)jokeCommentModel;
+ (CGFloat)cellHeightWithJokeModel:(JKJokeCommentModel *)jokeCommentModel;

@end
