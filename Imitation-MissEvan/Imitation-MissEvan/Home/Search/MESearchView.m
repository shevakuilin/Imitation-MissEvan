//
//  MESearchView.m
//  Imitation-MissEvan
//
//  Created by huiren on 18/11/28.
//  Copyright © 2018年 xkl. All rights reserved.
//

#import "MESearchView.h"
#import "MEHeader.h"

@interface MESearchView ()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UITextField * searchTextFiled;
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
                make.top.equalTo(self).with.offset(20);
                make.left.equalTo(self).with.offset(0);
                make.right.equalTo(self).with.offset(0);
                
                make.size.mas_equalTo(CGSizeMake(ME_Width, 45));
            }];
            
            self.cancelButton = [UIButton new];
            [navigationView addSubview:self.cancelButton];
            [self.cancelButton setTitle:@"取消" forState:UIControlStateNormal];
            [self.cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            self.cancelButton.titleLabel.font = [UIFont systemFontOfSize:14];
            [self.cancelButton addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
            [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(navigationView).with.offset(0);
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
            [self.searchTextFiled becomeFirstResponder];
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
                
                make.size.mas_equalTo(CGSizeMake(ME_Width, 45));
            }];
            
            UILabel * hotSearchLabel = [UILabel new];
            [hotSearchView addSubview:hotSearchLabel];
            hotSearchLabel.font = [UIFont systemFontOfSize:14];
            hotSearchLabel.text = @"热门搜索";
            [hotSearchLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(hotSearchView).with.offset(0);
                make.left.equalTo(hotSearchView).with.offset(16);
            }];
            
            UIImageView * hotImageView = [UIImageView new];
            [hotSearchView addSubview:hotImageView];
            hotImageView.backgroundColor = [UIColor lightGrayColor];
            [hotImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(hotSearchView).with.offset(10);
                make.right.equalTo(hotSearchView).with.offset(0);
                make.bottom.equalTo(hotSearchView).with.offset(0);
                
                make.size.mas_equalTo(CGSizeMake(ME_Width - 10, 1));
            }];
            
            self.tableView = [UITableView new];
            [self addSubview:self.tableView];
            self.tableView.backgroundColor = ME_Color(243, 243, 243);
            [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(hotSearchView.mas_bottom).with.offset(0);
                make.left.equalTo(self).with.offset(0);
                make.right.equalTo(self).with.offset(0);
                make.bottom.equalTo(self).with.offset(0);
            }];
            
            
        }
    }
    return self;
}

- (void)cancel
{
    //TODO:取消
    [self removeFromSuperview];
}

#pragma mark - 
#pragma mark - UITextFiledDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (self.searchTextFiled.text.length == 0) {
        [self removeFromSuperview];
    } else {
        [self.searchTextFiled resignFirstResponder];
    }
    return YES;
}

@end
