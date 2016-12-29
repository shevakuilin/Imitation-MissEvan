//
//  MEVoiceListOfContainsTableViewCell.m
//  Imitation-MissEvan
//
//  Created by huiren on 16/12/29.
//  Copyright © 2016年 xkl. All rights reserved.
//

#import "MEVoiceListOfContainsTableViewCell.h"
#import "MEHeader.h"
#import "MEVoiceListCollectionViewCell.h"
#import "MEHotMVoiceCollectionViewCell.h"

@interface MEVoiceListOfContainsTableViewCell ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView * collectionView;
@end

@implementation MEVoiceListOfContainsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        if (self) {
            
            [self addSubview:self.titleLabel];
            self.titleLabel.font = [UIFont systemFontOfSize:12];
            [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self).with.offset(0);
                make.left.equalTo(self).with.offset(5);
            }];
            
            //创建一个layout布局类
            UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
            //设置布局方向为垂直流布局
            layout.scrollDirection = UICollectionViewScrollDirectionVertical;
            //创建collectionView 通过一个布局策略layout来创建
            self.collectionView = [[UICollectionView alloc]initWithFrame:self.frame collectionViewLayout:layout];
            [self addSubview:self.collectionView];
            self.collectionView.dataSource = self;
            self.collectionView.delegate = self;
            self.collectionView.backgroundColor = [UIColor clearColor];//ME_Color(250, 250, 250);
            self.collectionView.scrollEnabled = NO;
            [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.titleLabel.mas_bottom).with.offset(5);
                make.left.equalTo(self);
                make.right.equalTo(self);
                make.bottom.equalTo(self);
                
            }];
            [self.collectionView registerClass:[MEVoiceListCollectionViewCell class] forCellWithReuseIdentifier:@"VoiceList"];
            [self.collectionView registerClass:[MEHotMVoiceCollectionViewCell class] forCellWithReuseIdentifier:@"HotMVoice"];
        }
    }
    return self;
}

- (void)setRow:(NSInteger)row
{
    _row = row;
    if (row == 2) {
        self.titleLabel.text = @"包含该音频的音单：";
    } else {
        self.titleLabel.text = @"相似音频：";

    }
}

#pragma mark -
#pragma mark - collectionView
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.array.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.row == 2) {
        MEVoiceListCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"VoiceList" forIndexPath:indexPath];
        cell.dic = self.array[indexPath.row];//@{@"themes_image":@"心灵的旋律", @"title":@"【节奏纯音】心灵的旋律", @"voice_count":@"34"};//self.array[indexPath.row];
        
        return cell;
    } else {
        MEHotMVoiceCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HotMVoice" forIndexPath:indexPath];
        cell.dic = self.array[indexPath.row];//@{@"themes_image":@"hotMVoice_downRight", @"title":@"【3D】刀剑乱舞 花丸-心魂の在処", @"played_count":@"3924", @"words_count":@"13"};
        
        return cell;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

//定义每个Item 的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(ME_Width / 3, 165);
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
