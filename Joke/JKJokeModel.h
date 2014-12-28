//
//  JKJokeModel.h
//  Joke
//
//  Created by 赖隆斌 on 12/26/14.
//  Copyright (c) 2014 赖隆斌. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JKUserModel.h"

typedef struct {
    long up;
    long down;
} Votes;


@interface JKJokeModel : NSObject

@property (nonatomic, assign) BOOL allowComment;
@property (nonatomic, assign) long commentCount;
@property (nonatomic, strong) NSString * content;
@property (nonatomic, assign) long long createAt;
@property (nonatomic, strong) NSString * jokeID;
@property (nonatomic, strong) NSString * image;
@property (nonatomic, assign) long long publishAt;
@property (nonatomic, strong) NSString * state;
//@property (nonatomic, strong) NSString * tag;
//@property (nonatomic, assign) imageSize;
@property (nonatomic, strong) JKUserModel * user;
@property (nonatomic, assign) Votes votes;


+ (NSArray *)jokeArrayWithData:(NSArray *)data;

- (NSString *)smallImageURL;
- (NSString *)largeImageURL;

@end
