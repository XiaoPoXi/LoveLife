//
//  RootViewController.m
//  LoveLife
//
//  Created by 小破夕 on 15/12/29.
//  Copyright © 2015年 xiaopoxi. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createRoot];
    
    self.view.backgroundColor = [UIColor whiteColor];
    

}

-(void)createRoot{
    
    /**
     *  设置导航栏不透明
     */
    
    self.navigationController.navigationBar.translucent = NO;
    /**
     *  设置导航栏颜色
     */
    self.navigationController.navigationBar.barTintColor = RGB(255, 156, 187, 1);
    //左按钮
    self.leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.leftButton.frame = CGRectMake(0, 0, 44, 44);
    
    [self.leftButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.leftButton];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 25)];
    self.titleLabel.tintColor = [UIColor whiteColor];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont systemFontOfSize:20];
    self.navigationItem.titleView = self.titleLabel;
    
    
    self.rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightButton.frame = CGRectMake(0, 0, 44, 44);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightButton];


    
    
    /**
     *
     *
     *修改状态栏的颜色
     */
    
//    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
}

//tian添加响应事件
-(void) setleftButtonClick:(SEL)selector;{
    
    [self.leftButton addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    
}
-(void) setrightButtonClick:(SEL)selector;{
    
    [self.rightButton addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];

}




@end






















