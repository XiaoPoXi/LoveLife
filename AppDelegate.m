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
//分享
//qq weixin weibo
#import "UMSocialQQHandler.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialSinaHandler.h"




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
    
    
    //添加友盟
    [self addUM];
    
    
    
    
    return YES;
}

-(void)addUM{
    
    //注册友盟
//    APPKEY @"566cf4ebe0f55a23e5007be9"
//    
//    QQ: appid:1104908293
//    appkey:MnGtpPN5AiB6MNvj
//    
//    weixin:appid:wx12b249bcbf753e87
//    app secret:0a9cd00c48ee47a9b23119086bcd3b30
    [UMSocialData setAppKey:APPKEY];
    //she设置qq的APPID APPKEY url
    [UMSocialQQHandler setQQWithAppId:@"1104908293" appKey:@"MnGtpPN5AiB6MNvj" url:@"http://www.apple.com"];
    //微信的设置
    [UMSocialWechatHandler setWXAppId:@"wx12b249bcbf753e87" appSecret:@"0a9cd00c48ee47a9b23119086bcd3b30" url:@"http://www.apple.com"];
    //打开微博的SSO开关
    [UMSocialSinaHandler openSSOWithRedirectURL:@"http://www.apple.com"];
    
    //隐藏未安装的客户端  --- 针对于腾讯小贱人
    [UMSocialConfig hiddenNotInstallPlatforms:@[UMShareToQQ,UMShareToQzone,UMShareToWechatSession,UMShareToLWTimeline]];
    
    
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
