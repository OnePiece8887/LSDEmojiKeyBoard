//
//  LSDBaseModel.m
//  ProjectTemplate
//
//  Created by 神州锐达 on 17/3/8.
//  Copyright © 2017年 OnePiece. All rights reserved.
//

#import "LSDBaseModel.h"

@implementation LSDBaseModel

-(instancetype)baseModelWithDic:(NSDictionary *)dic
{
    [self setValuesForKeysWithDictionary:dic];
    
    return self;
}

+(instancetype)baseModelWithDic:(NSDictionary *)dic
{

    return [[[self alloc]init] baseModelWithDic:dic];
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{}

@end
