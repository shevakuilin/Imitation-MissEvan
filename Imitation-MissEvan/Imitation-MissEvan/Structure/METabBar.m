//
//  METabBar.m
//  Imitation-MissEvan
//
//  Created by huiren on 16/10/24.
//  Copyright © 2016年 xkl. All rights reserved.
//

#import "METabBar.h"
#import "METabBarButton.h"
#import "MEPrefixHeader.pch"

@interface METabBar ()

@property (weak, nonatomic) UIButton * selectedBtn;//设置之前选中的按钮

@end

@implementation METabBar

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        for (NSInteger i = 0; i < ME_DATASOURCE.imageNameArray.count; i ++) {
            METabBarButton * button = [[METabBarButton alloc] init];
            
            NSString * imageName = [NSString stringWithFormat:@"ntab_%@_normal", ME_DATASOURCE.imageNameArray[i]];
            NSString * imageNameSel = [NSString stringWithFormat:@"ntab_%@_selected", ME_DATASOURCE.imageNameArray[i]];
            
            [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:imageNameSel] forState:UIControlStateSelected];
            
            NSString * barTitie = ME_DATASOURCE.barTitleArray[i];
            [button setTitle:barTitie forState:UIControlStateNormal];
            [button setTitle:barTitie forState:UIControlStateSelected];
            [button setTitleColor:ME_Color(61, 61, 61) forState:UIControlStateNormal];
            [button setTitleColor:ME_Color(61, 61, 61) forState:UIControlStateSelected];
            button.titleLabel.font = [UIFont systemFontOfSize:10];
            button.titleLabel.textAlignment = NSTextAlignmentCenter;
            
            //title和image的距离可能需要依据不同机型进行动态调整
//            NSInteger count = self.subviews.count;
//            CGFloat width = self.bounds.size.width / count;
            button.titleEdgeInsets = UIEdgeInsetsMake(self.bounds.size.height + 30, -22, 0, 0);
            button.imageEdgeInsets = UIEdgeInsetsMake(-10, 20, 0, 0);
//            button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;//设置button的内容横向居中  设置content是title和image一起变化
            [self addSubview:button];
            
            button.tag = i;//设置按钮的标记, 方便来索引当前的按钮,并跳转到相应的视图
            
            [button addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
            
            if (0 == i) {
              [self clickBtn:button];
            }
        }
    }
    return self;
}

- (void)addButtonWithImage:(UIImage *)defaultImage selectedImage:(UIImage *)selectedImage
{
    UIButton * button = [[UIButton alloc] init];

    [button setImage:defaultImage forState:UIControlStateNormal];
    [button setImage:selectedImage forState:UIControlStateSelected];
    
    [self addSubview:button];
    
    [button addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    //如果是第一个按钮, 则选中(按顺序一个个添加)
    if (self.subviews.count == 1) {
        [self clickBtn:button];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSInteger count = self.subviews.count;
    for (NSInteger i = 0; i < count; i ++) {
        //获取按钮
        UIButton * button = self.subviews[i];
        
        button.tag = i;//设置按钮的标记, 方便来索引当前的按钮,并跳转到相应的视图
        
        CGFloat x = i * self.bounds.size.width / count;
        CGFloat y = 0;
        CGFloat width = self.bounds.size.width / count;
        CGFloat height = self.bounds.size.height;
        
        //中间的睡觉猫需要做特殊处理
        
        button.frame = CGRectMake(x, y, width, height);
        
        if (i == 2) {
            NSMutableArray * stackImageArray = [NSMutableArray new];
            for (NSInteger i = 1; i < 141; i ++) {
                NSString * stackImageName;
                if (i < 10) {
                    stackImageName = [NSString stringWithFormat:@"DRRR猫 睡觉000%@_200x200_@1x", @(i)];
                } else if (i > 9 && i < 100){
                    stackImageName = [NSString stringWithFormat:@"DRRR猫 睡觉00%@_200x200_@1x", @(i)];
                } else {
                    stackImageName = [NSString stringWithFormat:@"DRRR猫 睡觉0%@_200x200_@1x", @(i)];
                }
                UIImage * imageName = [UIImage imageNamed:stackImageName];
                [stackImageArray addObject:imageName];
            }
            
            //设置图片的序列帧 图片数组
            //                [button setImage:[uiim] forState:<#(UIControlState)#>];
            UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(2 * self.bounds.size.width / count, -35, 80, 80)];
            // 设置图片的序列帧 图片数组
            imageView.animationImages = stackImageArray;
            //动画重复次数
            imageView.animationRepeatCount = 10000000 * 10000000;
            //动画执行时间,多长时间执行完动画
            imageView.animationDuration = 8.0;
            //开始动画
            [imageView startAnimating];
            [self addSubview:imageView];
        }
        
    }
}

- (void)clickBtn:(UIButton *)button
{
    //先将之前选中的按钮设置为未选中
    self.selectedBtn.selected = NO;
    //再将当前按钮设置为选中
    button.selected = YES;
    //最后把当前按钮赋值为之前选中的按钮
    self.selectedBtn = button;
    
    //注: 切换视图控制器的事情,应该交给controller来做
    
    if ([self.delegate respondsToSelector:@selector(tabBar:selectedFrom:whereTo:)]) {
        [self.delegate tabBar:self selectedFrom:self.selectedBtn.tag whereTo:button.tag];
    }

}
@end
