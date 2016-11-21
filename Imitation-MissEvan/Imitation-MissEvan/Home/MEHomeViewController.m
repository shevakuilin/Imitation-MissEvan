//
//  MEHomeViewController.m
//  Imitation-MissEvan
//
//  Created by huiren on 16/10/24.
//  Copyright © 2016年 xkl. All rights reserved.
//

#import "MEHomeViewController.h"
#import "MEHeader.h"
#import "MEHomeRecommendTopTableViewCell.h"
#import "MEHomeRecommendMoreTableViewCell.h"
#import "MEHotMVoiceTableViewCell.h"
#import "MEChannelTableViewCell.h"
#import "MEVoiceListTableViewCell.h"
#import "MEAkiraTableViewCell.h"
#import "MECustomColumnTableViewCell.h"
#import "MEBellsTableViewCell.h"
#import "MEClassifyCollectionViewCell.h"

@interface MEHomeViewController ()<MEPageControl_AutoScrollDelegate, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UIViewController * voiceListView;
@property (nonatomic, strong) UIViewController * recommendView;
@property (nonatomic, strong) UIViewController * classifyView;

@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) UICollectionView * collectionView;
@property (nonatomic, strong) UITableView * voiceTableView;

@end

@implementation MEHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;
    
    self.voiceListView = [[UIViewController alloc] init];
    self.voiceListView.title = @"音单";
    
    self.recommendView = [[UIViewController alloc] init];
    self.recommendView.title = @"推荐";
    
    self.classifyView = [[UIViewController alloc] init];
    self.classifyView.title = @"分类";
    self.viewControllers = @[self.voiceListView, self.recommendView, self.classifyView];
    
    UIButton * rightBarButton = [MEUtil barButtonItemWithImage:@"v3player_0001_24x24_" target:self action:@selector(goMusicView) isLeft:NO isRight:YES];
    UIButton * leftBarButton = [MEUtil barButtonItemWithImage:@"hp3_icon_search_24x22_" target:self action:@selector(goSearchView) isLeft:YES isRight:NO];
    
    [self.segmentControl addSubview:rightBarButton];
    [self.segmentControl addSubview:leftBarButton];
    
    [self customRecommendView];
    [self customClassifyView];
    [self customVoiceListView];
}

- (void)customRecommendView
{
    //TODO:推荐界面
    UIScrollView * backgroundScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ME_Width, ME_Height)];
    backgroundScroll.backgroundColor = [UIColor clearColor];
    [self.recommendView.view addSubview:backgroundScroll];
    [backgroundScroll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.recommendView.view).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
//    UIView * backgroundView = [UIView new];
//    [backgroundScroll addSubview:backgroundView];
//    backgroundView.backgroundColor = [UIColor orangeColor];
//    [backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(backgroundScroll).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
//        
//        make.size.mas_equalTo(CGSizeMake(backgroundScroll.bounds.size.width, backgroundScroll.bounds.size.height));
//    }];
    
    /*
     ** PageControl & AutoScroll
     */
    MEPageControl_AutoScroll * view = [[MEPageControl_AutoScroll alloc]initWithFrame:CGRectMake(0, 0, ME_Width, 145)];
    NSMutableArray * pageImageArray = [[NSMutableArray alloc] init];
    for (NSInteger i = 1; i < 5; i ++) {
        UIImageView * imageView = [UIImageView new];
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"page%@", @(i)]];
        [pageImageArray addObject:imageView];
    }
    view.autoScrollDelayTime = 5.0;
    view.delegate = self;
    [view setViewsArray:pageImageArray];
    [backgroundScroll addSubview:view];
    [view shouldAutoShow:YES];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backgroundScroll).with.offset(0);
        make.left.equalTo(backgroundScroll).with.offset(0);
        make.right.equalTo(backgroundScroll).with.offset(0);
        
        make.size.mas_equalTo(CGSizeMake(ME_Width, 145));
    }];
    
    
    self.tableView = [UITableView new];
    self.tableView.backgroundColor = ME_Color(250, 250, 250);
    [backgroundScroll addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backgroundScroll).with.offset(145);
        make.left.equalTo(backgroundScroll).with.offset(0);
        make.right.equalTo(backgroundScroll).with.offset(0);
        make.bottom.equalTo(backgroundScroll).with.offset(0);
        
        make.size.mas_equalTo(CGSizeMake(ME_Width, 1864));
    }];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.separatorStyle = NO;
    self.tableView.scrollEnabled = NO;
    
    [self.tableView registerClass:[MEHomeRecommendTopTableViewCell class] forCellReuseIdentifier:@"HomeRecommendTop"];
    [self.tableView registerClass:[MEHomeRecommendMoreTableViewCell class] forCellReuseIdentifier:@"HomeRecommendMore"];
    [self.tableView registerClass:[MEHotMVoiceTableViewCell class] forCellReuseIdentifier:@"HotMVoice"];
    [self.tableView registerClass:[MEChannelTableViewCell class] forCellReuseIdentifier:@"Channel"];
    [self.tableView registerClass:[MEVoiceListTableViewCell class] forCellReuseIdentifier:@"VoiceList"];
    [self.tableView registerClass:[MEBellsTableViewCell class] forCellReuseIdentifier:@"Bells"];
    [self.tableView registerClass:[MEAkiraTableViewCell class] forCellReuseIdentifier:@"Akira"];
    [self.tableView registerClass:[MECustomColumnTableViewCell class] forCellReuseIdentifier:@"CustomColumn"];
}

