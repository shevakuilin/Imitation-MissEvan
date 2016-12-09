//
//  MEChannelViewController.m
//  Imitation-MissEvan
//
//  Created by huiren on 16/10/24.
//  Copyright © 2016年 xkl. All rights reserved.
//

#import "MEChannelViewController.h"
#import "MEHeader.h"
#import "MEChannelCollectionViewCell.h"

@interface MEChannelViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView * collectionView;
@property (nonatomic, strong) UIButton * soundTypeButton;
@property (nonatomic, strong) UIImageView * pullImageView;
@property (nonatomic, strong) UIButton * allButton;
@property (nonatomic, strong) UIButton * mSoundButton;
@property (nonatomic, strong) UIButton * bellButton;

@end

@implementation MEChannelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"频道";
    [self customView];
}

- (void)customView
{
    UIView * topView = [UIView new];
    [self.view addSubview:topView];
    topView.backgroundColor = ME_Color(243, 243, 243);
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        
        make.size.mas_equalTo(CGSizeMake(ME_Width, 40));
    }];
    
    UIImageView * topShadow = [UIImageView new];
    [topView addSubview:topShadow];
    topShadow.backgroundColor = ME_Color(238, 238, 238);
    [topShadow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView).with.offset(1);
        make.left.equalTo(topView);
        make.right.equalTo(topView);
        
        make.size.mas_equalTo(CGSizeMake(ME_Width, 1));
    }];
    
    UIImageView * downShadow = [UIImageView new];
    [topView addSubview:downShadow];
    downShadow.backgroundColor = ME_Color(229, 229, 229);//229, 230, 230
    [downShadow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(topView).with.offset(-1);
        make.left.equalTo(topView);
        make.right.equalTo(topView);
        
        make.size.mas_equalTo(CGSizeMake(ME_Width, 1));
    }];
    
    UILabel * titleLabel = [UILabel new];
    [topView addSubview:titleLabel];
    titleLabel.font = [UIFont systemFontOfSize:12];
    titleLabel.textColor = [UIColor grayColor];
    titleLabel.text = @"分类：";
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(topView).with.offset(10);
        make.centerY.equalTo(topView);
    }];
    
    self.soundTypeButton = [UIButton new];
    [topView addSubview:self.soundTypeButton];
    [self.soundTypeButton setImage:[UIImage imageNamed:@"td_icon_pull_11x6_"] forState:UIControlStateNormal];
    [self.soundTypeButton setTitle:@"全部" forState:UIControlStateNormal];
    [self.soundTypeButton setTitleColor:ME_Color(215, 32, 27) forState:UIControlStateNormal];
    self.soundTypeButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.soundTypeButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -30, 0, 0)];
    [self.soundTypeButton setImageEdgeInsets:UIEdgeInsetsMake(0, 32, 0, 0)];
    [self.soundTypeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleLabel.mas_right);
        make.centerY.equalTo(titleLabel);
        
        make.size.mas_equalTo(CGSizeMake(50, 15));
    }];
    [self.soundTypeButton addTarget:self action:@selector(showPullView) forControlEvents:UIControlEventTouchUpInside];
    
    //创建一个layout布局类
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    //设置布局方向为垂直流布局
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    //创建collectionView 通过一个布局策略layout来创建
    self.collectionView = [[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:layout];
    [self.view addSubview:self.collectionView];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.backgroundColor = ME_Color(243, 243, 243);
    self.collectionView.showsVerticalScrollIndicator = NO;
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView.mas_bottom);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view).with.offset(-45);
    }];
    [self.collectionView registerClass:[MEChannelCollectionViewCell class] forCellWithReuseIdentifier:@"Channel"];
    
    self.pullImageView = [UIImageView new];
    [self.view addSubview:self.pullImageView];
    self.pullImageView.image = [UIImage imageNamed:@"td_bg_pull_72x191_"];
    [self.pullImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView.mas_bottom);
        make.centerX.equalTo(self.soundTypeButton);
        
        make.size.mas_equalTo(CGSizeMake(72, 133));
    }];
    self.pullImageView.hidden = YES;
    self.pullImageView.userInteractionEnabled = YES;
