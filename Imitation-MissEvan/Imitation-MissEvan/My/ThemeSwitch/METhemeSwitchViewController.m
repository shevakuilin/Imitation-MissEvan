//
//  METhemeSwitchViewController.m
//  Imitation-MissEvan
//
//  Created by shevchenko on 16/12/19.
//  Copyright © 2016年 xkl. All rights reserved.
//

#import "METhemeSwitchViewController.h"
#import "MEHeader.h"
#import "METhemeSwitchCollectionViewCell.h"

@interface METhemeSwitchViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (strong, nonatomic) UICollectionView * collectionView;
@property (assign, nonatomic) NSInteger row;

@end

@implementation METhemeSwitchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"设置主题";
    
    //创建一个layout布局类
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    //设置布局方向为垂直流布局
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    //创建collectionView 通过一个布局策略layout来创建
    self.collectionView = [[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:layout];
    [self.view addSubview:self.collectionView];
    self.collectionView.backgroundColor = [UIColor clearColor];//ME_Color(243, 243, 243);
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[METhemeSwitchCollectionViewCell class] forCellWithReuseIdentifier:@"ThemeSwitch"];
    
//    self.navigationItem.leftBarButtonItem = [MEUtil barButtonWithTarget:self action:@selector(backView) withImage:[UIImage imageNamed:@"back_new_9x16_"]];
    
    self.row = 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)backView
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark - collectionView
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    METhemeSwitchCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ThemeSwitch" forIndexPath:indexPath];
    cell.chooseRow = self.row;
    if (self.row == 0) {
        if (self.row == indexPath.row) {
            cell.style = METhemeStyleDefault;
        } else {
            cell.style = METhemeStyleNight;
        }
    } else {
        if (self.row == indexPath.row) {
            cell.style = METhemeStyleNight;
            
        } else {
            cell.style = METhemeStyleDefault;
        }
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.row = indexPath.row;
    [self.collectionView reloadData];
}

//定义每个Item 的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(ME_Width / 2, 270);
}

//item横向间距
- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout
minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

//item纵向间距
- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout
minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}


@end
