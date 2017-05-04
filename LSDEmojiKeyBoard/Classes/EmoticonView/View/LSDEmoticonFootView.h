//
//  LSDEmoticonFootView.h
//  LSDEmojiKeyBoard
//
//  Created by 神州锐达 on 2017/4/27.
//  Copyright © 2017年 OnePiece. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    
    LSDEmoticonFootViewBtnTypeRecent  = 10000, //最近使用的表情
    LSDEmoticonFootViewBtnTypeDefault = 10001, //默认表情
    LSDEmoticonFootViewBtnTypeEmoji = 10002, //emoji表情
    LSDEmoticonFootViewBtnTypeLxh  = 10003 //浪小花表情
    
} LSDEmoticonFootViewBtnType;

@protocol LSDEmoticonFootViewDelegate <NSObject>

///点击了哪一个表情类型
-(void)EmoticonFootViewDelegateDidClickBtnClick:(LSDEmoticonFootViewBtnType)type;

@end

@interface LSDEmoticonFootView : UIView

///代理
@property(weak,nonatomic)id<LSDEmoticonFootViewDelegate> delegate;

///最近
@property(strong,nonatomic)UIButton *recentBtn;
///默认
@property(strong,nonatomic)UIButton *defaultBtn;
///emoji
@property(strong,nonatomic)UIButton *emojiBtn;
///浪小花
@property(strong,nonatomic)UIButton *lxhBtn;

@end
