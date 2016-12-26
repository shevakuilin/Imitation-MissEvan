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
#import "MESearchView.h"
#import "MEBaseViewController.h"

@interface MEHomeViewController ()<MEPageControl_AutoScrollDelegate, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) MEBaseViewController * voiceListView;
@property (nonatomic, strong) MEBaseViewController * recommendView;
@property (nonatomic, strong) MEBaseViewController * classifyView;

@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) UICollectionView * collectionView;
@property (nonatomic, strong) UITableView * voiceTableView;
@property (nonatomic, strong) MESearchView * searchView;

//@property (nonatomic, strong) UIButton * rightBarButton;

@end

@implementation MEHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.voiceListView = [[MEBaseViewController alloc] init];
    self.voiceListView.title = @"音单";
    
    self.recommendView = [[MEBaseViewController alloc] init];
    self.recommendView.title = @"推荐";
    
    self.classifyView = [[MEBaseViewController alloc] init];
    self.classifyView.title = @"分类";
    self.viewControllers = @[self.voiceListView, self.recommendView, self.classifyView];
    
//    self.rightBarButton = [MEUtil barButtonItemWithImage:@"v3player_0002_25x25_" target:self action:@selector(goMusicView) isLeft:NO isRight:YES];
//    UIButton * leftBarButton = [MEUtil barButtonItemWithImage:@"hp3_icon_search_24x22_" target:self action:@selector(goSearchView) isLeft:YES isRight:NO];
    
//    [self.segmentControl addSubview:self.rightBarButton];
//    [self.segmentControl addSubview:self.leftBarButton];
    self.segmentControl.rightBarButton.frame = CGRectMake(ME_Width - 40, 3, 40, 40);
    [self.segmentControl.rightBarButton addTarget:self action:@selector(goMusicView) forControlEvents:UIControlEventTouchUpInside];
    self.segmentControl.leftBarButton.frame = CGRectMake(0, 3, 40, 40);
    [self.segmentControl.leftBarButton addTarget:self action:@selector(goSearchView) forControlEvents:UIControlEventTouchUpInside];
    
    [self customRecommendView];
    [self customClassifyView];
    [self customVoiceListView];
    [self addSearchView];
    
    //获取通知中心单例对象
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    //添加当前类对象为一个观察者，name和object设置为nil，表示接收一切通知
    [center addObserver:self selector:@selector(notice:) name:@"play" object:nil];
}

- (void)notice:(id)sender
{
    MELog(@"Music图标接到通知:%@", sender);
    //如果进入播放界面，那么根据播放状态决定动画播放状态
    BOOL isPlay = [[sender userInfo][@"isPlay"] boolValue];
    if (isPlay == YES) {
        MELog(@"正在播放, Music动画开始执行");
        NSMutableArray * stackImageArray = [NSMutableArray new];
        for (NSInteger i = 1; i < 97; i ++) {
            NSString * stackImageName;
            if (i < 10) {
                stackImageName = [NSString stringWithFormat:@"v3player_000%@_25x25_", @(i)];
            } else {
                stackImageName = [NSString stringWithFormat:@"v3player_00%@_25x25_", @(i)];
            }
            UIImage * imageName = [UIImage imageNamed:stackImageName];
            [stackImageArray addObject:imageName];
            MELog(@"Music动画开始执行第%@张图片", @(i - 1));
            self.segmentControl.rightBarButton.imageView.animationImages = stackImageArray;
            //动画重复次数
            self.segmentControl.rightBarButton.imageView.animationRepeatCount = 10000000 * 10000000;
            //动画执行时间,多长时间执行完动画
            self.segmentControl.rightBarButton.imageView.animationDuration = 7;
            //开始动画
            [self.segmentControl.rightBarButton.imageView startAnimating];
        }

    } else {
        MELog(@"播放暂停");
        [self.segmentControl.rightBarButton.imageView stopAnimating];
    }
}

//为了方便暂时留着
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    self.navigationController.navigationBarHidden = YES;
    if (self.tableView) {
        [self.tableView reloadData];
    }
    if (self.collectionView) {
        [self.collectionView reloadData];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    self.navigationController.navigationBarHidden = NO;
}

- (void)customRecommendView
{
    //TODO:推荐界面
    UIScrollView * backgroundScroll = [UIScrollView new];//[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ME_Width, ME_Height)];
    backgroundScroll.backgroundColor = [UIColor clearColor];
    [self.recommendView.view addSubview:backgroundScroll];
    [backgroundScroll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.recommendView.view).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    /*
     ** PageControl & AutoScroll
     */
    MEPageControl_AutoScroll * view = [[MEPageControl_AutoScroll alloc]initWithFrame:CGRectMake(0, 0, ME_Width, 145)];
    NSMutableArray * pageImageArray = [[NSMutableArray alloc] init];
//    for (NSInteger i = 1; i < 5; i ++) {
//        UIImageView * imageView = [UIImageView new];
//        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"page%@", @(i)]];
//        [pageImageArray addObject:imageView];
//    }
    for (NSInteger i = 0; i < 4; i ++) {
        UIImageView * bannerImageView = [UIImageView new];
        [bannerImageView setImageWithURL:[NSURL URLWithString:ME_DATASOURCE.bannerArray[i][@"image"]] placeholderImage:[UIImage imageNamed:@""]];
        [pageImageArray addObject:bannerImageView];
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
    self.tableView.backgroundColor = [UIColor clearColor];//ME_Color(250, 250, 250);
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
    UIScrollView * backgroundScroll = [UIScrollView new];//[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ME_Width, ME_Height)];
//    backgroundScroll.backgroundColor = ME_Color(243, 243, 243);
    [self.voiceListView.view addSubview:backgroundScroll];
    [backgroundScroll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.voiceListView.view).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    self.voiceTableView = [UITableView new];
    self.voiceTableView.backgroundColor = [UIColor clearColor];//ME_Color(243, 243, 243);
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
//    view.backgroundColor = ME_Color(243, 243, 243);
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
    self.collectionView.backgroundColor = [UIColor clearColor];//ME_Color(243, 243, 243);
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(view).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
        
    }];
    [self.collectionView registerClass:[MEClassifyCollectionViewCell class] forCellWithReuseIdentifier:@"Classify"];
}

