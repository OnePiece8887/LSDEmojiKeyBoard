//
//  LSDEmoticonView.m
//  LSDEmojiKeyBoard
//
//  Created by 神州锐达 on 2017/4/27.
//  Copyright © 2017年 OnePiece. All rights reserved.
//

#import "LSDEmoticonView.h"
#import "LSDEmoticonFootView.h"
#import "LSDEmoticonCollectionViewCell.h"
#import "LSDEmoticonHelper.h"
@interface LSDEmoticonView ()<LSDEmoticonFootViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UIScrollViewDelegate,LSDEmoticonCollectionViewCellDelegate>
///底部表情类型选择view
@property(strong,nonatomic)LSDEmoticonFootView *footView;

///表情
@property(strong,nonatomic)UICollectionView *collectionView;

///flowLayout
@property(strong,nonatomic)UICollectionViewFlowLayout *layout;

@end

static NSString *reusedID = @"LSDEmoticonCollectionViewCell";

@implementation LSDEmoticonView

-(instancetype)initWithFrame:(CGRect)frame
{

    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

-(void)setupUI{

    
    [self addSubview:self.collectionView];

    [self addSubview:self.footView];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.bottom.equalTo(self.footView.mas_top);
    }];
    
    [self.footView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(45);
    }];
    
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    
    [self.collectionView reloadData];

}

-(void)layoutSubviews
{

    [super layoutSubviews];
    
    self.layout.itemSize = CGSizeMake(KScreenWidth, self.collectionView.frame.size.height);
    
    
}

#pragma mark -- UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{

    return [LSDEmoticonHelper getAllEmoticons].count;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{

    NSMutableArray *muarray = (NSMutableArray *)[LSDEmoticonHelper getAllEmoticons][section];
    
    return muarray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

    LSDEmoticonCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reusedID forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[LSDEmoticonCollectionViewCell alloc]initWithFrame:CGRectZero];
        
    }
  
    NSMutableArray *muarray = (NSMutableArray *)[LSDEmoticonHelper getAllEmoticons][indexPath.section];
    
    cell.emoticonModelArray = muarray[indexPath.item];
 
    cell.delegate = self;
    
    return cell;
}
#pragma mark -- UICollectionViewDelegate


#pragma mark -- UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{

    CGFloat offsetX = scrollView.contentOffset.x;
    
    NSInteger page = (offsetX + scrollView.frame.size.width*0.5)/scrollView.frame.size.width;
    
    if (page == 0) {
        self.footView.recentBtn.selected = YES;
        self.footView.defaultBtn.selected = NO;
        self.footView.emojiBtn.selected = NO;
        self.footView.lxhBtn.selected = NO;
    }else if(page >= [[LSDEmoticonHelper defaultPage].firstObject integerValue] && page <= [[LSDEmoticonHelper defaultPage].lastObject integerValue])
    {  self.footView.recentBtn.selected = NO;
        self.footView.defaultBtn.selected = YES;
        self.footView.emojiBtn.selected = NO;
        self.footView.lxhBtn.selected = NO;
        self.footView.recentBtn.selected = NO;
       
    }else if(page >= [[LSDEmoticonHelper emojiPage].firstObject integerValue] && page <= [[LSDEmoticonHelper emojiPage].lastObject integerValue])
    {
      
        self.footView.defaultBtn.selected = NO;
        self.footView.emojiBtn.selected = YES;
        self.footView.lxhBtn.selected = NO;
    }else if(page >= [[LSDEmoticonHelper lxhPage].firstObject integerValue] && page <= [[LSDEmoticonHelper lxhPage].lastObject integerValue])
    {
        self.footView.recentBtn.selected = NO;
        self.footView.defaultBtn.selected = NO;
        self.footView.emojiBtn.selected = NO;
        self.footView.lxhBtn.selected = YES;
    }
}

#pragma mark -- LSDEmoticonFootViewDelegate
-(void)EmoticonFootViewDelegateDidClickBtnClick:(LSDEmoticonFootViewBtnType)type
{

    switch (type) {
        case LSDEmoticonFootViewBtnTypeRecent:{
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:0];
            [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
        }
           
            break;
        case LSDEmoticonFootViewBtnTypeDefault:{
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:1];
            [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
        }
            
            break;
        case LSDEmoticonFootViewBtnTypeEmoji:{
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:2];
            [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
        }
            
            break;
        case LSDEmoticonFootViewBtnTypeLxh:{
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:3];
            [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
        }
            
            break;
            
        default:
            break;
    }
    
}

#pragma mark -- LSDEmoticonCollectionViewCellDelegate
-(void)EmoticonCollectionViewCellEmoticonBtnClick
{

    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:0];
    
    [self.collectionView reloadSections:indexSet];
    
    
}

#pragma mark -- 懒加载
-(LSDEmoticonFootView *)footView
{

    if (_footView == nil) {
        
        _footView = [[LSDEmoticonFootView alloc]init];
        
        _footView.delegate = self;
    
    }
    
    return _footView;
}

-(UICollectionView *)collectionView
{

    if (_collectionView == nil) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = 0.0;
        layout.minimumInteritemSpacing = 0.0;
        self.layout = layout;
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.pagingEnabled = YES;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[LSDEmoticonCollectionViewCell class] forCellWithReuseIdentifier:reusedID];
    }
    
    return _collectionView;
}

@end



















