
//
//  YuLuCell.m
//  LoveLife
//
//  Created by 小破夕 on 15/12/31.
//  Copyright © 2015年 xiaopoxi. All rights reserved.
//

#import "YuLuCell.h"

@implementation YuLuCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    /*
     //    时间
     UILabel *_pub_time;
     //    用户头像
     UIImageView *_headerImageView;
     //    大图
     UIImageView *bigImageView;
     //    用户名
     UILabel *_publisher_name;
     //    文字
     UILabel *_text;
     */
    
    
    //头像
    _headerImageView = [FactoryUI createImageViewWithFrame:CGRectMake(10, 10, 55, 55) imageName:nil];
    [self.contentView addSubview:_headerImageView];
    _headerImageView.layer.cornerRadius = _headerImageView.frame.size.width / 2;
    _headerImageView.layer.masksToBounds = YES;
    
    //用户名
    _publisher_name = [FactoryUI createLabelWithFrame:CGRectMake(_headerImageView.frame.size.width + 10, 10, 150, 55) text:nil textColor:[UIColor darkGrayColor] font:[UIFont systemFontOfSize:18]];
    _publisher_name.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:_publisher_name];
    
    
    //时间
    _pub_time = [FactoryUI createLabelWithFrame:CGRectMake(SCREEN_W - 20 - 130, 40, 130, 15) text:nil textColor:[UIColor redColor] font:[UIFont systemFontOfSize:18]];
    _pub_time.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:_publisher_name];
    
    //大图
    _bigImageView = [FactoryUI createImageViewWithFrame:CGRectMake(10, _headerImageView.frame.size.height+10, SCREEN_W - 20,200) imageName:@""];
    [self.contentView addSubview:_bigImageView];
    
    //文字
    _text = [[UILabel alloc]init];
    _text.textColor = [UIColor darkGrayColor];
    _text.font = [UIFont systemFontOfSize:17];
    _text.numberOfLines = 0;
    _text.lineBreakMode = NSLineBreakByWordWrapping;
    [self.contentView addSubview:_text];
    
    
    
    
    
}

-(void)refreshUI:(YuLuModel *)model{
    
    
    
    
    
    [_headerImageView sd_setImageWithURL:[NSURL URLWithString:model.publisher_icon_url] placeholderImage:[UIImage imageNamed:@"special_palcehold"]];
    _publisher_name.text = model.publisher_name;
    _pub_time.text = model.pub_time;
    [_bigImageView sd_setImageWithURL:[NSURL URLWithString:model.image_url] placeholderImage:[UIImage imageNamed:@"special_palcehold"]];
    
    
    
    //计算wenzi内容的大小
    CGSize contentSize = [model.text boundingRectWithSize:CGSizeMake(SCREEN_W - 20, 1000) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    _text.frame = CGRectMake(10, _bigImageView.frame.size.height + _bigImageView.frame.origin.y + 10, SCREEN_W - 20, contentSize.height + 20);
    _text.text = model.text;
    
    self.cellHeight = CGRectGetHeight(_text.frame) + 330 + 10;

    
    
    
    
    
    
}

@end









