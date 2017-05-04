//
//  LSDTextView.m
//  LSDEmojiKeyBoard
//
//  Created by 神州锐达 on 2017/4/27.
//  Copyright © 2017年 OnePiece. All rights reserved.
//

#import "LSDTextView.h"

@implementation LSDTextView

-(void)setPlaceString:(NSString *)placeString
{

    _placeString = placeString;
    
    [self setNeedsDisplay];

}

-(void)drawRect:(CGRect)rect
{

    [self.placeString drawAtPoint:CGPointMake(2, 8) withAttributes:@{
                                                                     NSFontAttributeName:[UIFont systemFontOfSize:16],
                                                                     NSForegroundColorAttributeName:[UIColor lightGrayColor]
                                                                     }];
    
}

@end
