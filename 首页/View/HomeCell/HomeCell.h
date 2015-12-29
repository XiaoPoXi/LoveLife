//
//  HomeCell.h
//  LoveLife
//
//  Created by 小破夕 on 15/12/29.
//  Copyright © 2015年 xiaopoxi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeModel.h"

@interface HomeCell : UITableViewCell
{
    UIImageView * _imageView;
    
    UILabel * _titleLabel;
}


-(void)RefreshUI:(HomeModel *)model;

@end
