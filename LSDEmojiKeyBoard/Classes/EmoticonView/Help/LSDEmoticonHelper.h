//
//  LSDEmoticonHelper.h
//  LSDEmojiKeyBoard
//
//  Created by 神州锐达 on 2017/4/27.
//  Copyright © 2017年 OnePiece. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LSDEmoticonModel.h"
static NSString *const KDefaultEmoticonFile = @"com.sina.default";
static NSString *const KEmojiEmoticonFile = @"com.apple.emoji";
static NSString *const KLxhEmoticonFile = @"com.sina.lxh";

///解析plist文件的工具
@interface LSDEmoticonHelper : NSObject

///存放默认表情包的开始和结束页码
+(NSArray *)defaultPage;

///存放emoji表情包的开始和结束页码
+(NSArray *)emojiPage;

///存放浪小花表情包的开始和结束页码
+(NSArray *)lxhPage;

///获取所有表情
+(NSMutableArray<LSDEmoticonModel *> *)getAllEmoticons;
///最近
+(NSMutableArray<LSDEmoticonModel *> *)recentEmoticons;
///默认
+(NSMutableArray<LSDEmoticonModel *> *)defaultEmoticons;
///emoji
+(NSMutableArray<LSDEmoticonModel *> *)emojiEmoticons;
///浪小花
+(NSMutableArray<LSDEmoticonModel *> *)lxhEmoticons;

///添加表情到最近表情数组中
+(void)addEmoticonToRecentEmoticons:(LSDEmoticonModel *)emoticon;

@end
