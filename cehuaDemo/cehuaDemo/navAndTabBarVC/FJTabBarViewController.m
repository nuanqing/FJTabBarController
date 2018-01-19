//
//  FJTabBarViewController.m
//  cehuaDemo
//
//  Created by MacHeigh on 2018/1/8.
//  Copyright © 2018年 MacHeigh. All rights reserved.
//

#import "FJTabBarViewController.h"
#import "FJNavgationViewController.h"
#import "Macros.h"

@interface FJTabBarViewController ()<FJTabBarDelegate,UINavigationControllerDelegate>

@property (nonatomic,copy) NSArray *childControlArray;

@end

@implementation FJTabBarViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupArray];
    [self setupTabBar];
    [self setupControllers];
    
}

- (void)setupArray{
    self.childControlArray = @[@"FirstViewController",@"SecondViewController",@"ThirdViewController"].copy;
}

#pragma mark - 控制器

- (void)setupControllers{
    
    NSMutableArray *vcs=[[NSMutableArray alloc]init];
    for (int i=0; i<_childControlArray.count; i++) {
        Class class=NSClassFromString(_childControlArray[i]);
        UIViewController *vc=[[class alloc]init];
        FJNavgationViewController *nvc=[[FJNavgationViewController alloc]initWithRootViewController:vc];
        [vcs addObject:nvc];
    }
    self.viewControllers = vcs;
    self.selectedIndex = 1;
}

#pragma mark - 自定义tabBar

- (void)setupTabBar{
    //kvc的方式替换系统tabBar
    [self setValue:self.customTabBar forKey:@"tabBar"];
}

- (FJTabBar *)customTabBar{
    if (!_customTabBar) {
        _customTabBar = [[FJTabBar alloc]init];
        _customTabBar.tabBarView.delegate = self;
    }
    return _customTabBar;
}

#pragma mark - tabBarDelegate

- (void)selectBtn:(NSInteger)index{
    self.selectedIndex = index;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
