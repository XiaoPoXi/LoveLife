//
//  ArticalDetailViewController.m
//  LoveLife
//
//  Created by 小破夕 on 15/12/30.
//  Copyright © 2015年 xiaopoxi. All rights reserved.
//

#import "ArticalDetailViewController.h"

@interface ArticalDetailViewController ()

@end

@implementation ArticalDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self settingNav];
    [self createUI];
    // Do any additional setup after loading the view.
}

-(void)createUI{
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:ARTICALDETAILURL,self.model.dataID]]]];
    //使webView适应屏幕大小的方法
    webView.scalesPageToFit = YES;
    
    [self.view addSubview:webView];
    
}


-(void)settingNav{
    
    self.titleLabel.text = @"🈚️";
    [self.leftButton setImage:[UIImage imageNamed:@"qrcode_scan_titlebar_back_pressed@2x.png"] forState:UIControlStateNormal];
    [self setleftButtonClick:@selector(click)];
    
    [self.rightButton setImage:[UIImage imageNamed:@"iconfont-fenxiang"] forState:UIControlStateNormal];
    [self setrightButtonClick:@selector(rightButtonclick)];

}

-(void)click{
    [self.navigationController popViewControllerAnimated:YES];
}
//分享
-(void)rightButtonclick{
    
    UIImage * image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.model.pic]]];
    
    
    [UMSocialSnsService presentSnsIconSheetView:self appKey:APPKEY shareText:[NSString stringWithFormat:ARTICALDETAILURL,self.model.dataID] shareImage:image shareToSnsNames:@[UMShareToQQ,UMShareToQzone,UMShareToWechatSession,UMShareToLWTimeline,UMShareToSina] delegate:nil];
    
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