- (void)customVoiceListView
{
    //TODO:音单界面
    UIScrollView * backgroundScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ME_Width, ME_Height)];
    backgroundScroll.backgroundColor = ME_Color(243, 243, 243);
    [self.voiceListView.view addSubview:backgroundScroll];
    [backgroundScroll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.voiceListView.view).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    self.voiceTableView = [UITableView new];
    self.voiceTableView.backgroundColor = ME_Color(243, 243, 243);
    [backgroundScroll addSubview:self.voiceTableView];
    [self.voiceTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(backgroundScroll).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));

        make.size.mas_equalTo(CGSizeMake(ME_Width, 2284));
    }];
    self.voiceTableView.delegate = self;
    self.voiceTableView.dataSource = self;
    self.voiceTableView.separatorStyle = NO;
    self.voiceTableView.scrollEnabled = NO;
    self.voiceTableView.tableFooterView = [[UIView alloc] init];
    [self.voiceTableView registerClass:[MEHomeRecommendMoreTableViewCell class] forCellReuseIdentifier:@"HomeRecommendMore"];
    [self.voiceTableView registerClass:[MEVoiceListTableViewCell class] forCellReuseIdentifier:@"VoiceList"];
}

- (void)customClassifyView
{
    //TODO:分类界面
    UIView * view = [UIView new];
    [self.classifyView.view addSubview:view];
    view.backgroundColor = ME_Color(243, 243, 243);
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.classifyView.view).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    //创建一个layout布局类
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    //设置布局方向为垂直流布局
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    //创建collectionView 通过一个布局策略layout来创建
    self.collectionView = [[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:layout];
    [view addSubview:self.collectionView];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.backgroundColor = ME_Color(243, 243, 243);
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(view).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
        
    }];
    [self.collectionView registerClass:[MEClassifyCollectionViewCell class] forCellWithReuseIdentifier:@"Classify"];
}

- (void)goMusicView
{
    //TODO:播放界面
}

- (void)goSearchView
{
    //TODO:搜索界面
}

