//
//  JKNetworkUtil.m
//  Joke
//
//  Created by 赖隆斌 on 12/26/14.
//  Copyright (c) 2014 赖隆斌. All rights reserved.
//

#import "JKNetworkUtil.h"
#import "JKViewControllerUtil.h"

@implementation JKNetworkUtil

+ (void)requestJokeWithJokeType:(JokeType)jokeType pageNo:(NSInteger)pageNo success:(void (^)(NSDictionary * jsonData))success failure:(void (^)())failure
{
    NSURL * requestURL = nil;
    switch (jokeType) {
        case JokeTypeNew:
            requestURL = [JKNetworkUtil newURLWithPageNo:pageNo];
            break;
        case JokeTypekHot:
            requestURL = [JKNetworkUtil hotURLWithPageNo:pageNo];
            break;
        case JokeTypekTruth:
            requestURL = [JKNetworkUtil truthURLWithPageNo:pageNo];
            break;
        default:
            break;
    }
    
    [JKNetworkUtil sendRequestWithURL:requestURL success:success failure:failure];
}

+ (void)requestJokeCommentWithJokeID:(NSString *)jokeID pageNo:(NSInteger)pageNo success:(void (^)(NSDictionary * jsonData))success failure:(void (^)())failure
{
    [JKNetworkUtil sendRequestWithURL:[JKNetworkUtil requestJokeCommentURLWithPageNo:pageNo jokeID:jokeID] success:success failure:failure];
}

+ (void)sendRequestWithURL:(NSURL *)url success:(void (^)(NSDictionary * jsonData))success failure:(void (^)())failure
{
    NSURLRequest * request = [[NSURLRequest alloc]initWithURL:url];
    NSOperationQueue * queue = [[NSOperationQueue alloc]init];
    
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError) {
            if (failure) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    failure();
                });
                NSLog(@"connection error : %@", connectionError.localizedDescription);
            }
        }else {
            NSDictionary * jsonData = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            
            if (success) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    success(jsonData);
                });
            }
            
        }
    }];
}

+ (NSURL *)hotURLWithPageNo:(NSInteger)pageNo
{
    NSURL * url = [[NSURL alloc]initWithString:[NSString stringWithFormat:@"%@%ld", @"http://m2.qiushibaike.com/article/list/suggest?count=20&page=", (long)pageNo]];
    return url;
}

+ (NSURL *)newURLWithPageNo:(NSInteger)pageNo
{
    NSURL * url = [[NSURL alloc]initWithString:[NSString stringWithFormat:@"%@%ld", @"http://m2.qiushibaike.com/article/list/latest?count=20&page=", (long)pageNo]];
    return url;
}

+ (NSURL *)truthURLWithPageNo:(NSInteger)pageNo
{
    NSURL * url = [[NSURL alloc]initWithString:[NSString stringWithFormat:@"%@%ld", @"http://m2.qiushibaike.com/article/list/imgrank?count=20&page=", (long)pageNo]];
    return url;
}

+ (NSURL *)requestJokeCommentURLWithPageNo:(NSInteger)pageNo jokeID:(NSString *)jokeID
{
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"http://m2.qiushibaike.com/article/%@/comments?count=20&page=%ld", jokeID, (long)pageNo]];
    return url;
}

@end
