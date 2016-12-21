//
//  METabBar.m
//  Imitation-MissEvan
//
//  Created by huiren on 16/10/24.
//  Copyright © 2016年 xkl. All rights reserved.
//

#import "METabBar.h"
#import "METabBarButton.h"
#import "MEHeader.h"

@interface METabBar ()

@property (weak, nonatomic) UIButton * selectedBtn;//设置之前选中的按钮
@property (nonatomic, strong) METabBarButton * button;

@end

@implementation METabBar

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
//        //获取通知中心单例对象
        NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
        //添加当前类对象为一个观察者，name和object设置为nil，表示接收一切通知
        [center addObserver:self selector:@selector(notice:) name:@"themeStyle" object:nil];
        
        
        for (NSInteger i = 0; i < ME_DATASOURCE.imageNameArray.count; i ++) {
            self.button = [[METabBarButton alloc] init];
            NSString * imageName = @"";
            NSString * imageNameSel = @"";
            
            NSString * barTitie = ME_DATASOURCE.barTitleArray[i];
            [self.button setTitle:barTitie forState:UIControlStateNormal];
            [self.button setTitle:barTitie forState:UIControlStateSelected];
            
            if ([[EAThemeManager shareManager].currentThemeIdentifier isEqualToString:EAThemeNormal]) {
                imageName = [NSString stringWithFormat:@"ntab_%@_normal", ME_DATASOURCE.imageNameArray[i]];
                imageNameSel = [NSString stringWithFormat:@"ntab_%@_selected", ME_DATASOURCE.imageNameArray[i]];
                [self.button setTitleColor:ME_Color(61, 61, 61) forState:UIControlStateNormal];
                [self.button setTitleColor:ME_Color(61, 61, 61) forState:UIControlStateSelected];
                
            } else {
                imageName = [NSString stringWithFormat:@"ntab_%@_normal_night", ME_DATASOURCE.imageNameArray[i]];
                imageNameSel = [NSString stringWithFormat:@"ntab_%@_selected_night", ME_DATASOURCE.imageNameArray[i]];
                [self.button setTitleColor:[UIColor lightTextColor] forState:UIControlStateNormal];
                [self.button setTitleColor:[UIColor lightTextColor] forState:UIControlStateSelected];
            }
            [self.button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
            [self.button setImage:[UIImage imageNamed:imageNameSel] forState:UIControlStateSelected];
            
            self.button.titleLabel.font = [UIFont systemFontOfSize:10];
            self.button.titleLabel.textAlignment = NSTextAlignmentCenter;
            
            //title和image的距离可能需要依据不同机型进行动态调整
//            NSInteger count = self.subviews.count;
//            CGFloat width = self.bounds.size.width / count;
            self.button.titleEdgeInsets = UIEdgeInsetsMake(self.bounds.size.height + 30, -22, 0, 0);
            self.button.imageEdgeInsets = UIEdgeInsetsMake(-10, 20, 0, 0);
//            button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;//设置button的内容横向居中  设置content是title和image一起变化
            
            
            [self addSubview:self.button];
            
            self.button.tag = i;//设置按钮的标记, 方便来索引当前的按钮,并跳转到相应的视图
            
            [self.button addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
            
            //初始化睡觉猫
            self.catImageView = [[METabBarCatImageView alloc] init];
            
            if (0 == i) {
              [self clickBtn:self.button];
            }
        }
    }
    return self;
}

- (void)notice:(id)sender
{
    NSString * themeStyle = [sender userInfo][@"style"];
    NSString * imageName = @"";
    NSString * imageNameSel = @"";
    for (NSInteger i = 0; i < ME_DATASOURCE.imageNameArray.count; i ++) {
        if ([themeStyle isEqualToString:EAThemeNormal]) {
            imageName = [NSString stringWithFormat:@"ntab_%@_normal", ME_DATASOURCE.imageNameArray[i]];
            imageNameSel = [NSString stringWithFormat:@"ntab_%@_selected", ME_DATASOURCE.imageNameArray[i]];
//            [self.button setTitleColor:ME_Color(61, 61, 61) forState:UIControlStateNormal];
//            [self.button setTitleColor:ME_Color(61, 61, 61) forState:UIControlStateSelected];
            [self.button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
            [self.button setImage:[UIImage imageNamed:imageNameSel] forState:UIControlStateSelected];
            
        } else {
            imageName = [NSString stringWithFormat:@"ntab_%@_normal_night", ME_DATASOURCE.imageNameArray[i]];
            imageNameSel = [NSString stringWithFormat:@"ntab_%@_selected_night", ME_DATASOURCE.imageNameArray[i]];
//            [self.button setTitleColor:[UIColor lightTextColor] forState:UIControlStateNormal];
//            [self.button setTitleColor:[UIColor lightTextColor] forState:UIControlStateSelected];
            [self.button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
            [self.button setImage:[UIImage imageNamed:imageNameSel] forState:UIControlStateSelected];
        }
        
    }
}
//- (void)addButtonWithImage:(UIImage *)defaultImage selectedImage:(UIImage *)selectedImage
//{
//    UIButton * button = [[UIButton alloc] init];
//
//    [button setImage:defaultImage forState:UIControlStateNormal];
//    [button setImage:selectedImage forState:UIControlStateSelected];
//    
//    [self addSubview:button];
//    
//    [button addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
//    
//    //如果是第一个按钮, 则选中(按顺序一个个添加)
//    if (self.subviews.count == 1) {
//        [self clickBtn:button];
//    }
//}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSInteger count = self.subviews.count + 1;//此处+1为了代替中间的睡觉猫的位置
    for (NSInteger i = 0; i < count; i ++) {
        //获取按钮
        UIButton * button = self.subviews[i];
        
        button.tag = i;//设置按钮的标记, 方便来索引当前的按钮,并跳转到相应的视图
        
        CGFloat x = 0;//i * self.bounds.size.width / count;
        if (i < 2) {
            x = i * self.bounds.size.width / count;
        } else {
            x = (i + 1) * self.bounds.size.width / count;
        }
        CGFloat y = 0;
        CGFloat width = self.bounds.size.width / count;
        CGFloat height = self.bounds.size.height;
        
        button.frame = CGRectMake(x, y, width, height);
        
        //中间的睡觉猫需要做特殊处理
        self.catImageView.frame = CGRectMake(2 * self.bounds.size.width / count, -35, 80, 80);
        [self addSubview:self.catImageView];
        
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
