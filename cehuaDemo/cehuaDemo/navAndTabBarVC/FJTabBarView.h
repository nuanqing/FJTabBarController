//
//  FJTabBarView.h
//  cehuaDemo
//
//  Created by MacBook on 2018/1/9.
//  Copyright © 2018年 MacHeigh. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FJTabBarDelegate <NSObject>

- (void)selectBtn:(NSInteger)index;

@end

@interface FJTabBarView : UIView

@property(nonatomic,assign)id<FJTabBarDelegate>delegate;

@end
