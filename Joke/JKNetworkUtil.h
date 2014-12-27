//
//  JKNetworkUtil.h
//  Joke
//
//  Created by 赖隆斌 on 12/26/14.
//  Copyright (c) 2014 赖隆斌. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JKViewControllerUtil.h"

@interface JKNetworkUtil : NSObject

+ (void)requestJokeWithJokeType:(JokeType)jokeType pageNo:(NSInteger)pageNo success:(void (^)(NSDictionary * jsonData))success failure:(void (^)())failure;

@end
