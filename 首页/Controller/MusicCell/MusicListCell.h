//
//  MusicListCell.h
//  LoveLife
//
//  Created by 小破夕 on 16/1/4.
//  Copyright © 2016年 xiaopoxi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MusicModel.h"
@interface MusicListCell : UITableViewCell
{

    UIImageView *_imageView;
    UILabel *_authorLabel;
    UILabel *_nameLabel;
}

-(void)refreshUI:(MusicModel *)model;

@end
