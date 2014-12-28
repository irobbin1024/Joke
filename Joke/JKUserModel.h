//
//  JKUserModel.h
//  Joke
//
//  Created by 赖隆斌 on 14/12/28.
//  Copyright (c) 2014年 赖隆斌. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JKUserModel : NSObject

@property (nonatomic, assign) long long createAt;
@property (nonatomic, strong) NSString * icon;
@property (nonatomic, strong) NSString * userID;
//@property (nonatomic, strong) NSString * lastDevice;
//@property (nonatomic, strong) NSString * lastVisitedAt;
@property (nonatomic, strong) NSString * login;
//@property (nonatomic, strong) NSString * role;
@property (nonatomic, strong) NSString * state;

+ (JKUserModel *)userWithData:(NSDictionary *)data;

- (NSString *)iconURL;
- (NSString *)createAtDateString;


@end
