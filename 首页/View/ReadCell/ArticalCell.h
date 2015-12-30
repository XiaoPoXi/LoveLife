//
//  ArticalCell.h
//  LoveLife
//
//  Created by 小破夕 on 15/12/30.
//  Copyright © 2015年 xiaopoxi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReadModel.h"
@interface ArticalCell : UITableViewCell
{
    UIImageView *_imageView;
    UILabel *_timeLabel;
    UILabel *_authorLabel;
    UILabel *_titleLabel;
}

-(void)refresh:(ReadModel *)model;


@end
