//
//  FJMainViewController.m
//  cehuaDemo
//
//  Created by MacBook on 2018/1/11.
//  Copyright © 2018年 MacHeigh. All rights reserved.
//

#import "FJMainViewController.h"
#import "FJTabBarViewController.h"
#import "FJLeftViewController.h"
#import "Macros.h"
@interface FJMainViewController ()

@property (nonatomic,strong) FJTabBarViewController *tabBarVC;
@property (nonatomic,strong) FJLeftViewController *leftVC;

@end

@implementation FJMainViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI{
    [self.view addSubview:self.leftVC.view];
    [self.view addSubview:self.tabBarVC.view];
    [self addChildViewController:self.leftVC];
    [self addChildViewController:self.tabBarVC];
   
}

- (void)showLeftVC{
    //响应viewWillAppear
    if ([_leftVC respondsToSelector:@selector(viewWillAppear:)]) {
        [_leftVC performSelector:@selector(viewWillAppear:) withObject:nil];
    }
    
    [UIView animateWithDuration:0.38 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        _leftVC.view.center = CGPointMake(0.4*_leftVC.view.frame.size.width, self.view.center.y);
        _tabBarVC.view.center = CGPointMake(self.view.center.x+0.8*_leftVC.view.frame.size.width, self.view.center.y);
    } completion:nil];
    
}

- (void)closeLeftVC{
    [UIView animateWithDuration:0.38 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        _tabBarVC.view.center = CGPointMake(self.view.center.x, self.view.center.y);
    }completion:^(BOOL finished) {
        if (finished) {
            _leftVC.view.center = CGPointMake(0, self.view.center.y);
        }
    }];
}

- (FJTabBarViewController *)tabBarVC{
    if (!_tabBarVC) {
        _tabBarVC = [[FJTabBarViewController alloc]init];
        _tabBarVC.view.frame = self.view.bounds;
    }
    return _tabBarVC;
}

- (FJLeftViewController *)leftVC{
    if (!_leftVC) {
        _leftVC = [[FJLeftViewController alloc]init];
        _leftVC.view.frame = CGRectMake(-0.4*FJWidth, 0, 0.8*FJWidth, FJHeight);
    }
    return _leftVC;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

@implementation UIViewController (FJMainViewController)

- (FJMainViewController *)mainViewController{
    UIViewController *parent = self;
    Class mainClass = [FJMainViewController class];
    while ( nil != (parent = [parent parentViewController]) && ![parent isKindOfClass:mainClass] ) {}
    return (id)parent;
}

@end



