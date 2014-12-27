//
//  UIImageView+Util.m
//  Joke
//
//  Created by 赖隆斌 on 12/27/14.
//  Copyright (c) 2014 赖隆斌. All rights reserved.
//

#import "UIImageView+Util.h"

@implementation UIImageView(Util)

- (void)setImageWithURL:(NSString *)url placehold:(UIImage *)image
{
    self.image = image;
    
    NSURL * requestURL = [NSURL URLWithString:url];
    NSURLRequest * request = [NSURLRequest requestWithURL:requestURL];
    NSOperationQueue * queue = [[NSOperationQueue alloc]init];
    
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (connectionError == nil) {
            dispatch_async(dispatch_get_main_queue(), ^{
                UIImage * netImage = [UIImage imageWithData:data];
                
                self.image = netImage;
            });
        } else {
            NSLog(@"加载图片出问题了%@", connectionError.localizedDescription);
        }
        
    }];
}



@end