//    UITapGestureRecognizer * gesture = [[UITapGestureRecognizer alloc] init];
//    [gesture addTarget:self action:@selector(hiddenPullView)];
//    [self.pullImageView addGestureRecognizer:gesture];
    
    self.allButton = [UIButton new];
    [self.pullImageView addSubview:self.allButton];
    [self.allButton setTitle:@"   全部   " forState:UIControlStateNormal];
    [self.allButton setTitleColor:ME_Color(215, 32, 27) forState:UIControlStateSelected];
    [self.allButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    self.allButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [self boundsOfButton:self.allButton normalButton1:self.mSoundButton normalButton2:self.bellButton];
    [self.allButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.pullImageView).with.offset(18);
        make.centerX.equalTo(self.pullImageView);
    }];
    [self.allButton addTarget:self action:@selector(all) forControlEvents:UIControlEventTouchUpInside];
    self.allButton.selected = YES;
    
    self.mSoundButton = [UIButton new];
    [self.pullImageView addSubview:self.mSoundButton];
    [self.mSoundButton setTitle:@"   M音   " forState:UIControlStateNormal];
    [self.mSoundButton setTitleColor:ME_Color(215, 32, 27) forState:UIControlStateSelected];
    [self.mSoundButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    self.mSoundButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.mSoundButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.allButton.mas_bottom).with.offset(10);
        make.centerX.equalTo(self.pullImageView);
    }];
    [self.mSoundButton addTarget:self action:@selector(mSound) forControlEvents:UIControlEventTouchUpInside];
    
    self.bellButton = [UIButton new];
    [self.pullImageView addSubview:self.bellButton];
    [self.bellButton setTitle:@"   铃声   " forState:UIControlStateNormal];
    [self.bellButton setTitleColor:ME_Color(215, 32, 27) forState:UIControlStateSelected];
    [self.bellButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    self.bellButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.bellButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mSoundButton.mas_bottom).with.offset(10);
        make.centerX.equalTo(self.pullImageView);
    }];
    [self.bellButton addTarget:self action:@selector(bell) forControlEvents:UIControlEventTouchUpInside];

}

- (void)showPullView
{
    //TODO:展开选项
    self.pullImageView.hidden = NO;
}

- (void)all
{
    //TODO:全部
    self.allButton.selected = YES;
    self.mSoundButton.selected = NO;
    self.bellButton.selected = NO;
    [self boundsOfButton:self.allButton normalButton1:self.mSoundButton normalButton2:self.bellButton];
    [self.soundTypeButton setTitle:@"   全部   " forState:UIControlStateNormal];
    self.pullImageView.hidden = YES;
    [self.collectionView reloadData];
}

- (void)mSound
{
    //TODO:M音
    self.mSoundButton.selected = YES;
    self.allButton.selected = NO;
    self.bellButton.selected = NO;
    [self boundsOfButton:self.mSoundButton normalButton1:self.allButton normalButton2:self.bellButton];
    [self.soundTypeButton setTitle:@"   M音   " forState:UIControlStateNormal];
    self.pullImageView.hidden = YES;
    [self.collectionView reloadData];
}

- (void)bell
{
    //TODO:铃声
    self.bellButton.selected = YES;
    self.allButton.selected = NO;
    self.mSoundButton.selected = NO;
    [self boundsOfButton:self.bellButton normalButton1:self.allButton normalButton2:self.mSoundButton];
    [self.soundTypeButton setTitle:@"   铃声   " forState:UIControlStateNormal];
    self.pullImageView.hidden = YES;
    [self.collectionView reloadData];
}



- (void)boundsOfButton:(UIButton *)button normalButton1:(UIButton *)button1 normalButton2:(UIButton *)button2
{
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 5;
    button.layer.borderWidth = 0.5;
    button.layer.borderColor = ME_Color(215, 32, 27).CGColor;
    button1.layer.borderColor = [UIColor clearColor].CGColor;
    button2.layer.borderColor = [UIColor clearColor].CGColor;
}

#pragma mark -
#pragma mark - collectionView
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MEChannelCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Channel" forIndexPath:indexPath];
    NSInteger x = arc4random() % 3;
    cell.dic = ME_DATASOURCE.channelCellArray[x];
    cell.backgroundColor = ME_Color(243, 243, 243);
    [cell.themesImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cell).with.offset(6);
        make.size.mas_equalTo(CGSizeMake((ME_Width / 2) - 12, ((ME_Width - 12) / 3) - 25));
    }];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

//定义每个Item 的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(ME_Width / 2, 140);
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
