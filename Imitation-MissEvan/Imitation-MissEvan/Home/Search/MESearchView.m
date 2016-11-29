//
//  MESearchView.m
//  Imitation-MissEvan
//
//  Created by huiren on 18/11/28.
//  Copyright © 2018年 xkl. All rights reserved.
//

#import "MESearchView.h"
#import "MEHeader.h"
#import "MEHotSearchCollectionViewCell.h"
#import "MESearchHistoryTableViewCell.h"

@interface MESearchView ()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UIButton * cancelButton;
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) UICollectionView * collectionView;

@end

@implementation MESearchView

- (instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        if (self) {
            self.backgroundColor = ME_Color(243, 243, 243);
            
            UIView * navigationView = [UIView new];
            [self addSubview:navigationView];
            navigationView.backgroundColor = [UIColor whiteColor];
            [navigationView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self).with.offset(0);
                make.left.equalTo(self).with.offset(0);
                make.right.equalTo(self).with.offset(0);
                
                make.size.mas_equalTo(CGSizeMake(ME_Width, 64));
            }];
            
            self.cancelButton = [UIButton new];
            [navigationView addSubview:self.cancelButton];
            [self.cancelButton setTitle:@"取消" forState:UIControlStateNormal];
            [self.cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            self.cancelButton.titleLabel.font = [UIFont systemFontOfSize:14];
            [self.cancelButton addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
            [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(navigationView).with.offset(10);
                make.right.equalTo(navigationView).with.offset(-8);
                
                make.size.mas_equalTo(CGSizeMake(34, 45));
            }];
            
            UIView * searchView = [UIView new];
            [navigationView addSubview:searchView];
            searchView.backgroundColor = ME_Color(250, 250, 250);
            searchView.layer.masksToBounds = YES;
            searchView.layer.cornerRadius = 5;
            [searchView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.cancelButton).with.offset(0);
                make.left.equalTo(navigationView).with.offset(8);
                make.right.equalTo(self.cancelButton.mas_left).with.offset(-8);
                
                make.size.mas_equalTo(CGSizeMake(ME_Width - 34, 30));
            }];
            
            UIImageView * searchIcon = [UIImageView new];
            [searchView addSubview:searchIcon];
            searchIcon.image = [UIImage imageNamed:@"hp_search_20x18_"];
            [searchIcon mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(searchView).with.offset(0);
                make.left.equalTo(searchView).with.offset(8);
            }];
            
            self.searchTextFiled = [UITextField new];
            [searchView addSubview:self.searchTextFiled];
            self.searchTextFiled.font = [UIFont systemFontOfSize:13];
            self.searchTextFiled.placeholder = @"这里搜什么就显示什么";
            self.searchTextFiled.tintColor = [UIColor blackColor];
            self.searchTextFiled.returnKeyType = UIReturnKeySearch;
            self.searchTextFiled.delegate = self;
//            [self.searchTextFiled becomeFirstResponder];
            [self.searchTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(searchIcon.mas_right).with.offset(8);
                make.right.equalTo(searchView).with.offset(0);
                make.centerY.equalTo(searchView).with.offset(0);
            }];
            
            UIView * hotSearchView = [UIView new];
            [self addSubview:hotSearchView];
            hotSearchView.backgroundColor = ME_Color(243, 243, 243);
            [hotSearchView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(navigationView.mas_bottom).with.offset(0);
                make.left.equalTo(self).with.offset(0);
                make.right.equalTo(self).with.offset(0);
                
                make.size.mas_equalTo(CGSizeMake(ME_Width, 55));
            }];
            
            UILabel * hotSearchLabel = [UILabel new];
            [hotSearchView addSubview:hotSearchLabel];
            hotSearchLabel.font = [UIFont systemFontOfSize:14];
            hotSearchLabel.text = @"热门搜索";
            [hotSearchLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(hotSearchView).with.offset(0);
                make.left.equalTo(hotSearchView).with.offset(16);
            }];
            
            UIImageView * hotLine = [UIImageView new];
            [hotSearchView addSubview:hotLine];
            hotLine.backgroundColor = ME_Color(189, 189, 189);
            [hotLine mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(hotSearchView).with.offset(10);
                make.right.equalTo(hotSearchView).with.offset(0);
                make.bottom.equalTo(hotSearchView).with.offset(-8);
                
                make.size.mas_equalTo(CGSizeMake(ME_Width - 10, 1));
            }];
            
            //创建一个layout布局类
