//
//  HomeViewController.m
//  LoveLife
//
//  Created by 小破夕 on 15/12/29.
//  Copyright © 2015年 xiaopoxi. All rights reserved.
//

#import "HomeViewController.h"
//抽屉
#import "UIViewController+MMDrawerController.h"
//er二维码
#import "CustomViewController.h"
//广告轮播
#import "Carousel.h"

#import "HomeModel.h"
#import "HomeCell.h"
#import "HomeDetailViewController.h"

@interface HomeViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    Carousel * _carousel;
    
    UITableView *_tableView;
    
    int _page;//分页
    
}

@property(nonatomic,strong) NSMutableArray * dataArray;


@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self settingNav];
    [self createTableHeaderView];

    [self createTableView];
    
    [self createRefresh];
    // Do any additional setup after loading the view.
}

-(void)createRefresh{
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(LoadNewData)];
    
    _tableView.footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(LoadMoreData)];
    
    //当程序第一次启动的时候自动刷新一次
    [_tableView.header beginRefreshing];
}

//下拉刷新
-(void)LoadNewData{
    
    _page = 1;
    
    self.dataArray = [NSMutableArray arrayWithCapacity:0];
    
    [self getData];
    
}

//上拉加载
-(void)LoadMoreData{
    
    _page++;
    
    [self getData];
}

-(void)getData{
    AFHTTPRequestOperationManager * manger = [AFHTTPRequestOperationManager manager];
    [manger GET:[NSString stringWithFormat:HOMEURL,_page] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        for (NSDictionary * dic  in responseObject[@"data"][@"topic"]) {
            HomeModel * model = [[HomeModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];

            [self.dataArray addObject:model];
        }
        
        if (_page == 1) {
            [_tableView.header endRefreshing];
        }else{
            [_tableView.footer endRefreshing];
        }
        [_tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
    
}


- (void)createTableView{
    
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H-49) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [self.view addSubview:_tableView];
    
    
    //分割线
    _tableView.separatorColor = [UIColor clearColor];
    
//    _tableView.separatorStyle = uitableview
    
    _tableView.tableHeaderView = _carousel;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

{
    HomeCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        cell = [[HomeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
//    赋值
    if (self.dataArray) {
        HomeModel *model = self.dataArray[indexPath.row];
        [cell RefreshUI:model];
    }
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 190;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HomeDetailViewController * vc = [[HomeDetailViewController alloc] init];
    //正向传值-----》到详情页
    HomeModel *model = self.dataArray[indexPath.row];
    vc.dataI = model.dataID;
    
    
    
    //tabbar的隐藏
    vc.hidesBottomBarWhenPushed = YES;
    
    
    
    
    
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 创建tableview头视图

-(void)createTableHeaderView{
    
    _carousel = [[Carousel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H / 3)];
    
    _carousel.needPageControl = YES;
    
    _carousel.infiniteLoop = YES;
    
    _carousel.pageControlPositionType = PAGE_CONTROL_POSITION_TYPE_MIDDLE;
    
    _carousel.imageArray = @[@"shili8",@"shili2",@"shili10",@"shili13"];
    
}




//- (UIButton *)rightButton{
//    CustomViewController *vc= [[CustomViewController alloc] initWithIsQRCode:NO Block:^(NSString * result, BOOL isSucceed) {
//        // no 代表条形码二维码都可以扫描
//        if (isSucceed) {
//            NSLog(@"%@",result);
//        }
//        
//    }];
//    
//    [self presentViewController:vc animated:YES completion:nil];
//}

#pragma mark --- 设置导航
-(void)settingNav{
    
    self.titleLabel.text = @"爱";
    [self.leftButton setImage:[UIImage imageNamed:@"icon_function.png"] forState:UIControlStateNormal];
    [self.rightButton setImage:[UIImage imageNamed:@"2vm.png"] forState:UIControlStateNormal];
    //    设置响应事件
    [self setleftButtonClick:@selector(leftBtnClick)];
    [self setrightButtonClick:@selector(rightBtnClick)];
    
}

#pragma mark --- 按钮的响应事件
-(void)leftBtnClick{
    
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}
#pragma mark --- 实现二维码
-(void)rightBtnClick{
    //    BOOL代表是否关闭二维码扫描，专门扫描条形码
    CustomViewController* customVC =[[CustomViewController alloc]initWithIsQRCode:NO Block:^(NSString *result, BOOL isFinish) {
        if (isFinish) {
            NSLog(@"最后的结果%@",result);
        }
        
    }];
    
    [self presentViewController:customVC animated:YES completion:nil];
    
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
