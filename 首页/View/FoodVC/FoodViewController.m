//
//  FoodViewController.m
//  LoveLife
//
//  Created by 小破夕 on 15/12/29.
//  Copyright © 2015年 xiaopoxi. All rights reserved.
//

#import "FoodViewController.h"
#import "NBWaterFlowLayout.h"

#import "FoodCollectionViewCell.h"
#import "FoodTitleCollectionViewCell.h"
#import "FoodModel.h"

//视频播放
#import <MediaPlayer/MediaPlayer.h>
#import "PlayViewController.h"

//ios9以后视频播放
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>


#import "FoodDetailViewController.h"

@interface FoodViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateWaterFlowLayout,playDelegate>
{
    UICollectionView *_collectionView;
    
    //定义一个分类ID
    NSString * _categoryID;
    //标题
    NSString *_titleString;
    //指示条
    UIView *_lineView;
    
    int _page;
}


@property(nonatomic,strong) NSMutableArray *dataArray;

@property(nonatomic,strong) NSMutableArray *buttonArray;


@end

@implementation FoodViewController



-(void)viewWillAppear:(BOOL)animated{
    for (UIButton *btn in self.buttonArray) {
        //判断是是第一个按钮
        if (btn == [self.buttonArray firstObject]) {
            btn.selected = YES;
            
        }
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];

    [self initData];
    
    [self settingNav];

    [self createHeaderView];
    
    [self createCollectionView];
    
    [self createRefresh];
}
#pragma mark -刷新~~
-(void)createRefresh{
    _collectionView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    _collectionView.footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    [_collectionView.header beginRefreshing];
}

-(void)loadNewData{
    
    _page = 0;
    _dataArray = [NSMutableArray arrayWithCapacity:0];

    [self getData];
    
    
}

-(void)loadMoreData{
    
    _page ++;
    
    [self getData];
}
#pragma mark - 下载数据
-(void)getData{
    
    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    //参数拼接：
    NSDictionary * dic = @{@"methodName": @"HomeSerial", @"page": [NSString stringWithFormat:@"%d",_page], @"serial_id": _categoryID, @"size": @"20"};
    
    [manger POST:FOODURL parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject[@"code"] intValue] == 0) {
          //解析数据
            for (NSDictionary *dic in responseObject[@"data"][@"data"]) {
                //字典转模型
                
                
                FoodModel *model = [[FoodModel alloc] init];
                [model setValuesForKeysWithDictionary:dic];
                [self.dataArray addObject:model];
                
            }
            
            
        }
        if (_page == 0) {
            [_collectionView.header endRefreshing];
        }else{
            [_collectionView.footer endRefreshing];
        }
        
        [_collectionView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
    
}

#pragma mark - 创建collectionView
-(void)createCollectionView{
    //创建网格布局对象
    NBWaterFlowLayout *flowLayout = [[NBWaterFlowLayout alloc] init];
    
    //网格大小
    flowLayout.itemSize = CGSizeMake((SCREEN_W - 20)/2, 180);
    
    //设置列数
    flowLayout.numberOfColumns = 2;
    
    //设置代理
    flowLayout.delegate = self;
    
    //创建网格对象
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 45, SCREEN_W, SCREEN_H - 40) collectionViewLayout:flowLayout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:_collectionView];
    
    
    //注册cell------------>
    
    [_collectionView registerClass:[FoodCollectionViewCell class] forCellWithReuseIdentifier:@"food"];
    [_collectionView registerClass:[FoodTitleCollectionViewCell class] forCellWithReuseIdentifier:@"foodTitle"];
    
    
}
#pragma mark - daili代理方法

//确定个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
   
    return self.dataArray ? self.dataArray.count +1 : 0;
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        //标题
        FoodTitleCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"foodTitle" forIndexPath:indexPath];
        //赋值
        cell.titleLabel.text = _titleString;
        return cell ;
        
    }
    else{
        //正文
        FoodCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"food" forIndexPath:indexPath];
        
        //设置代理
        cell.delegate = self;        

        //赋值
//        cell.backgroundColor = [UIColor redColor];
        if (self.dataArray) {
            FoodModel *model = self.dataArray[indexPath.row-1];
            [cell refreshUI:model];
        }
        
        return cell;
    }
}
//设置高度
-(CGFloat)collectionView:(UICollectionView *)collectionView waterFlowLayout:(NBWaterFlowLayout *)layout heightForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 30  ;
    }
    else{
        return 180;
    }
}

