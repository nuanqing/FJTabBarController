//
//  UIFont+Extension.m
//  BXInsurenceBroker
//
//  Created by JYJ on 16/2/23.
//  Copyright © 2016年 baobeikeji. All rights reserved.
//

#import "UIFont+Extension.h"
#import "Macros.h"

@implementation UIFont (Extension)
+ (UIFont *)fontWithDevice:(CGFloat)fontSize {
    if (FJWidth > 375) {
        fontSize = fontSize + 3;
    }else if (FJWidth == 375){
        fontSize = fontSize + 1.5;
    }else if (FJWidth == 320){
        fontSize = fontSize;
    }
    UIFont *font = [UIFont systemFontOfSize:fontSize];
    return font;
}

/**
 *  专门为客户性别，年龄电话写的
 */
+ (UIFont *)fontWithCustomer:(CGFloat)fontSize {
    if (FJWidth > 375) {
        fontSize = fontSize + 2;
    }else if (FJWidth == 375){
        fontSize = fontSize + 1.5;
    }else if (FJWidth == 320){
        fontSize = fontSize;
    }
    UIFont *font = [UIFont systemFontOfSize:fontSize];
    return font;
}

+ (UIFont *)navItemFontWithDevice:(CGFloat)fontSize {
    if (FJWidth > 375) {
        fontSize = fontSize + 2;
    }else if (FJWidth == 375){
        fontSize = fontSize + 1;
    }else if (FJWidth == 320){
        fontSize = fontSize;
    }
    UIFont *font = [UIFont systemFontOfSize:fontSize];
    return font;
}

+ (UIFont *)fontWithTwoLine:(CGFloat)fontSize {
    if (FJWidth > 375) {
        fontSize = fontSize + 2;
    }else if (FJWidth == 375){
        fontSize = fontSize + 1;
    }else if (FJWidth == 320){
        fontSize = fontSize;
    }
    UIFont *font = [UIFont systemFontOfSize:fontSize];
    return font;
}

+ (UIFont *)insuranceCellFont:(CGFloat)fontSize {
    if (FJWidth > 375) {
        fontSize = fontSize + 3.5;
    }else if (FJWidth == 375){
        fontSize = fontSize + 2;
    }else if (FJWidth == 320){
        fontSize = fontSize;
    }
    UIFont *font = [UIFont systemFontOfSize:fontSize];
    return font;
}

@end
