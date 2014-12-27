//
//  ShowImageView.h
//  Joke
//
//  Created by 赖隆斌 on 12/27/14.
//  Copyright (c) 2014 赖隆斌. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JKShowImageView : UIScrollView <UIScrollViewDelegate>

+ (void)showWithImageURL:(NSString *)imageURL;

@end
