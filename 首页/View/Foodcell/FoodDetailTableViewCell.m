//
//  FoodDetailTableViewCell.m
//  LoveLife
//
//  Created by 小破夕 on 16/1/4.
//  Copyright © 2016年 xiaopoxi. All rights reserved.
//

#import "FoodDetailTableViewCell.h"

@implementation FoodDetailTableViewCell



-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self makeUI];
    }
    
    return self;
}

-(void)makeUI
{
    _stepImageView = [FactoryUI createImageViewWithFrame:CGRectMake(10, 10,SCREEN_W - 20, 170) imageName:nil];
    [self.contentView addSubview:_stepImageView];
    
    _stepLabel = [FactoryUI createLabelWithFrame:CGRectMake(10, _stepImageView.frame.size.height + _stepImageView.frame.origin.y + 5, SCREEN_W - 20, 20) text:nil textColor:[UIColor darkGrayColor] font:[UIFont systemFontOfSize:16]];
    _stepLabel.numberOfLines = 0;
    _stepLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [self.contentView addSubview:_stepLabel];
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
