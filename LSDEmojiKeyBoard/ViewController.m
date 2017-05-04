//
//  ViewController.m
//  LSDEmojiKeyBoard
//
//  Created by 神州锐达 on 2017/4/27.
//  Copyright © 2017年 OnePiece. All rights reserved.
//

#import "ViewController.h"
#import "LSDTextView.h"
#import "LSDEmoticonView.h"
#import "LSDEmoticonModel.h"

@interface ViewController ()<UITextViewDelegate>

@property(strong,nonatomic)LSDTextView *textView;

@property(strong,nonatomic)UIToolbar *toolbar;

///表情键盘
@property(strong,nonatomic)LSDEmoticonView *emoticonView;

///toolBar底部约束
@property(strong,nonatomic)MASConstraint *toolBarBottomConstraint;

///标记改变键盘frame时是否开启动画
@property(assign,nonatomic)BOOL Animationing;

///表情图片的高度
@property(assign,nonatomic)CGFloat lineHeight;




@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
    ///监听键盘的frame变化
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeToolBarFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
     ///监听到表情按钮的点击事件后添加表情到textView
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addEmoticonInTextView:) name:KaddEmoticon object:nil];
    
    ///监听表情键盘按钮的删除通知
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deleteAttributeString) name:KDeleteEmoticon object:nil];
    
    
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)setupUI
{

    [self setupTextView];
    
    [self setupToolBar];
    
    
//    self.lineHeight = self.textView.font.lineHeight;
    
}

-(void)setupTextView{

    [self.view addSubview:self.textView];
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(20);
        make.left.equalTo(self.view).offset(10);
        make.right.equalTo(self.view).offset(-10);
        make.bottom.equalTo(self.view);
    }];
}

-(void)setupToolBar
{

    [self.view addSubview:self.toolbar];
    
    [self.toolbar mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.equalTo(self.view);
        self.toolBarBottomConstraint = make.bottom.equalTo(self.view);
        make.height.mas_equalTo(49);
    }];
    
}


-(void)inputEmoticon
{
    self.Animationing = NO;
    ///切换表情键盘
    [self.textView resignFirstResponder];
    
    if (self.textView.inputView == nil) {
        self.textView.inputView = self.emoticonView;
    }else
    {
        self.textView.inputView = nil;
    }
    
    self.Animationing = YES;
    [self.textView becomeFirstResponder];
    
}

