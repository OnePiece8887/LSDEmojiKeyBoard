//
//  LSDEmoticonModel.m
//  LSDEmojiKeyBoard
//
//  Created by 神州锐达 on 2017/4/27.
//  Copyright © 2017年 OnePiece. All rights reserved.
//

#import "LSDEmoticonModel.h"

@implementation LSDEmoticonModel

-(void)setCode:(NSString *)code
{

    _code = code;
    
    NSScanner *scanner = [NSScanner scannerWithString:code];
    
    UInt32 result = 0;
    
    [scanner scanHexInt:&result];

    //convert this integer to a char array (bytes)
    char chars[4];
    int len = 4;
    
    chars[0] = (result >> 24) & (1 << 24) - 1;
    chars[1] = (result >> 16) & (1 << 16) - 1;
    chars[2] = (result >> 8) & (1 << 8) - 1;
    chars[3] = result & (1 << 8) - 1;
    
    
    NSString *unicodeString = [[NSString alloc] initWithBytes:chars
                                                       length:len
                                                     encoding:NSUTF32StringEncoding];
    self.emoji = unicodeString;
}

@end
