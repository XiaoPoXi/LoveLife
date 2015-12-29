//
//  AppDelegate.m
//  LoveLife
//
//  Created by 小破夕 on 15/12/29.
//  Copyright © 2015年 xiaopoxi. All rights reserved.
//

#import "AppDelegate.h"
#import "MyTabBarViewController.h"
#import "GuidePageView.h"
#import "MMDrawerController.h"//添加抽提

#import "LeftViewController.h"

@interface AppDelegate ()

@property (nonatomic, strong)MyTabBarViewController *myTabBar;
@property (nonatomic, strong)GuidePageView *guidePageView;


@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    _myTabBar = [[MyTabBarViewController alloc] init];
//    self.window.rootViewController = _myTabBar;
    
    //添加引导页
    [self createGuidePage];
    //修改状态栏的颜色@2   改全局的
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    
    LeftViewController *leftVC = [[LeftViewController alloc] init];
    MMDrawerController *drawerVC = [[MMDrawerController alloc] initWithCenterViewController:_myTabBar leftDrawerViewController:leftVC];
    //设置抽屉打开和关闭模式
    drawerVC.openDrawerGestureModeMask = MMOpenDrawerGestureModeAll;
    drawerVC.closeDrawerGestureModeMask = MMCloseDrawerGestureModeAll;
    
    //设置左页面打开之后的高度
    drawerVC.maximumLeftDrawerWidth = SCREEN_W - 200;
    self.window.rootViewController = drawerVC;
    
    
    
    return YES;
}

- (void)createGuidePage
{
    if (![[[NSUserDefaults standardUserDefaults] objectForKey:@"isRuned"] boolValue]) {
        
        NSArray *imageArray = @[@"welcome1.png",@"welcome2.png",@"welcome3.png"];
        self.guidePageView = [[GuidePageView alloc] initWithFrame:self.window.bounds ImageArray:imageArray];
        [self.myTabBar.view addSubview:self.guidePageView];
        //第一次运行完成之后进行记录
        [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"isRuned"];
    }
    [self.guidePageView.Button addTarget:self action:@selector(goinButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)goinButtonClick{
    [self.guidePageView removeFromSuperview];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
