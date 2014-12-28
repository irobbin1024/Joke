//
//  JKJokeCommentModel.h
//  Joke
//
//  Created by 赖隆斌 on 14/12/28.
//  Copyright (c) 2014年 赖隆斌. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JKUserModel.h"

@interface JKJokeCommentModel : NSObject

@property (nonatomic, strong) JKUserModel * user;
@property (nonatomic, strong) NSString * content;
@property (nonatomic, assign) NSInteger floor;
@property (nonatomic, strong) NSString * commentID;

+ (NSArray *)commentArrayWithData:(NSArray *)data;

@end
