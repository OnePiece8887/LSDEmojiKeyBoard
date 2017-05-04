//
//  UIButton+Extention.m
//  LSDEmojiKeyBoard
//
//  Created by 神州锐达 on 2017/4/27.
//  Copyright © 2017年 OnePiece. All rights reserved.
//

#import "UIButton+Extention.h"

@implementation UIButton (Extention)


+(instancetype)getBtnTitle:(NSString *)title image:(NSString *)image  selectedImage:(NSString *)selectedImage target:(id)target action:(SEL)action type:(NSInteger)type
{

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:selectedImage] forState:UIControlStateSelected];
    
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    btn.tag = type;
    
    return btn;
}

@end
