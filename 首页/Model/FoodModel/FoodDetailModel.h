//
//  FoodDetailModel.h
//  LoveLife
//
//  Created by 小破夕 on 16/1/4.
//  Copyright © 2016年 xiaopoxi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FoodDetailModel : NSObject

@property(nonatomic,copy) NSString * dashes_id;
@property(nonatomic,copy) NSString * dishes_name;
@property(nonatomic,copy) NSString * image;
@property(nonatomic,copy) NSString * material_desc;
@property(nonatomic,copy) NSString * material_video;
@property(nonatomic,copy) NSString * process_video;
@property(nonatomic,copy) NSString * share_url;
@property(nonatomic,strong) NSArray * step;


@end
