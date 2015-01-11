//
//  JKJokeModel.m
//  Joke
//
//  Created by 赖隆斌 on 12/26/14.
//  Copyright (c) 2014 赖隆斌. All rights reserved.
//

#import "JKJokeModel.h"
#import "NSDictionary+Util.h"


@implementation JKJokeModel

+ (NSArray *)jokeArrayWithData:(NSArray *)data
{
    NSMutableArray * jokeArray = [NSMutableArray arrayWithCapacity:data.count];
    
    [data enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [jokeArray addObject:[JKJokeModel jokeModelWithData:obj]];
    }];
    
    
    return jokeArray;
}

+ (JKJokeModel *)jokeModelWithData:(NSDictionary *)data
{
    JKJokeModel * jokeModel = [[JKJokeModel alloc]init];
    jokeModel.allowComment = [data[@"allow_comment"]boolValue];
    jokeModel.commentCount = [data[@"comments_count"]longValue];
    jokeModel.content = data[@"content"];
    jokeModel.createAt = [data[@"created_at"]longLongValue];
    jokeModel.jokeID = data[@"id"];
    jokeModel.image = [data[@"image"] isEqual:[NSNull null]] ? nil : data[@"image"];
    jokeModel.publishAt = [data[@"published_at"]longLongValue];
    jokeModel.state = data[@"state"];
    jokeModel.user = [JKUserModel userWithData:data[@"user"]];
    Votes votes;
    votes.up = [data[@"votes"][@"up"]longValue];
    votes.down = [data[@"votes"][@"down"]longValue];
    jokeModel.votes = votes;
    
    return jokeModel;
}

- (NSString *)smallImageURL
{
    return [NSString stringWithFormat:@"http://pic.moumentei.com/system/pictures/%@/%@/small/%@", [self.jokeID substringToIndex:4], self.jokeID, self.image];
}

- (NSString *)largeImageURL
{
    return [NSString stringWithFormat:@"http://pic.moumentei.com/system/pictures/%@/%@/medium/%@", [self.jokeID substringToIndex:4], self.jokeID, self.image];
}
@end
