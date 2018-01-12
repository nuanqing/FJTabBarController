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

- (void)showLeftVC;

- (void)closeLeftVC;


@end

@interface UIViewController (FJMainViewController)

- (FJMainViewController*)mainViewController;

@end
