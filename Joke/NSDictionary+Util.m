//
//  NSDictionary+Util.m
//  Joke
//
//  Created by 赖隆斌 on 12/27/14.
//  Copyright (c) 2014 赖隆斌. All rights reserved.
//

#import "NSDictionary+Util.h"

@implementation NSDictionary(Util)

- (NSString *)stringWithKey:(NSString *)key
{
    id obj = [self objectForKey:key];
    
    if (obj == [NSNull null]) {
        return @"";
    }
    
    return obj;
}

@end
