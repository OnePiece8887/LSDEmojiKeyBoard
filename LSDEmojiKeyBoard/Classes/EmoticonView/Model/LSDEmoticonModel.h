//
//  LSDEmoticonModel.h
//  LSDEmojiKeyBoard
//
//  Created by 神州锐达 on 2017/4/27.
//  Copyright © 2017年 OnePiece. All rights reserved.
//

#import "LSDBaseModel.h"

@interface LSDEmoticonModel : LSDBaseModel

///根据type来判断类别解析表情
@property(copy,nonatomic)NSString *type;
///
@property(copy,nonatomic)NSString *code;
///
@property(copy,nonatomic)NSString *chs;
///
@property(copy,nonatomic)NSString *cht;
///
@property(copy,nonatomic)NSString *gif;
///
@property(copy,nonatomic)NSString *png;

///由code转化的表情emoji
@property(copy,nonatomic)NSString *emoji;

///表情图片的前半部分路径
@property(copy,nonatomic)NSString *imagePath;

@end
