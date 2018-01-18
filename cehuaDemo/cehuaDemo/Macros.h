//
//  Macros.h
//  cehuaDemo
//
//  Created by MacHeigh on 2018/1/8.
//  Copyright © 2018年 MacHeigh. All rights reserved.
//

#ifndef Macros_h
#define Macros_h

#pragma mark - 尺寸

#define FJWidth [UIScreen mainScreen].bounds.size.width
#define FJHeight [UIScreen mainScreen].bounds.size.height

#pragma mark - 设置颜色

#define FJColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
//线条
#define FJLineColor FJColor(200, 199, 204, 1)

//导航
#define FJNavColor FJColor(250, 146, 36, 1)

#pragma mark - 属性

//动画时长
static const CGFloat fj_animationTime = 0.38;
//leftVC宽度比例
static const CGFloat fj_leftVCScale = 0.8;
//滑动弹出比例
static const CGFloat fj_leftVPopCScale = 0.2;
//蒙版透明度
static const CGFloat fj_maskScale = 0.6;
//阴影效果
static const BOOL fj_shadowEffect = YES;

#endif /* Macros_h */