//            UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
            UICollectionViewLeftAlignedLayout * layout = [[UICollectionViewLeftAlignedLayout alloc] init];
            //设置布局方向为垂直流布局
            layout.scrollDirection = UICollectionViewScrollDirectionVertical;
            //创建collectionView 通过一个布局策略layout来创建
            self.collectionView = [[UICollectionView alloc]initWithFrame:self.frame collectionViewLayout:layout];
            [self addSubview:self.collectionView];
            self.collectionView.dataSource = self;
            self.collectionView.delegate = self;
            self.collectionView.backgroundColor = ME_Color(243, 243, 243);
            self.collectionView.scrollEnabled = NO;
            [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(hotSearchView.mas_bottom).with.offset(30);
                make.left.equalTo(self).with.offset(20);
                make.right.equalTo(self).with.offset(-20);
                
                make.size.mas_equalTo(CGSizeMake(ME_Width - 40, 130));
                
            }];
            [self.collectionView registerClass:[MEHotSearchCollectionViewCell class] forCellWithReuseIdentifier:@"HotSearch"];
            
            
            UIView * historySearchView = [UIView new];
            [self addSubview:historySearchView];
            historySearchView.backgroundColor = ME_Color(243, 243, 243);
            [historySearchView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.collectionView.mas_bottom).with.offset(0);
                make.left.equalTo(self).with.offset(0);
                make.right.equalTo(self).with.offset(0);
                
                make.size.mas_equalTo(CGSizeMake(ME_Width, 55));
            }];
            
            UILabel * historySearchLabel = [UILabel new];
            [historySearchView addSubview:historySearchLabel];
            historySearchLabel.font = [UIFont systemFontOfSize:14];
            historySearchLabel.text = @"历史搜索";
            [historySearchLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(historySearchView).with.offset(0);
                make.left.equalTo(historySearchView).with.offset(16);
            }];
            
            UIButton * cleanButton = [UIButton new];
            [historySearchView addSubview:cleanButton];
            [cleanButton setImage:[UIImage imageNamed:@"hp_clear_16x16_"] forState:UIControlStateNormal];
            [cleanButton addTarget:self action:@selector(cleanSearchWords) forControlEvents:UIControlEventTouchUpInside];
            [cleanButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(historySearchView).with.offset(-16);
                make.centerY.equalTo(historySearchView).with.offset(0);
            }];
            
            UIImageView * historyLine = [UIImageView new];
            [historySearchView addSubview:historyLine];
            historyLine.backgroundColor = ME_Color(189, 189, 189);
            [historyLine mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(historySearchView).with.offset(10);
                make.right.equalTo(historySearchView).with.offset(0);
                make.bottom.equalTo(historySearchView).with.offset(-8);
                
                make.size.mas_equalTo(CGSizeMake(ME_Width - 10, 1));
            }];
            
            self.tableView = [UITableView new];
            [self addSubview:self.tableView];
            self.tableView.backgroundColor = ME_Color(243, 243, 243);
            [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(historySearchView.mas_bottom).with.offset(0);
                make.left.equalTo(self).with.offset(0);
                make.right.equalTo(self).with.offset(0);
                make.bottom.equalTo(self).with.offset(0);
            }];
            self.tableView.delegate = self;
            self.tableView.dataSource = self;
            self.tableView.tableFooterView = [[UIView alloc] init];
            self.tableView.separatorStyle = NO;
            [self.tableView registerClass:[MESearchHistoryTableViewCell class] forCellReuseIdentifier:@"SearchHistory"];
            
            
        }
    }
    return self;
}

- (void)cancel
{
    //TODO:取消
//    [self removeFromSuperview];
    self.hidden = YES;
    [self endEditing:YES];
}

- (void)cleanSearchWords
{
    //TODO:清空历史记录
    
}

#pragma mark - 
#pragma mark - UITextFiledDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (self.searchTextFiled.text.length == 0) {
//        [self removeFromSuperview];
        self.hidden = YES;
        [self endEditing:YES];
    } else {
        [self.searchTextFiled resignFirstResponder];
    }
    return YES;
}

#pragma mark -
#pragma mark - collectionView
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return ME_DATASOURCE.hotWordsArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MEHotSearchCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HotSearch" forIndexPath:indexPath];
    cell.dic = ME_DATASOURCE.hotWordsArray[indexPath.row];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

//定义每个Item 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * hotwords = ME_DATASOURCE.hotWordsArray[indexPath.row][@"hotwords"];
    NSInteger length = 0;
    
    for (NSInteger i = 0; i< hotwords.length; i++) {
        char commitChar = [hotwords characterAtIndex:i];
        NSString * temp = [hotwords substringWithRange:NSMakeRange(i, 1)];
        const char * u8Temp = [temp UTF8String];
        if (3 == strlen(u8Temp)){
            MELog(@"搜索热词为中文");
            if (hotwords.length < 2) {
                length = 30;
            } else {
                length = hotwords.length * 18;
            }
        } else if((commitChar > 64) && (commitChar < 91)){
            MELog(@"搜索热词为大写英文字母");
            length = hotwords.length * 12;
        } else {
            MELog(@"搜索热词为小写英文字母");
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

//- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
//{
//    NSArray * attributes = [super layoutAttributesForElementsInRect:rect];
//    
//    return attributes;
//    
//}

//定义每个UICollectionView 的 margin
//-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
//{
//    return UIEdgeInsetsMake(30, 0, 30, 0);
//}

#pragma mark -
#pragma mark - UITableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MESearchHistoryTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SearchHistory"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}


@end
