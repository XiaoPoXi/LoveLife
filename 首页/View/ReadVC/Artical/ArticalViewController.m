//
//  ArticalViewController.m
//  LoveLife
//
//  Created by 小破夕 on 15/12/30.
//  Copyright © 2015年 xiaopoxi. All rights reserved.
//

#import "ArticalViewController.h"
#import "ReadModel.h"
#import "ArticalCell.h"
#import "ArticalDetailViewController.h"

@interface ArticalViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView * _tableView;
    int _page;
    
}

@property(nonatomic,strong) NSMutableArray *dataArray;

@end

@implementation ArticalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [[UIColor alloc]initWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
    
    [self createTableView];
    

    [self createRefresh];
}

-(void)createRefresh{
    
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    _tableView.footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    [_tableView.header beginRefreshing];
    
}
//下拉
-(void)loadNewData{
    _page = 0;
    self.dataArray = [NSMutableArray arrayWithCapacity:0];
    [self getData];
}
//上啦
-(void)loadMoreData{
    _page++;
    [self getData];

}

-(void)getData{
    AFHTTPRequestOperationManager * manger = [AFHTTPRequestOperationManager manager];
    //手动设置数据格式
    manger.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    
    
    [manger GET:[NSString stringWithFormat:ARTICALURL , _page ] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSArray *array = responseObject[@"data"];
        for (NSDictionary *dic in array) {
            ReadModel *model = [[ReadModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [self.dataArray addObject:model];
        }
        //kai开启新的线程刷新数据 、、、、、、、、
//        [self performSelector:@selector(lal)];
        [self performSelectorOnMainThread:@selector(lal) withObject:nil waitUntilDone:YES];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}
-(void)lal{
    if (_page == 0) {
        [_tableView.header endRefreshing];
    }else{
        [_tableView.footer endRefreshing];
    }
    
    [_tableView reloadData];
}
-(void)createTableView{
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}


#pragma mark - 协议代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    ArticalCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        cell = [[ArticalCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    if (self.dataArray) {
        ReadModel * model = self.dataArray[indexPath.row];
        [cell refresh:model];
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ArticalDetailViewController * vc = [[ArticalDetailViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    
    ReadModel * model = self.dataArray[indexPath.row];
    vc.model =model;
    
    [self.navigationController pushViewController:vc animated:YES];

}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    //设置动画
    
    cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1);
    [UIView animateWithDuration:0.5 animations:^{
        cell.layer.transform = CATransform3DMakeScale(1, 1, 1);
    }];
    
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
