
//
//  LSDEmoticonButton.m
//  LSDEmojiKeyBoard
//
//  Created by 神州锐达 on 2017/4/28.
//  Copyright © 2017年 OnePiece. All rights reserved.
//

#import "LSDEmoticonButton.h"

@interface LSDEmoticonButton ()

@end

@implementation LSDEmoticonButton

-(void)setEmoticonModel:(LSDEmoticonModel *)emoticonModel
{

    _emoticonModel = emoticonModel;
    
    if ([emoticonModel.type integerValue] == 1) {
        ///unicode字符串
        [self setTitle:emoticonModel.emoji forState:UIControlStateNormal];
        [self setImage:nil forState:UIControlStateNormal];
        self.hidden = NO;
        self.titleLabel.font = [UIFont systemFontOfSize:30];
        
    }else
    {
        ///表情图片
        NSString *imagePath = [NSString stringWithFormat:@"%@/%@",emoticonModel.imagePath,emoticonModel.png];
        [self setTitle:nil forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:imagePath] forState:UIControlStateNormal];
        self.hidden = NO;
        
    }
    
    
}

@end
