//
//  FoodDetailViewController.h
//  LoveLife
//
//  Created by 小破夕 on 16/1/4.
//  Copyright © 2016年 xiaopoxi. All rights reserved.
//

#import "RootViewController.h"

@interface FoodDetailViewController : RootViewController

//id
@property(nonatomic,copy) NSString * dataId;
//菜名
@property(nonatomic,copy) NSString * NavTitle;
//视频url
@property(nonatomic,strong) NSString * videoUrl;


@end
