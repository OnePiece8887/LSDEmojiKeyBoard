//
//  LSDEmoticonHelper.m
//  LSDEmojiKeyBoard
//
//  Created by 神州锐达 on 2017/4/27.
//  Copyright © 2017年 OnePiece. All rights reserved.
//

#import "LSDEmoticonHelper.h"
@interface LSDEmoticonHelper ()

@end

@implementation LSDEmoticonHelper

///最近表情数组
static NSMutableArray<LSDEmoticonModel *> *recentEmoticonsArray;

+(NSMutableArray<LSDEmoticonModel *> *)recentEmoticons{
    return recentEmoticonsArray;
}

+(NSMutableArray<LSDEmoticonModel *> *)defaultEmoticons{

    return  [LSDEmoticonHelper getEmoticonsFromFile:KDefaultEmoticonFile];
}

+(NSMutableArray<LSDEmoticonModel *> *)emojiEmoticons{
    
    return [LSDEmoticonHelper getEmoticonsFromFile:KEmojiEmoticonFile];
}

+(NSMutableArray<LSDEmoticonModel *> *)lxhEmoticons{
    
    return [LSDEmoticonHelper getEmoticonsFromFile:KLxhEmoticonFile];
}
///获取所有表情
+(NSMutableArray<LSDEmoticonModel *> *)getAllEmoticons{

    NSMutableArray *muarray = [NSMutableArray array];
    
    NSArray *lxhEmoticon = [LSDEmoticonHelper pageEmoticonList:[LSDEmoticonHelper lxhEmoticons]];
    
    if ([LSDEmoticonHelper recentEmoticons] == nil) {
        recentEmoticonsArray = @[].mutableCopy;
    }
    
    NSArray *recentEmoticon = [LSDEmoticonHelper pageEmoticonList:[LSDEmoticonHelper recentEmoticons]];
    
    NSArray *defaultEmoction = [LSDEmoticonHelper pageEmoticonList:[LSDEmoticonHelper defaultEmoticons]];
    
    NSArray *emojiEmoticon = [LSDEmoticonHelper pageEmoticonList:[LSDEmoticonHelper emojiEmoticons]];

    [muarray addObject:recentEmoticon];
    [muarray addObject:defaultEmoction];
    [muarray addObject:emojiEmoticon];
    [muarray addObject:lxhEmoticon];
    
    return muarray;
}

///从plist文件中解析表情模型
+(NSMutableArray<LSDEmoticonModel *> *)getEmoticonsFromFile:(NSString *)fileName{

    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"Emoticons.bundle" ofType:nil];
    
    NSString *emoticonsPath =  [[bundlePath stringByAppendingPathComponent:fileName]stringByAppendingPathComponent:@"info.plist"];
    
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:emoticonsPath];
    
    NSMutableArray *muarray = @[].mutableCopy;
    
    for (NSDictionary *obj in dic[@"emoticons"]) {
        LSDEmoticonModel *model = [LSDEmoticonModel baseModelWithDic:obj];
        model.imagePath = [bundlePath stringByAppendingPathComponent:fileName];
        [muarray addObject:model];
        
    }
    
    return muarray;
}

///将表情分页 即将一个一维的数组分割成二维数组
+(NSMutableArray *)pageEmoticonList:(NSMutableArray *)emoticons{

    
    NSMutableArray *muarray = @[].mutableCopy;
    
    NSInteger count = emoticons.count;
    
    ///计算页总数
    NSInteger page = (count - 1)/20 + 1;

    ///切割原数组
    for (int i = 0; i < page ; i ++) {
        
        NSInteger len = 20;
        ///最后一页
        if (i == page - 1) {
            len = count - i * 20;
        }
        
        NSArray *array = [emoticons subarrayWithRange:NSMakeRange(i * 20, len)];
        
        [muarray addObject:array];
    }
    
    return muarray;
    
}

+(NSInteger)pageEmoticon:(NSMutableArray *)emoticons
{

    NSInteger count = emoticons.count;
    
    ///计算页总数
    NSInteger page = (count - 1)/20 + 1;
    
    return page;
    
}

+(NSArray *)defaultPage
{
    NSInteger page = [LSDEmoticonHelper pageEmoticon:[LSDEmoticonHelper defaultEmoticons]];
    return @[@1,@(page)];
}

+(NSArray *)emojiPage
{
    NSInteger page = [LSDEmoticonHelper pageEmoticon:[LSDEmoticonHelper emojiEmoticons]];
    
    NSInteger beginPage = [[[LSDEmoticonHelper defaultPage]lastObject] integerValue] + 1;
    
    return @[@(beginPage),@(beginPage+page-1)];
}

+(NSArray *)lxhPage
{
    NSInteger page = [LSDEmoticonHelper pageEmoticon:[LSDEmoticonHelper lxhEmoticons]];
    
    NSInteger beginPage = [[[LSDEmoticonHelper emojiPage]lastObject] integerValue] + 1;
    
    return @[@(beginPage),@(beginPage+page-1)];
    
}
///添加表情到最近表情数组中
+(void)addEmoticonToRecentEmoticons:(LSDEmoticonModel *)emoticon{

    NSMutableArray *muarray = recentEmoticonsArray;
    
    if (![muarray containsObject:emoticon]) {

        [muarray insertObject:emoticon atIndex:0];
    }
    
    if (muarray.count > 20) {
        [muarray removeLastObject];
    }

    recentEmoticonsArray = muarray;
}

@end
