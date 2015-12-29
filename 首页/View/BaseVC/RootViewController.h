//
//  RootViewController.h
//  LoveLife
//
//  Created by 小破夕 on 15/12/29.
//  Copyright © 2015年 xiaopoxi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController

@property(nonatomic,strong) UIButton *leftButton ;
@property(nonatomic,strong) UILabel *titleLabel ;
@property(nonatomic,strong) UIButton *rightButton ;

-(void) setleftButtonClick:(SEL)selector;
-(void) setrightButtonClick:(SEL)selector;







@end
