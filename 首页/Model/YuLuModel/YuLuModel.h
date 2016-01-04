//
//  YuLuModel.h
//  LoveLife
//
//  Created by 小破夕 on 15/12/31.
//  Copyright © 2015年 xiaopoxi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YuLuModel : NSObject

/*
 "bad_count" = 130;
 "good_count" = 861;
 id = 1048741;
 "image_urls" =             (
 {
 large = "http://ww1.sinaimg.cn/large/a175e3a7jw1em7hhq7dyvj209h0dwdgz.jpg";
 middle = "http://ww1.sinaimg.cn/large/a175e3a7jw1em7hhq7dyvj209h0dwdgz.jpg";
 }
 );
 
 
 "pub_time" = "2014\U5e7411\U670811\U65e5 23:40";
 "publisher_icon_url" = "http://tp4.sinaimg.cn/3219590731/180/5680511258/1";
 "publisher_name" = "\U4e5e\U4e10";
 "share_count" = 153;
 text = "\U4f24\U5bb3\U4f60\U6700\U6df1\U7684\U4eba \U5f80\U5f80\U662f\U90a3\U4e9b\U58f0\U79f0\U6c38\U8fdc\U4e0d\U4f1a\U4f24\U5bb3\U4f60\U7684\U4eba";
 */

@property(nonatomic,copy)NSString *large ;
@property(nonatomic,copy)NSString *pub_time ;
@property(nonatomic,copy)NSString *publisher_icon_url ;
@property(nonatomic,copy)NSString *publisher_name ;
@property(nonatomic,copy)NSString *text ;
@property(nonatomic,copy)NSString *image_url;




@end
