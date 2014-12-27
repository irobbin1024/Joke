//
//  JKTabBarController.m
//  Joke
//
//  Created by 赖隆斌 on 12/26/14.
//  Copyright (c) 2014 赖隆斌. All rights reserved.
//

#import "JKTabBarController.h"
#import "JKJokeController.h"
#import "JKAboutController.h"

#define kTabbarHeight (49)

#define kNewButtonTag (100)
#define kHotButtonTag (101)
#define kTruthButtonTag (102)
#define kAboutButtonTag (103)

@interface JKTabBarController ()

@property (nonatomic, strong) UIView * customTabbar;
@property (nonatomic, strong) UIView * slipView;

@end

@implementation JKTabBarController

#pragma mark - Init


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tabBar.hidden = YES;
    
    [self initTabBar];
    
    [self initViewControllers];
}

- (void)initViewControllers
{
    JKJokeController * newJokeController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"JKJokeController"];
    newJokeController.jokeType = JokeTypeNew;
    
    UINavigationController * newNavationController = [[UINavigationController alloc]initWithRootViewController:newJokeController];
    
    JKJokeController * hotJokeController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"JKJokeController"];
    hotJokeController.jokeType = JokeTypekHot;
    
    UINavigationController * hotNavationController = [[UINavigationController alloc]initWithRootViewController:hotJokeController];
    
    JKJokeController * truthJokeController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"JKJokeController"];
    truthJokeController.jokeType = JokeTypekTruth;
    
    UINavigationController * truthNavationController = [[UINavigationController alloc]initWithRootViewController:truthJokeController];
    
    JKAboutController * aboutJokeController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"JKAboutController"];
    aboutJokeController.jokeType = JokeTypekAbout;
    
    UINavigationController * aboutNavationController = [[UINavigationController alloc]initWithRootViewController:aboutJokeController];
    
    
    self.viewControllers = @[newNavationController, hotNavationController, truthNavationController, aboutNavationController];
}

- (void)initTabBar
{
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    UIView * tabbarView = [[UIView alloc]initWithFrame:CGRectMake(0, screenSize.height - kTabbarHeight, screenSize.width, kTabbarHeight)];
    tabbarView.backgroundColor = [UIColor orangeColor];
    
    [self.view addSubview:tabbarView];
    self.customTabbar = tabbarView;
    
    [self initSlipView];
    
    [self initTabBarButton];
}

- (void)initSlipView
{
    UIView * slipView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [self tabBarItemSize].width, [self tabBarItemSize].height)];
    slipView.backgroundColor = [UIColor whiteColor];
    
    [self.customTabbar addSubview:slipView];
    
    self.slipView = slipView;
}

- (void)initTabBarButton
{
    for (int i = 0; i < 4; i++) {
        
        CGRect buttonFrame = CGRectMake(i * [self tabBarItemSize].width, 0, [self tabBarItemSize].width, [self tabBarItemSize].height);
        
        UIButton * tarbarButton = [UIButton buttonWithType:UIButtonTypeCustom];
        tarbarButton.backgroundColor = [UIColor clearColor];
        tarbarButton.frame = buttonFrame;
        [tarbarButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [tarbarButton addTarget:self action:@selector(tabbarButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        long buttonTag;
        switch (i) {
            case 0:
                buttonTag = kNewButtonTag;
                [tarbarButton setTitle:@"最新" forState:UIControlStateNormal];
                [tarbarButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
                break;
            case 1:
                buttonTag = kHotButtonTag;
                [tarbarButton setTitle:@"最热" forState:UIControlStateNormal];
                break;
            case 2:
                buttonTag = kTruthButtonTag;
                [tarbarButton setTitle:@"真相" forState:UIControlStateNormal];
                break;
            case 3:
                buttonTag = kAboutButtonTag;
                [tarbarButton setTitle:@"关于我" forState:UIControlStateNormal];
                break;
        }
        
        tarbarButton.tag = buttonTag;
        
        [self.customTabbar addSubview:tarbarButton];
    }
}

- (CGSize)tabBarItemSize
{
    NSInteger tabbarItemCount = 4;
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    
    return CGSizeMake(screenSize.width / tabbarItemCount, kTabbarHeight);
}

#pragma mark - Event

- (void)tabbarButtonClick:(UIButton *)sender
{
    JokeType jokeType = JokeTypeNew;
    switch (sender.tag) {
        case kNewButtonTag:
            jokeType = JokeTypeNew;
            break;
        case kHotButtonTag:
            jokeType = JokeTypekHot;
            break;
        case kTruthButtonTag:
            jokeType = JokeTypekTruth;
            break;
        case kAboutButtonTag:
            jokeType = JokeTypekAbout;
            break;
    }
    
    [self setSelectTabbar:jokeType button:sender];
}

- (void)setSelectTabbar:(JokeType)jokeType button:(UIButton *)button
{
    NSInteger selectedIndex;
    switch (jokeType) {
        case JokeTypeNew:
            selectedIndex = 0;
            break;
        case JokeTypekHot:
            selectedIndex = 1;
            break;
        case JokeTypekTruth:
            selectedIndex = 2;
            break;
        case JokeTypekAbout:
            selectedIndex = 3;
            break;
    }
    [self setSelectedIndex:selectedIndex];
    
    [UIView animateWithDuration:0.2 animations:^{
        CGRect slipViewOriginalFrame = self.slipView.frame;
        slipViewOriginalFrame.origin.x = selectedIndex * ([self tabBarItemSize].width);
        
        self.slipView.frame = slipViewOriginalFrame;
        
    }];
    
    [self resetTabbarButtonColor];
    [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
}

- (void)resetTabbarButtonColor
{
    UIButton * tabbarButton = (UIButton *)[self.customTabbar viewWithTag:kNewButtonTag];
    [tabbarButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    tabbarButton = (UIButton *)[self.customTabbar viewWithTag:kHotButtonTag];
    [tabbarButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    tabbarButton = (UIButton *)[self.customTabbar viewWithTag:kTruthButtonTag];
    [tabbarButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    tabbarButton = (UIButton *)[self.customTabbar viewWithTag:kAboutButtonTag];
    [tabbarButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}


@end
