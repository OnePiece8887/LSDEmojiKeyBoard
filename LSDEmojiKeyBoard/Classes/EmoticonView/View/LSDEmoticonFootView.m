//
//  LSDEmoticonFootView.m
//  LSDEmojiKeyBoard
//
//  Created by 神州锐达 on 2017/4/27.
//  Copyright © 2017年 OnePiece. All rights reserved.
//

#import "LSDEmoticonFootView.h"


@interface LSDEmoticonFootView ()



@end


@implementation LSDEmoticonFootView

-(instancetype)initWithFrame:(CGRect)frame
{

    if (self = [super initWithFrame:frame]) {
        
        [self setupUI];
    }
    
    return self;
}

-(void)setupUI{

    [self addSubview:self.recentBtn];
    [self addSubview:self.defaultBtn];
    [self addSubview:self.emojiBtn];
    [self addSubview:self.lxhBtn];
    
    [self.recentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self);
        make.width.equalTo(self.defaultBtn);
    }];
    
    [self.defaultBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.left.equalTo(self.recentBtn.mas_right);
        make.width.equalTo(self.emojiBtn);
    }];
    
    [self.emojiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.left.equalTo(self.defaultBtn.mas_right);
        make.width.equalTo(self.lxhBtn);
    }];
    
    [self.lxhBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.left.equalTo(self.emojiBtn.mas_right);
        make.right.equalTo(self);
    }];
    
}

-(void)footViewBtnClick:(UIButton *)sender
{
    
    switch (sender.tag) {
        case LSDEmoticonFootViewBtnTypeRecent:{
        
            self.recentBtn.selected = YES;
            self.defaultBtn.selected = NO;
            self.emojiBtn.selected = NO;
            self.lxhBtn.selected = NO;
        }
            
            break;
        case LSDEmoticonFootViewBtnTypeDefault:{
            self.recentBtn.selected = NO;
            self.defaultBtn.selected = YES;
            self.emojiBtn.selected = NO;
            self.lxhBtn.selected = NO;
        }
            
            break;
        case LSDEmoticonFootViewBtnTypeEmoji:{
            self.recentBtn.selected = NO;
            self.defaultBtn.selected = NO;
            self.emojiBtn.selected = YES;
            self.lxhBtn.selected = NO;
        }
            
            break;
        case LSDEmoticonFootViewBtnTypeLxh:{
            self.recentBtn.selected = NO;
            self.defaultBtn.selected = NO;
            self.emojiBtn.selected = NO;
            self.lxhBtn.selected = YES;
        }
            
            break;
            
        default:
            break;
    }
    
    if ([self.delegate respondsToSelector:@selector(EmoticonFootViewDelegateDidClickBtnClick:)]) {
        [self.delegate EmoticonFootViewDelegateDidClickBtnClick:sender.tag];
    }
    
}

#pragma mark -- 懒加载
-(UIButton *)recentBtn
{
    if (_recentBtn == nil) {
        
        _recentBtn = [UIButton getBtnTitle:@"最近" image:@"compose_emotion_table_normal" selectedImage:@"compose_emotion_table_selected" target:self action:@selector(footViewBtnClick:)  type:LSDEmoticonFootViewBtnTypeRecent];
        _recentBtn.selected = YES;
    }
    return _recentBtn;
}

-(UIButton *)defaultBtn
{
    if (_defaultBtn == nil) {
        
        _defaultBtn = [UIButton getBtnTitle:@"默认" image:@"compose_emotion_table_normal" selectedImage:@"compose_emotion_table_selected" target:self action:@selector(footViewBtnClick:)  type:LSDEmoticonFootViewBtnTypeDefault];
    }
    return _defaultBtn;
}

-(UIButton *)emojiBtn
{
    if (_emojiBtn == nil) {
        
        _emojiBtn = [UIButton getBtnTitle:@"emoji" image:@"compose_emotion_table_normal" selectedImage:@"compose_emotion_table_selected" target:self action:@selector(footViewBtnClick:)  type:LSDEmoticonFootViewBtnTypeEmoji];
    }
    return _emojiBtn;
}

-(UIButton *)lxhBtn
{
    if (_lxhBtn == nil) {
        _lxhBtn = [UIButton getBtnTitle:@"浪小花" image:@"compose_emotion_table_normal" selectedImage:@"compose_emotion_table_selected" target:self action:@selector(footViewBtnClick:)  type:LSDEmoticonFootViewBtnTypeLxh];
    }
    return _lxhBtn;
}


@end
