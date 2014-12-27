//
//  ShowImageView.m
//  Joke
//
//  Created by 赖隆斌 on 12/27/14.
//  Copyright (c) 2014 赖隆斌. All rights reserved.
//

#import "JKShowImageView.h"
#import "UIImageView+Util.h"

@interface JKShowImageView ()

@property (nonatomic, strong) UIImageView * imageView;

@end

@implementation JKShowImageView
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.delegate = self;
        
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:self.frame];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:imageView];
        self.imageView = imageView;
        
//        self.imageView.userInteractionEnabled = YES;
//        UITapGestureRecognizer * imageViewScaleGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(scaleGesture:)];
//        imageViewScaleGesture.numberOfTapsRequired = 2;
//        [self.imageView addGestureRecognizer:imageViewScaleGesture];
        
        UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImageViewGesture:)];
        tapGesture.numberOfTapsRequired = 1;
        [self addGestureRecognizer:tapGesture];
        self.userInteractionEnabled = YES;
        
        
    }
    return self;
}

+ (id)sharedManager {
    static JKShowImageView *staticInstance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        staticInstance = [[self alloc] init];
        
        staticInstance.minimumZoomScale = 1.0;
        staticInstance.maximumZoomScale = 3.0;
        
        staticInstance.showsHorizontalScrollIndicator = NO;
        staticInstance.showsVerticalScrollIndicator = NO;
    });
    return staticInstance;
}

+ (void)showWithImageURL:(NSString *)imageURL
{
    JKShowImageView * showImageView = [JKShowImageView sharedManager];
    UIView * fatherView = [UIApplication sharedApplication].keyWindow.rootViewController.view;
    
    showImageView.backgroundColor = [UIColor blackColor];
    showImageView.frame = fatherView.frame;
    showImageView.imageView.frame = showImageView.frame;
    [showImageView.imageView setImageWithURL:imageURL placehold:[UIImage imageNamed:@"avatar.jpg"]];
    
    [fatherView addSubview:showImageView];
}

- (void)dismiss
{
    JKShowImageView * showImageView = [JKShowImageView sharedManager];
    [showImageView removeFromSuperview];
}

- (void)tapImageViewGesture:(id)sender
{
    [self dismiss];
}

//- (void)scaleGesture:(UIGestureRecognizer * )sender
//{
//    if (self.zoomScale > 1.0) {
//        [self setZoomScale:1.0 animated:YES];
//    } else {
//        CGPoint center = [sender locationInView:self];
//        [self zoomToRect:CGRectMake(center.x - 50, center.y - 50, 100, 100) animated:YES];
//    }
//}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

@end