#pragma mark -
#pragma mark - tableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == self.tableView) {
        return 8;
    } else {
        return 6;
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.tableView) {
        if (section == 0 || section == 7) {
            return 1;
        } else if (section == 1 || section == 2 || section == 3){
            return 3;
        } else {
            return 2;
        }
    } else {
        return 3;
    }
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.tableView) {
        if (indexPath.section == 0) {
            MEHomeRecommendTopTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"HomeRecommendTop"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.dic = ME_DATASOURCE.homeTopImageDic;
            
            return cell;
            
        } else if (indexPath.section == 7) {
            MECustomColumnTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CustomColumn"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
            
        } else {
            if (indexPath.row == 0) {
                MEHomeRecommendMoreTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"HomeRecommendMore"];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                MELog(@"section == %@", @(indexPath.section));
                cell.dic = ME_DATASOURCE.topCellArray[indexPath.section - 1];
                if (indexPath.section == 4 || indexPath.section == 5) {
                    cell.moreButton.hidden = YES;
                    cell.downShadow.hidden = NO;
                } else {
                    cell.moreButton.hidden = NO;
                    cell.downShadow.hidden = YES;
                }
                
                return cell;
                
            } else if (indexPath.row == 1){
                if (indexPath.section == 1) {
                    MEHotMVoiceTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"HotMVoice"];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.array = ME_DATASOURCE.recommendCellArray[indexPath.row - 1];
                    cell.downShadow.hidden = YES;
                    
                    return cell;
                    
                } else if (indexPath.section == 2){
                    MEChannelTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Channel"];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.array = ME_DATASOURCE.channelCellArray[indexPath.row - 1];
                    if (indexPath.row == 1) {
                        cell.downShadow.hidden = YES;
                    } else {
                        cell.downShadow.hidden = NO;
                    }
                    
                    
                    return cell;
                } else if (indexPath.section == 3){
                    MEVoiceListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"VoiceList"];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.array = ME_DATASOURCE.voiceListArray[indexPath.row - 1];
                    if (indexPath.row == 1) {
                        cell.downShadow.hidden = YES;
                    } else {
                        cell.downShadow.hidden = NO;
                    }
                    
                    return cell;
                } else if (indexPath.section == 4){
                    MEBellsTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Bells"];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.dic = ME_DATASOURCE.bellDic;
                    cell.topShadow.hidden = YES;
                    
                    return cell;
                } else if (indexPath.section == 5){
                    MEAkiraTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Akira"];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.dic = ME_DATASOURCE.akiraDic;
                    cell.topShadow.hidden = YES;
                    
                    return cell;
                } else {
                    MEHotMVoiceTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"HotMVoice"];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.array = ME_DATASOURCE.radioArray[indexPath.row - 1];
                    cell.downShadow.hidden = NO;
                    
                    return cell;
                }
                
            } else {
                if (indexPath.section == 1) {
                    MEHotMVoiceTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"HotMVoice"];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.array = ME_DATASOURCE.recommendCellArray[indexPath.row - 1];
                    
                    return cell;
                    
                }  else if (indexPath.section == 2){
                    MEChannelTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Channel"];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.array = ME_DATASOURCE.channelCellArray[indexPath.row - 1];
                    
                    return cell;
                } else {
                    MEVoiceListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"VoiceList"];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.array = ME_DATASOURCE.voiceListArray[indexPath.row - 1];
                    if (indexPath.row == 1) {
                        cell.downShadow.hidden = YES;
                    } else {
                        cell.downShadow.hidden = NO;
                    }
                    
                    return cell;
                }
            }
        }

    } else {
        if (indexPath.row == 0) {
            MEHomeRecommendMoreTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"HomeRecommendMore"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = ME_Color(243, 243, 243);
            MELog(@"section == %@", @(indexPath.section));
            cell.dic = ME_DATASOURCE.voiceListTitle[indexPath.section];
            cell.downShadow.hidden = YES;
            cell.topShadow.hidden = YES;
            
            return cell;
            
        } else {
            MEVoiceListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"VoiceList"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.array = ME_DATASOURCE.voiceListArray[indexPath.row - 1];
            cell.backgroundColor = ME_Color(243, 243, 243);
            cell.downShadow.hidden = YES;
            
            return cell;
        }
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.tableView) {
        if (indexPath.row == 0) {
            if (indexPath.section == 0) {
                return 70;
            } else {
                return 40;//380;
            }
        } else {
            if (indexPath.section == 2) {
                return 155;
            } else if (indexPath.section == 3) {
                return 165;
            } else if (indexPath.section == 4) {
                return 80;
            } else if (indexPath.section == 5) {
                return 108;
            } else {
                if (indexPath.row == 1 && indexPath.section < 6) {
                    return 181;
                }
                return 171;
            }
            
        }
    } else {
        if (indexPath.row == 0) {
            return 40;
        } else{
            return 165;
        }
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView == self.tableView) {
        if (section > 0) {
            return 10;
        } else {
            return 0;
        }
    } else {
        return 0;
    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * sectionView = [UIView new];
    sectionView.backgroundColor = ME_Color(250, 250, 250);
    return sectionView;
}


#pragma mark -
#pragma mark - collectionView
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 12;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MEClassifyCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Classify" forIndexPath:indexPath];
    cell.picUrl = ME_DATASOURCE.classiftPic[indexPath.row];
    cell.title = ME_DATASOURCE.classiftTitle[indexPath.row];

    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

//定义每个Item 的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((ME_Width - 12) / 3, (ME_Width - 12) / 3);
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
    return 8;
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(8, 5, 30, 5);
}


@end
