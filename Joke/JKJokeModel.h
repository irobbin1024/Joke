//
//  JKJokeModel.h
//  Joke
//
//  Created by 赖隆斌 on 12/26/14.
//  Copyright (c) 2014 赖隆斌. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef struct {
    long up;
    long down;
} Votes;

@interface JKUser : NSObject

@property (nonatomic, assign) long long createAt;
@property (nonatomic, strong) NSString * icon;
@property (nonatomic, strong) NSString * userID;
//@property (nonatomic, strong) NSString * lastDevice;
//@property (nonatomic, strong) NSString * lastVisitedAt;
@property (nonatomic, strong) NSString * login;
//@property (nonatomic, strong) NSString * role;
@property (nonatomic, strong) NSString * state;

+ (JKUser *)userWithData:(NSDictionary *)data;

- (NSString *)iconURL;

@end

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
@property (nonatomic, strong) JKUser * user;
@property (nonatomic, assign) Votes votes;


+ (NSArray *)jokeArrayWithData:(NSArray *)data;

- (NSString *)smallImageURL;
- (NSString *)largeImageURL;

@end
