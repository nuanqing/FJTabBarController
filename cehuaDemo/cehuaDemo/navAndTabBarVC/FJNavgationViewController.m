//
//  FJNavgationViewController.m
//  cehuaDemo
//
//  Created by MacHeigh on 2018/1/8.
//  Copyright © 2018年 MacHeigh. All rights reserved.
//

#import "FJNavgationViewController.h"
#import "Macros.h"
#import "FJTabBarViewController.h"
#import "UIBarButtonItem+Extension.h"
#import "FJMainViewController.h"

@interface FJNavgationViewController ()<UINavigationControllerDelegate,UIGestureRecognizerDelegate>

@property (nonatomic, weak) UIViewController *currentShowVC;

@end

@implementation FJNavgationViewController

#pragma mark - 初始化

+(void)initialize{
    //导航栏颜色
    [UINavigationBar appearance].barTintColor = FJNavColor;
    //导航栏字体颜色
    [UINavigationBar appearance].tintColor = [UIColor whiteColor];
    //导航栏不透明
    [UINavigationBar appearance].translucent = NO;
    //导航标题
    NSMutableDictionary *att = [NSMutableDictionary dictionary];
    att[NSFontAttributeName] = [UIFont fontWithName:@"Arial-BoldMT" size:20];
    att[NSForegroundColorAttributeName] = [UIColor whiteColor];
    [[UINavigationBar appearance] setTitleTextAttributes:att];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    FJNavgationViewController *nav = [super initWithRootViewController:rootViewController];
    nav.interactivePopGestureRecognizer.delegate = self;
    nav.delegate = self;
    return nav;
}

#pragma mark - 重写push方法

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    FJMainViewController *mainVC = (FJMainViewController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    mainVC.panRecognizer.enabled = NO;
    self.interactivePopGestureRecognizer.enabled = NO;
    if (self.childViewControllers.count > 0) {
        //设置导航栏的按钮
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"back" highImageName:nil target:self action:@selector(back)];
        //二级以上页面隐藏tabBar
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    [super pushViewController:viewController animated:animated];
}

#pragma mark - UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    self.interactivePopGestureRecognizer.enabled = YES;
    
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
     NSLog(@"%ld----%ld",self.childViewControllers.count,self.viewControllers.count);
    if (self.childViewControllers.count == 1) {
        return NO;
    }
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]] &&
        [otherGestureRecognizer isKindOfClass:[UIScreenEdgePanGestureRecognizer class]]) {
        return YES;
    } else {
        return NO;
    }
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    if ([gestureRecognizer isKindOfClass:[UIScreenEdgePanGestureRecognizer class]]) {
        return YES;
    }else{
        return NO;
    }
}

#pragma mark - 返回事件

- (void)back {
    [self popViewControllerAnimated:YES];
}

#pragma mark - 重写pop方法

-(UIViewController *)popViewControllerAnimated:(BOOL)animated{
    //将要返回一级页面
    if (self.childViewControllers.count == 2) {
        FJMainViewController *mainVC = (FJMainViewController *)[UIApplication sharedApplication].keyWindow.rootViewController;
        mainVC.panRecognizer.enabled = YES;
    }
    [super popViewControllerAnimated:animated];
    return self.topViewController;
}

@end





