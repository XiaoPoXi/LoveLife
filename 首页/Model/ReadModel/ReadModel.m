//
//  ReadModel.m
//  LoveLife
//
//  Created by 小破夕 on 15/12/30.
//  Copyright © 2015年 xiaopoxi. All rights reserved.
//

#import "ReadModel.h"

@implementation ReadModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.dataID = value;
    }
}

@end
