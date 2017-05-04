//
//  UIColor+LSDObjcSugar.m
//  LSDObjcSugar
//
//  Created by ls on 16/6/7.
//  Copyright © 2016年 szrd. All rights reserved.
//

#import "UIColor+LSDObjcSugar.h"

@implementation UIColor (LSDObjcSugar)
#pragma mark - 颜色函数
+(instancetype)lsd_ColorWithHex:(uint32_t)Hex{
    
    
    int red = Hex & 0xFF0000 >> 16; //取出红色
    int green = Hex & 0x00FF00 >> 8; //取出绿色
    int blue = Hex & 0x0000FF;//取出蓝色
    
    return [UIColor lsd_colorWithRed:red green:green blue:blue];
    
}

+(instancetype)lsd_colorWithRed:(u_int8_t)red green:(u_int8_t)green blue:(u_int8_t)blue {
    return [UIColor colorWithRed:red / 255.0 green:green / 255.0 blue:blue / 255.0 alpha:1.0];
}


+(instancetype)lsd_randomColor
{
    u_int8_t red = arc4random_uniform(256);
    u_int8_t green = arc4random_uniform(256);
    u_int8_t blue = arc4random_uniform(256);
    
    return [UIColor lsd_colorWithRed:red green:green blue:blue];


}

#pragma mark - 颜色值
- (u_int8_t)hm_redValue {
    return (u_int8_t)(CGColorGetComponents(self.CGColor)[0] * 255);
}

- (u_int8_t)hm_greenValue {
    return (u_int8_t)(CGColorGetComponents(self.CGColor)[1] * 255);
}

- (u_int8_t)hm_blueValue {
    return (u_int8_t)(CGColorGetComponents(self.CGColor)[2] * 255);
}

- (CGFloat)hm_alphaValue {
    return CGColorGetComponents(self.CGColor)[3];
}
@end
