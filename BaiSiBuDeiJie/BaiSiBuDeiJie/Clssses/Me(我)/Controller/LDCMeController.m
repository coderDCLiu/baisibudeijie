//
//  LDCMeController.m
//  BaiSiBuDeiJie
//
//  Created by 刘冬城 on 16/10/15.
//  Copyright © 2016年 刘冬城. All rights reserved.
//

#import "LDCMeController.h"
#import "LDCMeItem.h"
#import "LDCSettingController.h"
#import "LDCMeCollectionViewCell.h"
#import "LDCWebViewController.h"
#import <SafariServices/SafariServices.h>

#import <MJExtension.h>
#import <AFNetworking.h>
#import "AFHTTPSessionManager+Manager.h"

//设置cell的大小布局
static NSUInteger  const cols = 4;
static CGFloat  const margin = 1;
#define itemWH  (LDCScreenW - (cols - 1) * margin) / cols


static NSString *const ID = @"collection";

@interface LDCMeController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (strong, nonatomic) NSMutableArray *array;

@property (weak, nonatomic) UICollectionView *collectionView;

@end

@implementation LDCMeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航条上的内容
    [self setUpNavBar];
    
    
    //设置CollectionView
     self.collectionView = [self setUpCollectionView];
   
    //获取数据
    [self downLoadData];
    
    //设置tableView的组间距
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = 10;
    self.tableView.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0);
    
    
}

//设置导航条上的内容
-(void)setUpNavBar
{
    self.navigationItem.title = @"我的";
    
    UIBarButtonItem *nightMode = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"mine-moon-icon"] selectedImage:[UIImage imageNamed:@"mine-moon-icon-click"] target:self action:@selector(nightModeClick:)];
    
    
    UIBarButtonItem *setting = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"mine-setting-icon"] selectedImage:[UIImage imageNamed:@"mine-setting-icon-click"] target:self action:@selector(settingClick)];
    
    self.navigationItem.rightBarButtonItems = @[setting,nightMode];
}

//获取网络数据
-(void)downLoadData
{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager ldc_manager];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"square";
    parameters[@"c"] = @"topic";
    
    [manager GET:LDCBaseUrl parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary*  _Nullable responseObject) {

        //        NSLog(@"%@",responseObject);
        
        self.array = [LDCMeItem mj_objectArrayWithKeyValuesArray:responseObject[@"square_list"]];
        
        
        //补全空白的cell
        [self resloveData];
        
        //cell的行数
        NSUInteger rows = (self.array.count -1) / cols + 1;
        //计算内容的高度
        CGFloat height = rows * itemWH + margin * (rows - 1);
        self.collectionView.ldc_height = height;
        
        //设置尾部视图
        self.tableView.tableFooterView = self.collectionView;
        
        //刷新数据
        
        [self.collectionView reloadData];
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
         NSLog(@"%@",error);
        
    }];
    
    
}

//设置CollectionView
-(UICollectionView*)setUpCollectionView
{
    UICollectionViewFlowLayout *flowL = [[UICollectionViewFlowLayout alloc]init];
    
    flowL.itemSize = CGSizeMake(itemWH, itemWH);
    flowL.minimumLineSpacing = margin;
    flowL.minimumInteritemSpacing = margin;
    
    //设置collectionView
    UICollectionView *view = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, 0, 300) collectionViewLayout:flowL];
    view.backgroundColor = [UIColor clearColor];
    view.delegate = self;
    view.dataSource = self;
    
    [view registerNib:[UINib nibWithNibName:@"LDCMeCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:ID];
    view.showsVerticalScrollIndicator = NO;
    //设置尾部视图
    self.tableView.tableFooterView = view;
    
    return view;
    
}

//补全空白的cell
-(void)resloveData
{
   NSUInteger i = self.array.count % cols;
    
    if (i) {
        i = cols - i;
        for (int a = 0; a < i;a++) {
            LDCMeItem *ldcItem = [[LDCMeItem alloc]init];
            [self.array addObject:ldcItem];
        }
    }
    
}

#pragma mark - UICollectionView的代理方法

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.array.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LDCMeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    cell.ldcMeItem = self.array[indexPath.row];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    LDCMeItem *ldcItem = self.array[indexPath.row];
    NSURL *url = [NSURL URLWithString:ldcItem.url];
    
    LDCWebViewController *ldcWebVC = [[LDCWebViewController alloc]init];
    
    ldcWebVC.url = url;
    
    [self.navigationController pushViewController:ldcWebVC animated:YES];
    
//    SFSafariViewController *sfVC = [[SFSafariViewController alloc]initWithURL:url];
//    
//    [self presentViewController:sfVC animated:YES completion:nil];
    
    
    
    
}

//夜间模式按钮
-(void)nightModeClick:(UIButton*)btn
{
    btn.selected = !btn.selected;
}

//设置按钮
-(void)settingClick
{
    LDCSettingController *setting = [[LDCSettingController alloc]init];
    [self.navigationController pushViewController:setting animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
