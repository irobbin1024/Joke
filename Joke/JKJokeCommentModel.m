//
//  JKJokeCommentModel.m
//  Joke
//
//  Created by 赖隆斌 on 14/12/28.
//  Copyright (c) 2014年 赖隆斌. All rights reserved.
//

#import "JKJokeCommentModel.h"

@implementation JKJokeCommentModel

+ (NSArray *)commentArrayWithData:(NSArray *)data
{
    NSMutableArray * array = [NSMutableArray arrayWithCapacity:data.count];
    
    [data enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [array addObject:[JKJokeCommentModel commentModelWithData:obj]];
    }];
    
    return array;
}

+ (JKJokeCommentModel *)commentModelWithData:(NSDictionary *)data
{
    JKJokeCommentModel * model = [[JKJokeCommentModel alloc]init];
    
    model.content = data[@"content"];
    model.floor = [data[@"floor"]integerValue];
    model.commentID = data[@"id"];
    model.user = [JKUserModel userWithData:data[@"user"]];
    
    return model;
}

@end
