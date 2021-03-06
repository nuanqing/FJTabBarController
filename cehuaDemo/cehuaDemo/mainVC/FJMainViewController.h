//
//  FJMainViewController.h
//  cehuaDemo
//
//  Created by MacBook on 2018/1/11.
//  Copyright © 2018年 MacHeigh. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FJTabBarViewController;
@class FJLeftViewController;

@interface FJMainViewController : UIViewController

@property (nonatomic,assign) BOOL isOpendLeftVC;
@property (nonatomic,strong) UIPanGestureRecognizer *panRecognizer;
@property (nonatomic,strong) UIViewController *tabBarVC;
@property (nonatomic,strong) UIViewController *leftVC;

- (void)showLeftVC;

- (void)closeLeftVC;

- (instancetype)initWithLeftVC:(UIViewController *)leftVC mainVC:(UIViewController *)mainVC;

@end

@interface UIViewController (FJMainViewController)

- (FJMainViewController*)mainViewController;

@end
