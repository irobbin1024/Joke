//
//  UIImageView+Util.m
//  Joke
//
//  Created by 赖隆斌 on 12/27/14.
//  Copyright (c) 2014 赖隆斌. All rights reserved.
//

#import "UIImageView+Util.h"
#import "NSString+MD5.h"

@implementation UIImageView(Util)

- (void)setImageWithURL:(NSString *)url placehold:(UIImage *)image
{
    self.image = image;
    UIImage * cacheImage = [self imageFromCacheWithURLString:url];
    if (cacheImage) {
        self.image = cacheImage;
        return;
    }
    
    if (url == nil) {
        return;
    }
    
    NSURL * requestURL = [NSURL URLWithString:url];
    NSURLRequest * request = [NSURLRequest requestWithURL:requestURL];
    NSOperationQueue * queue = [[NSOperationQueue alloc]init];
    
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (connectionError == nil) {
            dispatch_async(dispatch_get_main_queue(), ^{
                UIImage * netImage = [UIImage imageWithData:data];
                
                self.image = netImage;
                
                [self saveImageToCache:netImage url:url];
            });
        } else {
            NSLog(@"%@", url);
            NSLog(@"加载图片出问题了%@", connectionError.localizedDescription);
        }
        
    }];
}

- (UIImage *)imageFromCacheWithURLString:(NSString *)urlString
{
    if (urlString == nil || [urlString isEqualToString:@""]) {
        return nil;
    }
    NSString * md5String = [urlString md5];
    NSFileManager * fileManager = [NSFileManager defaultManager];
    NSError * error;
    __block UIImage * cacheImage = nil;
    
    NSString * cacheImagePath = [self imageCachePath];
    NSArray * cacheImages = [fileManager contentsOfDirectoryAtPath:cacheImagePath error:&error];
    
    if (error) {
        NSLog(@"获取缓存图片目录列表出错：%@", error.localizedDescription);
        return nil;
    }
    
    
    
    [cacheImages enumerateObjectsUsingBlock:^(NSString * fileName, NSUInteger idx, BOOL *stop) {
        NSString * cacheImageItemPath = [cacheImagePath stringByAppendingPathComponent:fileName];
        if ([md5String isEqualToString:fileName]) {
            cacheImage = [UIImage imageWithContentsOfFile:cacheImageItemPath];
        }
    }];
    
    return cacheImage;
}

- (NSString *)imageCachePath
{
    NSString * documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) objectAtIndex:0];
    NSString * cacheImagePath = [documentsDirectory stringByAppendingPathComponent:@"_imageCache"];
    
    NSFileManager * fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:cacheImagePath] == NO) {
        [fileManager createDirectoryAtPath:cacheImagePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    return cacheImagePath;
}

- (void)saveImageToCache:(UIImage *)image url:(NSString *)url
{
    NSString * cacheImagePath = [self imageCachePath];
    NSString * md5FileName = [url md5];
    NSString * imageCachePath = [cacheImagePath stringByAppendingPathComponent:md5FileName];
    
    [UIImagePNGRepresentation(image) writeToFile:imageCachePath atomically:YES];
}


@end
