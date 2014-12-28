//
//  JKUserModel.m
//  Joke
//
//  Created by 赖隆斌 on 14/12/28.
//  Copyright (c) 2014年 赖隆斌. All rights reserved.
//

#import "JKUserModel.h"
#import "NSDictionary+Util.h"

@implementation JKUserModel

+ (JKUserModel *)userWithData:(NSDictionary *)data
{
    if ((id)data == [NSNull null] || data == nil || data.allKeys.count <= 0) return nil;
    
    JKUserModel * userModel = [[JKUserModel alloc]init];
    userModel.createAt = [data[@"created_at"]longLongValue];
    userModel.icon = [data stringWithKey:@"icon"];
    userModel.userID = data[@"id"];
    userModel.login = data[@"login"];
    userModel.state = data[@"role"];
    
    return userModel;
}

- (NSString *)iconURL
{
    
    // medium
    return [NSString stringWithFormat:@"http://pic.qiushibaike.com/system/avtnew/%@/%@/medium/%@", [self.userID substringToIndex:self.userID.length - 4], self.userID, self.icon];
}

- (NSString *)createAtDateString
{
    NSDate * createDate = [[NSDate alloc]initWithTimeIntervalSince1970:self.createAt];
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    return [dateFormatter stringFromDate:createDate];
}

@end
