//
//  JKAboutController.m
//  Joke
//
//  Created by 赖隆斌 on 12/26/14.
//  Copyright (c) 2014 赖隆斌. All rights reserved.
//

#import "JKAboutController.h"

@implementation JKAboutController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.titleView = [JKViewControllerUtil navigationTitleLabelWithJokeType:self.jokeType];
}

@end
