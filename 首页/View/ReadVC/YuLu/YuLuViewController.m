//
//  YuLuViewController.m
//  LoveLife
//
//  Created by 小破夕 on 15/12/30.
//  Copyright © 2015年 xiaopoxi. All rights reserved.
//

#import "YuLuViewController.h"

#import "YuLuCell.h"


@interface YuLuViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    
    UITableView *_tableView;
    NSMutableArray *_dataArray;
    
    int _page;
    //不定高cell的高度
    float cellHeight;
}
@end

@implementation YuLuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self  initData];
    
    [self createUI];
    
    [self createRefresh];
    
}
-(void)initData{
    _dataArray = [NSMutableArray arrayWithCapacity:0];
}
-(void)createRefresh{
    
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    _tableView.footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    [_tableView.header beginRefreshing];
    
}

-(void)loadNewData{
    _page = 0;
    [self getData];
}

-(void)loadMoreData{
    _page ++;
    [self getData];
}
-(void)getData{
    
    AFHTTPRequestOperationManager * manger = [AFHTTPRequestOperationManager manager];
    manger.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",nil];

    [manger GET:[NSString stringWithFormat:UTTERANCEURL,_page] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSMutableArray * contentArray = [NSMutableArray arrayWithArray:responseObject[@"content"]];
        [contentArray removeObjectAtIndex:0];
        
        for (NSDictionary * dic in contentArray)
        {
            YuLuModel * model = [[YuLuModel alloc]init];
            model.pub_time = dic[@"pub_time"];
            model.publisher_icon_url = dic[@"publisher_icon_url"];
            model.publisher_name = dic[@"publisher_name"];
            model.text = dic[@"text"];
            model.image_url = dic[@"image_urls"][0][@"middle"];
            [_dataArray addObject:model];
        }
        
        if (_page == 0)
        {
            [_tableView.header endRefreshing];
        }
        else
        {
            [_tableView.footer endRefreshing];
        }
        
        [_tableView reloadData];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
}




-(void)createUI{
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    
}
#pragma mark - 协议代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;


{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    YuLuCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        cell = [[YuLuCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    YuLuModel * model = _dataArray[indexPath.row];
    [cell refreshUI:model];
    
    cellHeight = cell.cellHeight;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return cellHeight;
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
