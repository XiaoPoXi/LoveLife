//
//  MusicCollectionReusableView.m
//  LoveLife
//
//  Created by 小破夕 on 16/1/4.
//  Copyright © 2016年 xiaopoxi. All rights reserved.
//

#import "MusicCollectionReusableView.h"

@implementation MusicCollectionReusableView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.titlelabel = [FactoryUI createLabelWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height) text:nil textColor:[UIColor blueColor] font:[UIFont systemFontOfSize:15]];
        [self addSubview:_titlelabel];
        
    }
    return self;
}


@end
