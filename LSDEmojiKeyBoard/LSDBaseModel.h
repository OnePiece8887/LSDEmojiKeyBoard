//
//  LSDBaseModel.h
//  ProjectTemplate
//
//  Created by 神州锐达 on 17/3/8.
//  Copyright © 2017年 OnePiece. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSDBaseModel : NSObject


+(instancetype)baseModelWithDic:(NSDictionary *)dic;

///如果有不能解析的字段，在子类中重写改方法
-(instancetype)baseModelWithDic:(NSDictionary *)dic;

@end
