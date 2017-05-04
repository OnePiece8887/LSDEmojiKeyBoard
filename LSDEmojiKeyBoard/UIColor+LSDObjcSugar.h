//
//  UIColor+LSDObjcSugar.h
//  LSDObjcSugar
//
//  Created by ls on 16/6/7.
//  Copyright © 2016年 szrd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (LSDObjcSugar)
#pragma mark - 颜色函数
/// 使用十六进制数字生成颜色
///
/// @param Hex hex，格式 0xFFEEDD
///
/// @return UIColor
+(instancetype)lsd_ColorWithHex:(uint32_t)Hex;

/// 使用指定的 r / g / b 数值生成颜色
///
/// @param red   red
/// @param green green
/// @param blue  blue
///
/// @return UIColor
+(instancetype)lsd_colorWithRed:(u_int8_t)red green:(u_int8_t)green blue:(u_int8_t)blue;

/// 生成随机颜色
///
/// @return UIColor
+(instancetype)lsd_randomColor;

#pragma mark - 颜色值
/// 返回当前颜色的 red 的 0～255 值
- (u_int8_t)hm_redValue;
/// 返回当前颜色的 green 的 0～255 值
- (u_int8_t)hm_greenValue ;
/// 返回当前颜色的 blue 的 0～255 值
- (u_int8_t)hm_blueValue ;
/// 返回当前颜色的 alpha 值
- (CGFloat)hm_alphaValue ;

@end
