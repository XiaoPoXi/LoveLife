//
//  FoodTitleCollectionViewCell.m
//  LoveLife
//
//  Created by 小破夕 on 15/12/31.
//  Copyright © 2015年 xiaopoxi. All rights reserved.
//

#import "FoodTitleCollectionViewCell.h"

@implementation FoodTitleCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.titleLabel = [FactoryUI createLabelWithFrame:CGRectMake(10, 10, (SCREEN_W -20) / 2, 30) text:nil textColor:[UIColor blueColor] font:[UIFont systemFontOfSize:16]];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.titleLabel];
        
    }
    
    return self;
}


@end
