//
//  FoodCollectionViewCell.m
//  LoveLife
//
//  Created by 小破夕 on 15/12/31.
//  Copyright © 2015年 xiaopoxi. All rights reserved.
//

#import "FoodCollectionViewCell.h"

@interface FoodCollectionViewCell()

@property (nonatomic,strong) FoodModel *foodModel;

@end

@implementation FoodCollectionViewCell





-(instancetype)initWithFrame:(CGRect)frame{
    if (self  = [super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}
-(void)createUI{
    
    _imageView = [FactoryUI createImageViewWithFrame:CGRectMake(20, 20, (SCREEN_W - 40)/2, 130) imageName:nil];
    _imageView.userInteractionEnabled = YES;
    [self.contentView addSubview:_imageView];
    
    _titleLabel = [FactoryUI createLabelWithFrame:CGRectMake(10, _imageView.frame.size.height + _imageView.frame.origin.y +5, _imageView.frame.size.width, 20) text:nil textColor:[UIColor darkGrayColor] font:[UIFont systemFontOfSize:15]];
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:_titleLabel];
    
    
    _desLabel = [FactoryUI createLabelWithFrame:CGRectMake(_titleLabel.frame.origin.x , _titleLabel.frame.origin.y + _titleLabel.frame.size.height, _titleLabel.frame.size.width, 20) text:nil textColor:[UIColor darkGrayColor] font:[UIFont systemFontOfSize:12]];
    [self.contentView addSubview:_desLabel];
    
    //创建播放按钮
    UIButton *playButton = [FactoryUI createButtonWithFrame:CGRectMake(0, 0, 40, 40) title:nil titleColor:nil imageName:@"iconfont-bofang" backgroundImageName:nil target:self selector:@selector(play)];
    [_imageView addSubview:playButton];
    playButton.center = _imageView.center;
    
    
    
    
    
}
//播放
-(void)play{
    /**
     *  respondsToSelector 判断有没有这个方法
     */
    if ([_delegate respondsToSelector:@selector(play:)]) {
        [_delegate play:_foodModel];
    }
    
    
}

-(void)refreshUI:(FoodModel *)foodmodel{
    
    _foodModel = foodmodel;
    [_imageView sd_setImageWithURL:[NSURL URLWithString:foodmodel.image]];
    _titleLabel.text = foodmodel.title;
    _desLabel.text = foodmodel.dishes_id;
    
}

@end
