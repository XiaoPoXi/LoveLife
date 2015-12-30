//
//  ReadViewController.m
//  LoveLife
//
//  Created by 小破夕 on 15/12/29.
//  Copyright © 2015年 xiaopoxi. All rights reserved.
//

#import "ReadViewController.h"

@interface ReadViewController ()<UIScrollViewDelegate>
{
    UIScrollView *_scrollView;
    UISegmentedControl *_segmentedControl;
    
}
@end

@implementation ReadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self settingNav];
    
    [self createUI];
}
#pragma mark -创建UI
-(void)createUI{
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H)];
    //设置分页
    _scrollView.pagingEnabled= YES;
    _scrollView.delegate = self;
    [self.view addSubview:_scrollView];
    //设置contentsize
    _scrollView.contentSize = CGSizeMake(SCREEN_W * 2,0);
    //隐藏指示条
    _scrollView.showsHorizontalScrollIndicator = NO;
//    _scrollView.showsVerticalScrollIndicator = YES;
    
    //实例化子控制器
    
    ArticalViewController *articalVC = [[ArticalViewController alloc] init];
    YuLuViewController * yuluVC = [[YuLuViewController alloc] init];
    //将控制器放入数组管理
    NSArray *VCArray = @[articalVC,yuluVC];
    
    //滚动ing式框架的实现
    int i = 0;
    for (UIViewController * vc in VCArray) {
        vc.view.frame = CGRectMake(i * SCREEN_W, 0, SCREEN_W, SCREEN_H);
        
        [self addChildViewController:vc];
        [_scrollView addSubview:vc.view];
        i++;
        
    }
    
    
}
#pragma mark - scrollview 关联segment  实现这个代理
- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
{
    _segmentedControl.selectedSegmentIndex = scrollView.contentOffset.x / SCREEN_W ;
    
}


#pragma mark - 标题
-(void)settingNav{
    
    _segmentedControl = [[UISegmentedControl alloc] initWithFrame:CGRectMake(0, 0, 100, 26)];
    //插入标题
    [_segmentedControl insertSegmentWithTitle:@"美文" atIndex:0 animated:YES];
    [_segmentedControl insertSegmentWithTitle:@"语录" atIndex:1 animated:YES];
    //shezhi设置字体颜色
    _segmentedControl.tintColor = [UIColor whiteColor];
    //背景颜色
//    _segmentedControl.backgroundColor
    
    //设置默认选中第一个标题
    _segmentedControl.selectedSegmentIndex = 0;
    
    //添加响应方法
    [_segmentedControl addTarget:self action:@selector(changeOption:) forControlEvents:UIControlEventValueChanged];
    
    self.navigationItem.titleView = _segmentedControl;
    
    
}

//响应方法
-(void)changeOption:(UISegmentedControl *)segment{
    
//    if (segment.selectedSegmentIndex == 1) {
//        _scrollView.contentOffset = CGPointMake(SCREEN_W, 0);
//        
//    }else{
//        _scrollView.contentOffset = CGPointMake(0, 0);
//
//    }
    
    _scrollView.contentOffset = CGPointMake(segment.selectedSegmentIndex * SCREEN_W, 0);
    
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