- (void)goMusicView
{
    //TODO:播放界面
    UIViewController * danmaku = ME_GetViewController(@"danmaku", @"MEDanmaku");
    [self.navigationController pushViewController:danmaku animated:YES];
}

- (void)addSearchView
{
    //TODO:加载搜索界面
    self.searchView = [[MESearchView alloc] initWithFrame:CGRectMake(0, 0, ME_Width, ME_Height)];
    [self.view addSubview:self.searchView];
    self.searchView.hidden = YES;
}

- (void)goSearchView
{
    //TODO:搜索界面
    self.searchView.hidden = NO;
    [self.searchView.searchTextFiled becomeFirstResponder];
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
        } else {
            return 2;
        }
    } else {
        return 2;
    }
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.tableView) {
        if (indexPath.section == 0) {
            MEHomeRecommendTopTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"HomeRecommendTop"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if ([[EAThemeManager shareManager].currentThemeIdentifier isEqualToString:EAThemeNormal]) {
                cell.array = ME_DATASOURCE.homeTopArray;
            } else {
                cell.array = ME_DATASOURCE.homeTopNightArray;
            }
            
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
                if ([[EAThemeManager shareManager].currentThemeIdentifier isEqualToString:EAThemeNormal]) {
                    cell.dic = ME_DATASOURCE.topCellArray[indexPath.section - 1];
                } else {
                    cell.dic = ME_DATASOURCE.topCellNightArray[indexPath.section - 1];
                }
                if (indexPath.section == 4 || indexPath.section == 5) {
                    cell.moreButton.hidden = YES;
                } else {
                    cell.moreButton.hidden = NO;
                }
                
                return cell;
                
            } else if (indexPath.row == 1){
                if (indexPath.section == 1) {
                    MEHotMVoiceTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"HotMVoice"];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.array = ME_DATASOURCE.recommendCellArray;
                    
                    return cell;
                    
                } else if (indexPath.section == 2){
                    MEChannelTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Channel"];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.array = ME_DATASOURCE.channelCellArray;
                    
                    
                    return cell;
                } else if (indexPath.section == 3){
                    MEVoiceListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"VoiceList"];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.array = ME_DATASOURCE.voiceListArray;
                    
                    return cell;
                } else if (indexPath.section == 4){
                    MEBellsTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Bells"];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    if ([[EAThemeManager shareManager].currentThemeIdentifier isEqualToString:EAThemeNormal]) {
                        cell.array = ME_DATASOURCE.bellArray;
                    } else {
                        cell.array = ME_DATASOURCE.bellNightArray;
                    }
                    
                    return cell;
                } else if (indexPath.section == 5){
                    MEAkiraTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Akira"];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    
                    return cell;
                } else {
                    MEHotMVoiceTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"HotMVoice"];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.array = ME_DATASOURCE.radioArray;
                    
                    return cell;
                }
                
            } else {
                if (indexPath.section == 1) {
                    MEHotMVoiceTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"HotMVoice"];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.array = ME_DATASOURCE.recommendCellArray;
                    
                    return cell;
                    
                }  else if (indexPath.section == 2){
                    MEChannelTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Channel"];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.array = ME_DATASOURCE.channelCellArray;
                    
                    return cell;
                } else {
                    MEVoiceListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"VoiceList"];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.array = ME_DATASOURCE.voiceListArray;
                    
                    return cell;
                }
            }
        }

    } else {
        if (indexPath.row == 0) {
            MEHomeRecommendMoreTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"HomeRecommendMore"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//            cell.backgroundColor = ME_Color(243, 243, 243);
            MELog(@"section == %@", @(indexPath.section));
            cell.dic = ME_DATASOURCE.voiceListTitle[indexPath.section];
            cell.classifyLabel.font = [UIFont systemFontOfSize:14];
//            cell.topShadow.hidden = YES;
            
            return cell;
            
        } else {
            MEVoiceListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"VoiceList"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.array = ME_DATASOURCE.voiceListArray;
//            cell.collectionView.backgroundColor = ME_Color(243, 243, 243);
            
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
                return 310;
            } else if (indexPath.section == 3) {
                return 330;
            } else if (indexPath.section == 4) {
                return 80;
            } else if (indexPath.section == 5) {
                return 108;
            } else {
                if (indexPath.section < 6) {
                    return 352;
                }
//                if (indexPath.row == 1 && indexPath.section < 6) {
//                    return 181;
//                }
                return 171;
            }
            
        }
    } else {
        if (indexPath.row == 0) {
            return 40;
        } else{
            return 330;
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
    sectionView.backgroundColor = self.recommendView.view.backgroundColor;//ME_Color(250, 250, 250);
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
//    cell.picUrl = ME_DATASOURCE.classiftPic[indexPath.row];
//    cell.title = ME_DATASOURCE.classiftTitle[indexPath.row];
    if ([[EAThemeManager shareManager].currentThemeIdentifier isEqualToString:EAThemeNormal]) {
        cell.dic = ME_DATASOURCE.classiftPic[indexPath.row];
    } else {
        cell.dic = ME_DATASOURCE.classiftNightPic[indexPath.row];
    }

    
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
