//
//  HomeModel.m
//  LoveLife
//
//  Created by 小破夕 on 15/12/29.
//  Copyright © 2015年 xiaopoxi. All rights reserved.
//

#import "HomeModel.h"

@implementation HomeModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    if ([key isEqualToString:@"id"]) {
        value = self.dataID;
    }
    
}


@end