///改变toolbar的约束
-(void)changeToolBarFrame:(NSNotification *)notication
{
    NSDictionary *userInfo = notication.userInfo;
    
    CGRect endFrame = [userInfo[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
    
    ///键盘隐藏
    if (endFrame.origin.y == KScreenHeight) {
        
        [self.toolBarBottomConstraint uninstall];
        [self.toolbar mas_updateConstraints:^(MASConstraintMaker *make) {
            self.toolBarBottomConstraint = make.bottom.equalTo(self.view);
        }];
        
        if (!self.Animationing) {
            return;
        }
        
        [UIView animateWithDuration:0.25 animations:^{
            [self.view layoutIfNeeded];
        } completion:^(BOOL finished) {
            
        }];
        
    }else
    {
    
        [self.toolBarBottomConstraint uninstall];
        [self.toolbar mas_updateConstraints:^(MASConstraintMaker *make) {
            self.toolBarBottomConstraint = make.bottom.equalTo(self.view).offset(-endFrame.size.height);
        }];
        
        if (!self.Animationing) {
            return;
        }
        
        [UIView animateWithDuration:0.25 animations:^{
            [self.view layoutIfNeeded];
        } completion:^(BOOL finished) {
            
        }];
        
        
    }
    
}

#pragma mark --  通知
-(void)addEmoticonInTextView:(NSNotification *)notification
{

    NSDictionary *userInfo = notification.userInfo;
    
    LSDEmoticonModel *emoticonModel = userInfo[@"emoticon"];
    
    NSRange range = self.textView.selectedRange;
    
    if (emoticonModel.emoji != nil) {
  
        NSAttributedString *emojiStr = [[NSMutableAttributedString alloc]initWithString:emoticonModel.emoji];
        
        ///> 在光标位置插入带有图片的属性字符串
        [self.textView.textStorage insertAttributedString:emojiStr atIndex:self.textView.selectedRange.location];
        
        //显示表情后让光标往后移
        self.textView.selectedRange = NSMakeRange(range.location+emoticonModel.emoji.length, 0);
    }
    
    if (emoticonModel.png != nil) {
    
        NSString *emoticonImagePath = [NSString stringWithFormat:@"%@/%@",emoticonModel.imagePath,emoticonModel.png];
        
        
        UIImage *emoticonImage = [UIImage imageNamed:emoticonImagePath];
        
        
        NSTextAttachment *attachment = [[NSTextAttachment alloc]init];
    
        attachment.image = emoticonImage;
        
        attachment.bounds = CGRectMake(0, -3, 22, 22);

        NSAttributedString *attribute = [NSAttributedString attributedStringWithAttachment:attachment];
    

        [self.textView.textStorage insertAttributedString:attribute atIndex:self.textView.selectedRange.location];
        //显示表情后让光标往后移
        self.textView.selectedRange = NSMakeRange(range.location+1, 0);

    }
    
    [self.textView.delegate textViewDidChange:self.textView];
    
    
}

-(void)deleteAttributeString
{
///删除回退
    [self.textView deleteBackward];
}

#pragma mark -- UITextViewDelegate
-(void)textViewDidChange:(UITextView *)textView
{
    if (self.textView.hasText) {
        self.textView.placeString = @"";
    }else
    {
        self.textView.placeString = @"分享新鲜事";
    }
    
    NSRange wholeRange = NSMakeRange(0, textView.textStorage.length);
    [textView.textStorage removeAttribute:NSFontAttributeName range:wholeRange];
    ///> 这里将字体大小设置为20, 和表情的高度一样, 这样看起来就好多了
    [textView.textStorage addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20.0] range:wholeRange];

}


#pragma mark -- 懒加载
-(LSDTextView *)textView
{

    if (_textView == nil) {
        _textView = [[LSDTextView alloc]init];
        _textView.placeString = @"分享新鲜事";
        _textView.delegate = self;
        _textView.alwaysBounceVertical = YES;
        _textView.font = [UIFont systemFontOfSize:20];
        ///拖拽时隐藏键盘
        _textView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    }
    return _textView;
}

-(UIToolbar *)toolbar
{

    if (_toolbar == nil) {
        
        _toolbar = [[UIToolbar alloc]init];
       NSString *path =  [[NSBundle mainBundle] pathForResource:@"keyBoardToolBarList.plist" ofType:nil];
        
        NSArray *array = [NSArray arrayWithContentsOfFile:path];
        
        NSMutableArray *muarray = @[].mutableCopy;
        
        for (NSDictionary *dic  in array) {
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            
            NSString *action = dic[@"action"];
            if (action.length) {
                btn = [UIButton getBtnTitle:nil image:dic[@"imageName"] selectedImage:dic[@"imageName"] target:self action:NSSelectorFromString(action) type:0];
            }else{
                btn = [UIButton getBtnTitle:nil image:dic[@"imageName"] selectedImage:dic[@"imageName"] target:self action:nil type:0];
            }
            [btn sizeToFit];
            UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:btn];
        
            [muarray addObject:item];
            
            UIBarButtonItem *fixItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
            
            [muarray addObject:fixItem];
        }
        
        [muarray removeLastObject];
        _toolbar.items = muarray;
    }
    return _toolbar;
    
}

-(LSDEmoticonView *)emoticonView
{

    if (_emoticonView == nil) {
        _emoticonView = [[LSDEmoticonView alloc]init];
        _emoticonView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 206);
    }
    return _emoticonView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
