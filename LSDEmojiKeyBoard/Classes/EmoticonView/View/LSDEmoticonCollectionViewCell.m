//
//  LSDEmoticonCollectionViewCell.m
//  LSDEmojiKeyBoard
//
//  Created by 神州锐达 on 2017/4/27.
//  Copyright © 2017年 OnePiece. All rights reserved.
//

#import "LSDEmoticonCollectionViewCell.h"
#import "LSDEmoticonButton.h"
#import "LSDEmoticonHelper.h"
static NSInteger const KemojiBtnRow = 3;
static NSInteger const KemojiBtnCol = 7;

@interface LSDEmoticonCollectionViewCell ()

///存放表情按钮的数组
@property(strong,nonatomic)NSMutableArray *emoticonBtns;

///表情按钮
@property(strong,nonatomic)LSDEmoticonButton *emoticonBtn;

///删除按钮
@property(strong,nonatomic)UIButton *deleteEmojiBtn;

@end

@implementation LSDEmoticonCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame
{
    
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupUI];
    }
    return self;
}

-(void)setupUI{

   ///计算每一个表情按钮的大小
    CGFloat emojiBtnW = KScreenWidth / (CGFloat)KemojiBtnCol;
    CGFloat emojiBtnH = emojiBtnW;
    
    ///腾出一个删除按钮
    NSInteger emojiBtnTotol = KemojiBtnRow * KemojiBtnCol - 1;
    
   ///九宫格布局添加表情按钮 最后一个为删除按钮
    for (int i = 0; i < emojiBtnTotol ; i ++) {
        
        ///计算行数
        NSInteger row = i/KemojiBtnCol;
        ///计算列数
        NSInteger col = i%KemojiBtnCol;
        
        LSDEmoticonButton *btn = [LSDEmoticonButton buttonWithType:UIButtonTypeCustom];
        
        CGFloat x = col * emojiBtnW;
        CGFloat y = row * emojiBtnH;
        
        btn.frame = CGRectMake(x, y, emojiBtnW, emojiBtnH);
        
        [btn addTarget:self action:@selector(emoticonBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        btn.backgroundColor = [UIColor lsd_randomColor];
        [self.contentView addSubview:btn];
        [self.emoticonBtns addObject:btn];
    }
    
    [self.contentView addSubview:self.deleteEmojiBtn];
    self.deleteEmojiBtn.frame = CGRectMake((KemojiBtnCol - 1)*emojiBtnW, (KemojiBtnRow - 1)*emojiBtnH, emojiBtnW, emojiBtnH);
    
}

///点击表情
-(void)emoticonBtnClick:(LSDEmoticonButton *)sender{

    
    
    LSDEmoticonModel *emoticonModel = (LSDEmoticonModel *)sender.emoticonModel;
    
    ///添加表情到最近表情包数组中
    [LSDEmoticonHelper addEmoticonToRecentEmoticons:emoticonModel];
    
    NSDictionary *info = @{
                           @"emoticon":emoticonModel
                           };
    ///发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:KaddEmoticon object:nil userInfo:info];
    
    if ([self.delegate respondsToSelector:@selector(EmoticonCollectionViewCellEmoticonBtnClick)]) {
        [self.delegate EmoticonCollectionViewCellEmoticonBtnClick];
    }
}

///删除表情
-(void)deleteEmoticon
{

    ///发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:KDeleteEmoticon object:nil userInfo:nil];
}

-(void)setEmoticonModelArray:(NSMutableArray *)emoticonModelArray
{

    _emoticonModelArray = emoticonModelArray;
    ///有表情显示 没表情隐藏
    for (LSDEmoticonButton *btn  in self.emoticonBtns) {
        btn.hidden = YES;
    }
    
    [emoticonModelArray enumerateObjectsUsingBlock:^(LSDEmoticonModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        LSDEmoticonButton *btn = self.emoticonBtns[idx];
        
        btn.emoticonModel = obj;
     
    }];
    
}




-(LSDEmoticonButton *)emoticonBtn
{

    if (_emoticonBtn == nil) {
        
        _emoticonBtn = [[LSDEmoticonButton alloc]init];
        
    }
    return _emoticonBtn;
}

-(NSMutableArray *)emoticonBtns
{

    if (_emoticonBtns == nil) {
        _emoticonBtns = @[].mutableCopy;
    }
    return _emoticonBtns;
}

-(UIButton *)deleteEmojiBtn
{

    if (_deleteEmojiBtn == nil) {
        _deleteEmojiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_deleteEmojiBtn setImage:[UIImage imageNamed:@"compose_emotion_delete"] forState:UIControlStateNormal];
        
        [_deleteEmojiBtn setImage:[UIImage imageNamed:@"compose_emotion_delete_highlighted"] forState:UIControlStateHighlighted];
        
        [_deleteEmojiBtn addTarget:self action:@selector(deleteEmoticon) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteEmojiBtn;
}


@end
