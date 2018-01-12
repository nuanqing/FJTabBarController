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

@end

@implementation FJTabBarViewController


- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self setupTabBar];
    [self setupControllers];
    
}

- (void)setupControllers{
    NSArray *ChildControlArray = @[@"FirstViewController",@"SecondViewController",@"ThirdViewController"];
    //快速创建一个空的数组
    NSMutableArray *vcs=[[NSMutableArray alloc]init];
    for (int i=0; i<ChildControlArray.count; i++) {
        Class class=NSClassFromString(ChildControlArray[i]);
        UIViewController *vc=[[class alloc]init];
        //全部加导航
        FJNavgationViewController *nvc=[[FJNavgationViewController alloc]initWithRootViewController:vc];
        [vcs addObject:nvc];
    }
    self.viewControllers = vcs;
    self.selectedIndex = 1;
}

- (void)setupTabBar{
    [self setValue:self.customTabBar forKey:@"tabBar"];
}

- (FJTabBar *)customTabBar{
    if (!_customTabBar) {
        _customTabBar = [[FJTabBar alloc]init];
        _customTabBar.tabBarView.delegate = self;
    }
    return _customTabBar;
}

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
