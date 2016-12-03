//
//  LDCBaseTableViewController.m
//  BaiSiBuDeiJie
//
//  Created by 刘冬城 on 16/10/31.
//  Copyright © 2016年 刘冬城. All rights reserved.
//

#import "LDCBaseTableViewController.h"
#import "LDCNewController.h"
#import "LDCTopicItem.h"
#import "LDCAllCellTopView.h"
#import "LDCAllTableViewCell.h"
#import "LDCAllViewModel.h"
#import "LDCFooterRefreshView.h"
#import "LDCHeaderRefreshView.h"
#import "UIView+Fetch.h"

#import <AFNetworking.h>
#import <MJExtension.h>
#import <MJRefresh.h>

static NSString * const ID = @"All";

@interface LDCBaseTableViewController ()

@property (strong, nonatomic) NSMutableArray *viewModelArray;

@property (weak, nonatomic) LDCFooterRefreshView *footerView;

@property (weak, nonatomic) LDCHeaderRefreshView *headerView;

@property (strong, nonatomic) NSString *maxtime;

@property (assign, nonatomic) UIEdgeInsets oriInsets;

@property (weak, nonatomic) AFHTTPSessionManager *manager;

@end

@implementation LDCBaseTableViewController

-(AFHTTPSessionManager *)manager
{
    if (_manager == nil) {
        _manager = [AFHTTPSessionManager ldc_manager];
    }
    return _manager;
}

-(NSMutableArray *)viewModelArray
{
    if (_viewModelArray == nil) {
        _viewModelArray = [NSMutableArray array];
    }
    return _viewModelArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = [UIColor lightGrayColor];
    
    //注册cell
    [self.tableView registerClass:[LDCAllTableViewCell class] forCellReuseIdentifier:ID];
    
    //获取数据
    [self downLoadData];
    
    //取消分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    //调整滑动条的位置
    self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(99, 0, 49, 0);
    
    //添加上下拉刷新
    [self setUpRefresh];
    
    [self.tableView.mj_header beginRefreshing];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reload) name:@"repeatClickTab" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(scrollToTop) name:@"statusClick" object:nil];
}
-(void)reload
{
    UITableView *tableView = [[UIApplication sharedApplication].keyWindow fetchTableView];
    
    [tableView.mj_header beginRefreshing];
}
-(void)scrollToTop
{
    UITableView *tableView = [[UIApplication sharedApplication].keyWindow fetchTableView];
    
    [tableView setContentOffset:CGPointMake(0, -99) animated:YES];
}
//移除通知
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



//添加上下拉刷新
-(void)setUpRefresh
{
    //下拉刷新
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(downLoadData)];
    header.automaticallyChangeAlpha = YES;
    self.tableView.mj_header = header;
    
    //上拉刷新
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    footer.automaticallyHidden = YES;
    self.tableView.mj_footer = footer;
}
//请求数据
-(void)downLoadData
{
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    NSMutableDictionary * parameters = [NSMutableDictionary dictionary];
    
    NSString *a = @"list";
    if ([self.parentViewController isKindOfClass:[LDCNewController class]]) {
        a = @"newlist";
    }
    parameters[@"a"] = a;
    parameters[@"c"] = @"data";
    parameters[@"type"] = self.type;
    
    [self.manager GET:LDCBaseUrl parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary*  _Nullable responseObject) {
        
        [self.tableView.mj_header endRefreshing];
        
        
        //记录下一页的最大ID
        _maxtime = responseObject[@"info"][@"maxtime"];
        
        //        NSLog(@"%@",responseObject);
        [responseObject writeToFile:@"/Users/liudongcheng/Desktop/程序/OC项目百思不得姐/项目资料/All.plist" atomically:YES];
        
        NSArray *topic = [LDCTopicItem mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        for (LDCTopicItem *item in topic) {
            
            LDCAllViewModel *ldcViewModel = [[LDCAllViewModel alloc]init];
            
            ldcViewModel.ldcTopicItem = item;
            
            [self.viewModelArray addObject:ldcViewModel];
            
        }
        
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
        
    }];
}

//上拉加载更多数据
-(void)loadMoreData
{
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    NSMutableDictionary * parameters = [NSMutableDictionary dictionary];
    
    NSString *a = @"list";
    if ([self.parentViewController isKindOfClass:[LDCNewController class]]) {
        a = @"newlist";
    }
    parameters[@"a"] = a;
    parameters[@"c"] = @"data";
    parameters[@"type"] = self.type;
    parameters[@"maxtime"] = _maxtime;
    
    [self.manager GET:LDCBaseUrl parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary*  _Nullable responseObject) {
        
        [self.tableView.mj_footer endRefreshing];
        
        //记录下一页的最大ID
        _maxtime = responseObject[@"info"][@"maxtime"];
        
        //        NSLog(@"%@",responseObject);
        [responseObject writeToFile:@"/Users/liudongcheng/Desktop/程序/OC项目百思不得姐/项目资料/All.plist" atomically:YES];
        
        NSArray *topic = [LDCTopicItem mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        for (LDCTopicItem *item in topic) {
            
            LDCAllViewModel *ldcViewModel = [[LDCAllViewModel alloc]init];
            
            ldcViewModel.ldcTopicItem = item;
            
            [self.viewModelArray addObject:ldcViewModel];
            
        }
        
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
        
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.viewModelArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LDCAllTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    
    cell.ldcAllViewModel = self.viewModelArray[indexPath.row];
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [_viewModelArray[indexPath.row] cellH]+ 10;
}
/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
