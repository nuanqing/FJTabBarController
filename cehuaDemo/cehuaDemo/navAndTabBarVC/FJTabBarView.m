//
//  FJTabBarView.m
//  cehuaDemo
//
//  Created by MacBook on 2018/1/9.
//  Copyright © 2018年 MacHeigh. All rights reserved.
//

#import "FJTabBarView.h"
#import "Macros.h"

@interface FJTabBarView()

@property (nonatomic, assign) NSInteger selectIndex;
/** 选中的索引 */
@property (nonatomic, assign) NSInteger lastSelectedIndex;

// 模型数组(UITabBarItem)
@property (nonatomic, strong) NSArray *items;

@end

@implementation FJTabBarView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    //普通情况下
    NSArray *images=@[@"leftN_icon",@"centerN_icon",@"rightN_icon"];
    //选中状态
    NSArray *selectImages=[[NSArray alloc]initWithObjects:@"leftS_icon",@"centerS_icon",@"rightS_icon", nil];
    NSArray *titleArray = @[@"消息",@"首页",@"我"];
    //摆放按钮
    float width=FJWidth/3.0f;
    float height=45;
    for (int i=0; i<3; i++) {
        UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
        button.frame=CGRectMake(width*i, 4, width, height);
        UILabel *title = [[UILabel alloc]init];
        title.frame = CGRectMake(width*i, 35, width, 11);
        title.text = titleArray[i];
        title.textAlignment = NSTextAlignmentCenter;
        title.font = [UIFont systemFontOfSize:9.5];
        title.textColor = [UIColor blackColor];
        title.tag = 20+i;
        //给一个tag值，区分点击的是哪个
        button.tag=10+i;
        button.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 17, 0);
        if (i==1) {
            button.frame = CGRectMake(FJWidth/2-30, -24, 60, 60);
            button.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        }
        //添加事件
        [button addTarget:self action:@selector(buttonaction:) forControlEvents:UIControlEventTouchUpInside];
        //给button添加图片
        [button setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:images[i]] forState:UIControlStateHighlighted];
        [button setImage:[UIImage imageNamed:selectImages[i]] forState:UIControlStateSelected];
        [button setImage:[UIImage imageNamed:selectImages[i]] forState:UIControlStateSelected|UIControlStateHighlighted];
        
        button.selected =i== 1;
        self.lastSelectedIndex = 11;
        [self addSubview:button];
        [self addSubview:title];
    }
}

#pragma mark - 点击事件

-(void)buttonaction:(UIButton *)button
{
    NSLog(@"%ld",button.tag);
    //判断是不是把这个按钮点了两次，如果是就return
    if (button.tag==self.lastSelectedIndex) {
        return;
    }
    UILabel *selectLabel = (UILabel *)[self viewWithTag:button.tag+10];
    selectLabel.textColor = [UIColor colorWithRed:0.278 green:0.557 blue:0.957 alpha:1];
    UILabel *crruntLabel = (UILabel *)[self viewWithTag:self.lastSelectedIndex+10];
    crruntLabel.textColor = [UIColor blackColor];
    //把当前选中的按钮点亮
    [self.delegate selectBtn:button.tag-10];
    button.selected=YES;
    //把上次选中的按钮还原
    UIButton *lastButton=(UIButton *)[self viewWithTag:self.lastSelectedIndex];
    lastButton.selected=NO;
    //记录当前选中按钮的tag值
    self.lastSelectedIndex=button.tag;
}



@end
