//
//  YuLuCell.h
//  LoveLife
//
//  Created by 小破夕 on 15/12/31.
//  Copyright © 2015年 xiaopoxi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YuLuModel.h"


@interface YuLuCell : UITableViewCell

{
//    时间
    UILabel *_pub_time;
//    用户头像
    UIImageView *_headerImageView;
//    大图
    UIImageView *_bigImageView;
//    用户名
    UILabel *_publisher_name;
//    文字
    UILabel *_text;
}

//获取cell的高度
@property(nonatomic,assign) CGFloat cellHeight;


-(void)refreshUI:(YuLuModel *)model;

@end
