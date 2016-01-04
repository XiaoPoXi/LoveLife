//
//  MusicViewController.m
//  LoveLife
//
//  Created by 小破夕 on 15/12/29.
//  Copyright © 2015年 xiaopoxi. All rights reserved.
//

#import "MusicViewController.h"
#import "MusicCell.h"


#import "MusicCollectionReusableView.h"


#import "MusicDetaliViewController.h"

@interface MusicViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

{
    UICollectionView *_collectionView;
    
    
    
    
}
@property(nonatomic,strong)NSArray *nameArray;
@property(nonatomic,strong)NSArray *urlArray;
@property(nonatomic,strong)NSArray *imageArray;

@end

@implementation MusicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    
    [self crateUI];

}


-(void)crateUI{
    
    //创建网格布局对象
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
//    设置滚动方向
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
//    创建网格对象昂
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    
    //设置背景色
    _collectionView.backgroundColor = [UIColor redColor];
    
    //设置代理
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    
    [self.view addSubview:_collectionView];
    
    //zhuce zhu注册cell
    [_collectionView registerClass:[MusicCell class] forCellWithReuseIdentifier:@"cell"];
    
    //zhuce注册
    [_collectionView registerClass:[MusicCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"view"];
    
    [_collectionView registerClass:[MusicCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"view"];
    
    
    
}

#pragma mark  - 协议方法
//确定cellection的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

//确定section对应item的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section;
{
    return self.imageArray.count;
}
//、、创建cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    MusicCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    [cell.imageView setImage:[UIImage imageNamed:self.imageArray[indexPath.row]]];
    [cell.titleLabel setText:self.nameArray[indexPath.row]];
    
    return cell;

}
//设置cell大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake((SCREEN_W - 20)/2, 150);
}
//设置垂直间距

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 5;
}
//水平间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 5;
}
//设置header大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(60    ,   30);
}
//设置footer大小

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeMake(60, 30);
}

//设置header  footer的view
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    MusicCollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"view" forIndexPath:indexPath];
    //fen分别给两个赋值
    
    
    //header
    if (kind == UICollectionElementKindSectionHeader ) {
        view.titlelabel.text = @"天啦撸";
        
    }else{
        view.titlelabel.text = @"地啦撸";
    }
    
    
    
    return view;
    
}

//四周的边距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    MusicDetaliViewController *detailVC = [[MusicDetaliViewController alloc] init];
    
    //传zhi
    detailVC.typeString = _nameArray[indexPath.item];
    detailVC.urlString = _urlArray[indexPath.item];
    
    
    detailVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailVC animated:YES];
    
    
}



-(void)settingNav{
    self.titleLabel.text = @"音乐";
}


-(void)initData{
    self.nameArray = @[@"流行",@"新歌",@"华语",@"英语",@"日语",@"轻音乐",@"民谣",@"韩语",@"歌曲排行榜"];
    self.urlArray = @[liuxing,xinge,huayu,yingyu,riyu,qingyinyue,minyao,hanyu,paihangbang];
    self.imageArray = @[@"shili0",@"shili1",@"shili2",@"shili8",@"shili10",@"shili19",@"shili15",@"shili13",@"shili24"];
}

















- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
