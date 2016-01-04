//
//  FoodCollectionViewCell.h
//  LoveLife
//
//  Created by 小破夕 on 15/12/31.
//  Copyright © 2015年 xiaopoxi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FoodModel.h"

@protocol playDelegate <NSObject>

-(void)play:(FoodModel *)model;

@end

@interface FoodCollectionViewCell : UICollectionViewCell


{
    UIImageView *_imageView;
    
    UILabel *_titleLabel;
    
    UILabel *_desLabel;
    
    
}
//声明一个代理的对象   yong用weak防止循环引用导致内存泄露
//arc下的strong和weak相当于mrc下的retain和assign
@property(nonatomic,weak)id<playDelegate>delegate;



-(void)refreshUI:(FoodModel *)foodmodel;

@end
