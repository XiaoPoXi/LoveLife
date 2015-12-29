//
//  MyTabBarViewController.m
//  LoveLife
//
//  Created by 小破夕 on 15/12/29.
//  Copyright © 2015年 xiaopoxi. All rights reserved.
//

#import "MyTabBarViewController.h"
#import "HomeViewController.h"
#import "FoodViewController.h"
#import "MusicViewController.h"
#import "ReadViewController.h"
#import "MyViewController.h"



@interface MyTabBarViewController ()

@end

@implementation MyTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createViewControllerd];
    
    [self createTabBarItem];
    
    
}

-(void)createTabBarItem{
    
    //未选中的图片
    NSArray *unselectedImageArray = @[@"ic_tab_home_normal@2x.png",@"ic_tab_select_normal@2x.png",@"iconfont-iconfontmeishi.png",@"iconfont-yule.png",@"ic_tab_profile_normal_female@2x.png"];
    //选中的图片
    NSArray *selectedImageArray = @[@"ic_tab_home_selected@2x.png",@"ic_tab_select_selected@2x.png",@"iconfont-iconfontmeishi-2.png",@"iconfont-yule-2.png",@"ic_tab_profile_selected_female@2x.png"];
    //标题
    NSArray *titleArray = @[@"首页",@"阅读",@"美食",@"音乐",@"我的"];

    
//    NSArray *titleArray = @[@"首页",@"阅读",@"美食",@"音乐",@"我的"];
    
    
    for (int i = 0; i<self.tabBar.items.count; i++) {
        //self.tabBar.items.count
        UIImage *unselectedImage = [UIImage imageNamed:unselectedImageArray[i]];
        unselectedImage = [unselectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        UIImage *selectedImage = [UIImage imageNamed:selectedImageArray[i]];
        selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        
        UITabBarItem *item = self.tabBar.items[i];
        item = [item initWithTitle:titleArray[i] image:unselectedImage selectedImage:selectedImage];
        
        [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} forState:UIControlStateSelected];
        

    }
    
    
    
}




-(void)createViewControllerd{
    HomeViewController *homeVC = [[HomeViewController alloc] init];
    UINavigationController *homeNaVC = [[UINavigationController alloc] initWithRootViewController:homeVC];
    
    ReadViewController * readVC  = [[ReadViewController alloc] init];
    UINavigationController *readNaVC = [[UINavigationController alloc] initWithRootViewController:readVC];
    
    FoodViewController * foodVC = [[FoodViewController alloc ] init];
    UINavigationController *foodNAVC = [[UINavigationController alloc] initWithRootViewController:foodVC];
    
    MusicViewController *musicVC = [[MusicViewController alloc] init];
    UINavigationController * musicNAVC = [[UINavigationController alloc] initWithRootViewController:musicVC];
    
    MyViewController *myVC = [[MyViewController alloc] init];
    UINavigationController *myNAVC = [[UINavigationController alloc] initWithRootViewController:myVC];
    
    /**
     *  添加到view
     */
    
    
    self.viewControllers = @[homeNaVC,readNaVC,foodNAVC,musicNAVC,myNAVC];
    
    
    
    
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
