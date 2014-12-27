//
//  JKViewControllerUtil.h
//  Joke
//
//  Created by 赖隆斌 on 12/26/14.
//  Copyright (c) 2014 赖隆斌. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum{
    JokeTypeNew,
    JokeTypekHot,
    JokeTypekTruth,
    JokeTypekAbout
} JokeType;



@interface JKViewControllerUtil : NSObject

+ (NSString *)titleWithJokeType:(JokeType)jokeType;
+ (UILabel *)navigationTitleLabelWithJokeType:(JokeType)jokeType;

@end