//点击传值
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //    NSLog(@"我被点击了");
    
    FoodDetailViewController * detailVC =[[FoodDetailViewController alloc]init];
    
    //传值
    FoodModel * model = self.dataArray[indexPath.row];
    detailVC.dataId = model.dishes_id;
    detailVC.NavTitle = model.title;
    detailVC.videoUrl = model.video;
    detailVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailVC animated:YES];
}



#pragma mark - shixain实现自定义的代理

-(void)play:(FoodModel *)model{

    //进行视频播放
    //默认播放
    //    MPMoviePlayerViewController  *playVC=[[MPMoviePlayerViewController alloc]initWithContentURL:[NSURL URLWithString:model.video]];
    //强制横屏播放
    PlayViewController *playVC=[[PlayViewController alloc]initWithContentURL:[NSURL URLWithString:model.video]];
    //准备播放
    [playVC.moviePlayer prepareToPlay];
    //开始播放
    [playVC.moviePlayer play];
    //页面跳转
    [self presentMoviePlayerViewControllerAnimated:playVC];
    
    //ios 9 以后的播放设置
//    AVPlayerViewController *vc = [[AVPlayerViewController alloc] init];
//    AVPlayer *avPlayer = [AVPlayer playerWithURL:[NSURL URLWithString:model.video]];
//    vc.player =avPlayer;
//    [self presentViewController:vc animated:YES completion:nil];
    
    
}



#pragma mark - 头部的分类按钮
-(void)createHeaderView{
    NSArray *titleArray = @[@"家常菜",@"小炒",@"凉菜",@"烘焙"];
    UIView *bgView = [FactoryUI createViewWithFrame:CGRectMake(0, 0, SCREEN_W, 40) ];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgView];
    
    for (int i = 0 ; i<titleArray.count; i++) {
        UIButton *headerButton = [FactoryUI createButtonWithFrame:CGRectMake(i * SCREEN_W / 4 , 0, SCREEN_W / 4, 40) title:titleArray[i] titleColor:[UIColor darkGrayColor] imageName:nil backgroundImageName:nil target:self selector:@selector(headerButtonClick:)];
        
        //设置选中时的颜色
        [headerButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        
        headerButton.titleLabel.font = [UIFont systemFontOfSize:15];
        headerButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        headerButton.tag = 10+i;
        [bgView addSubview:headerButton];
        
        //将创建的button添加到数组
        [self.buttonArray addObject:headerButton];
        
    }
    _lineView = [FactoryUI createViewWithFrame:CGRectMake(0, 38, SCREEN_W / 4, 2)];
    _lineView.backgroundColor = [UIColor redColor];
    [bgView addSubview:_lineView];
    
}
#pragma mark - xiang响应，点击小标题，数据会改变，通过传值_categoryID的改以及button的tag值。

-(void)headerButtonClick:(UIButton *)button
{
    [UIView animateWithDuration:0.3 animations:^{
        _lineView.frame = CGRectMake((button.tag - 10) * SCREEN_W / 4, 38, SCREEN_W / 4, 2);
    }];
    
    //设置每次只选中一个按钮
    for (UIButton * btn in self.buttonArray) {
        if (btn.selected == YES) {
            btn.selected = NO;
        }
    }
    button.selected = YES;
    
    //改变标题和id
    _categoryID = [NSString stringWithFormat:@"%ld",(button.tag - 10) + 1];
    switch (button.tag - 10) {
        case 0:
        {
            _titleString = @"家常菜";
            [_collectionView.header beginRefreshing];
        }
            break;
        case 1:
        {
            _titleString = @"小炒";
            [_collectionView.header beginRefreshing];
        }
            break;
        case 2:
        {
            _titleString = @"凉菜";
            [_collectionView.header beginRefreshing];
        }
            break;
        case 3:
        {
            _titleString = @"烘培";
            [_collectionView.header beginRefreshing];
        }
            break;
            
        default:
            break;
    }
    
    //刷新界面
    [_collectionView reloadData];
}

#pragma mark - 标题
-(void)settingNav{
    self.titleLabel.text = @"美食";
}

#pragma mark -数据初始化

-(void)initData{
    _categoryID = @"1";
    _titleString = @"家常菜";
    _buttonArray = [NSMutableArray arrayWithCapacity:0];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
