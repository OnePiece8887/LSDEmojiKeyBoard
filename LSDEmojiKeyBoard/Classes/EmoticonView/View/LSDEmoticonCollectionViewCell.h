//
//  LSDEmoticonCollectionViewCell.h
//  LSDEmojiKeyBoard
//
//  Created by 神州锐达 on 2017/4/27.
//  Copyright © 2017年 OnePiece. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LSDEmoticonModel.h"

@protocol LSDEmoticonCollectionViewCellDelegate<NSObject>

-(void)EmoticonCollectionViewCellEmoticonBtnClick;

@end

@interface LSDEmoticonCollectionViewCell : UICollectionViewCell

///表情model数组
@property(strong,nonatomic)NSMutableArray *emoticonModelArray;

///代理
@property(weak,nonatomic)id<LSDEmoticonCollectionViewCellDelegate> delegate;

@end
