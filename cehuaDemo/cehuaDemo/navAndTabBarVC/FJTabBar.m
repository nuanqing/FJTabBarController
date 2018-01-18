//
//  FJTabBar.m
//  cehuaDemo
//
//  Created by MacHeigh on 2018/1/8.
//  Copyright © 2018年 MacHeigh. All rights reserved.
//

#import "FJTabBar.h"
#import "Macros.h"

@implementation FJTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.tabBarView];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.tabBarView.frame = self.bounds;
    // 把tabBarView带到最前面，覆盖tabBar的内容
    [self bringSubviewToFront:self.tabBarView];
}

#pragma mark - 重写hitTest方法

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    
    UIButton *roundBtn = (UIButton *)[self.tabBarView viewWithTag:11];
    if (self.isHidden == NO) {
        
        //将当前tabbar的触摸点转换坐标系，转换到发布按钮的身上，生成一个新的点
        CGPoint newP = [self convertPoint:point toView:roundBtn];
        
        //判断如果这个新的点是在发布按钮身上，那么处理点击事件最合适的view就是发布按钮
        if ( [roundBtn pointInside:newP withEvent:event]) {
            return roundBtn;
        }else{//如果点不在发布按钮身上，直接让系统处理就可以了
            return [super hitTest:point withEvent:event];
        }
    }else{
        //tabbar隐藏了，那么说明已经push到其他的页面了，这个时候还是让系统去判断最合适的view处理就好了
        return [super hitTest:point withEvent:event];
    }
}

#pragma mark - 懒加载

- (FJTabBarView *)tabBarView{
    if (!_tabBarView) {
        _tabBarView = [[FJTabBarView alloc]init];
    }
    return _tabBarView;
}

@end
