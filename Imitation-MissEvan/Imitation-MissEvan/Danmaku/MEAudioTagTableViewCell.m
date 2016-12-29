//
//  MEAudioTagTableViewCell.m
//  Imitation-MissEvan
//
//  Created by huiren on 16/12/29.
//  Copyright © 2016年 xkl. All rights reserved.
//

#import "MEAudioTagTableViewCell.h"
#import "MEHeader.h"
#import "MEHotSearchCollectionViewCell.h"

@interface MEAudioTagTableViewCell ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView * collectionView;

@end

@implementation MEAudioTagTableViewCell

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
            
            [self addSubview:self.leftShadow];
            [self.leftShadow mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self).with.offset(5);
                make.left.equalTo(self).with.offset(5);
                
                make.size.mas_equalTo(CGSizeMake(3, 10));
            }];
            
            [self addSubview:self.audioTagLabel];
            self.audioTagLabel.font = [UIFont systemFontOfSize:12];
            self.audioTagLabel.text = @"音频标签";
            [self.audioTagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.leftShadow);
                make.left.equalTo(self.leftShadow.mas_right).with.offset(5);
            }];
            
            //创建一个layout布局类
            UICollectionViewLeftAlignedLayout * layout = [[UICollectionViewLeftAlignedLayout alloc] init];
            //设置布局方向为垂直流布局
            layout.scrollDirection = UICollectionViewScrollDirectionVertical;
            //创建collectionView 通过一个布局策略layout来创建
            self.collectionView = [[UICollectionView alloc]initWithFrame:self.frame collectionViewLayout:layout];
            [self addSubview:self.collectionView];
            self.collectionView.dataSource = self;
            self.collectionView.delegate = self;
            self.collectionView.backgroundColor = [UIColor clearColor];//ME_Color(243, 243, 243);
            self.collectionView.scrollEnabled = NO;
            [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.audioTagLabel.mas_bottom).with.offset(5);
                make.left.equalTo(self).with.offset(5);
                make.right.equalTo(self).with.offset(-5);
                make.bottom.equalTo(self);
                
            }];
            [self.collectionView registerClass:[MEHotSearchCollectionViewCell class] forCellWithReuseIdentifier:@"HotSearch"];

        }
    }
    return self;
}

#pragma mark -
#pragma mark - collectionView
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MEHotSearchCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HotSearch" forIndexPath:indexPath];
    cell.dic = @{@"hotwords":@"少年霜"};
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

//定义每个Item 的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * hotwords = @"少年霜";//ME_DATASOURCE.hotWordsArray[indexPath.row][@"hotwords"];
    NSInteger length = 0;
    
    for (NSInteger i = 0; i< hotwords.length; i++) {
        char commitChar = [hotwords characterAtIndex:i];
        NSString * temp = [hotwords substringWithRange:NSMakeRange(i, 1)];
        const char * u8Temp = [temp UTF8String];
        if (3 == strlen(u8Temp)){
            MELog(@"音频标签为中文");
            if (hotwords.length < 2) {
                length = 30;
            } else {
                length = hotwords.length * 18;
            }
        } else if((commitChar > 64) && (commitChar < 91)){
            MELog(@"音频标签为大写英文字母");
            length = hotwords.length * 12;
        } else {
            MELog(@"音频标签为小写英文字母");
            if (hotwords.length < 4) {
                length = 35;
            } else {
                length = hotwords.length * 9;
            }
        }
    }
    
    return CGSizeMake(length + 8, 30);
}

//item横向间距
- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout
minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 13;
}

//item纵向间距
- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout
minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}
@end
