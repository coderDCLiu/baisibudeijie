//
//  LDCRecommandController.m
//  BaiSiBuDeiJie
//
//  Created by 刘冬城 on 2016/11/1.
//  Copyright © 2016年 刘冬城. All rights reserved.
//

#import "LDCRecommandController.h"

#import "LDCCategoryItem.h"
#import "LDCRecommandItem.h"
#import "LDCCategoryCell.h"
#import "LDCRecommandCell.h"

#import <MJRefresh.h>
#import <MJExtension.h>
#import <MJRefresh.h>
#import "AFHTTPSessionManager+Manager.h"

static NSString * const ID1 = @"category";
static NSString * const ID2 = @"user";

@interface LDCRecommandController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *categoryView;
@property (weak, nonatomic) IBOutlet UITableView *userTableView;

@property (strong, nonatomic) NSArray *categoryArray;
@property (strong, nonatomic) NSArray *recommandArray;
@property (strong, nonatomic) LDCCategoryItem *selectedCategory;

@property (strong, nonatomic) AFHTTPSessionManager *manager;
@end

@implementation LDCRecommandController

-(AFHTTPSessionManager *)manager
{
    if (_manager == nil) {
       _manager = [AFHTTPSessionManager ldc_manager];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"推荐关注";
    
    //设置代理数据源
    _categoryView.dataSource = self;
    _categoryView.delegate = self;
    _userTableView.dataSource = self;
    _userTableView.delegate = self;
    
    //注册cell
    [self.categoryView registerNib:[UINib nibWithNibName:@"LDCCategoryCell" bundle:nil] forCellReuseIdentifier:ID1];
    [self.userTableView registerNib:[UINib nibWithNibName:@"LDCRecommandCell" bundle:nil] forCellReuseIdentifier:ID2];
    
    //取消额外滚动区域
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.categoryView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.userTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    
    //请求左边数据
    [self loadCategoryData];
    
    //添加上下拉刷新
    [self addRefresh];
    
}

//添加上下拉刷新
-(void)addRefresh
{
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadUserData)];
    _userTableView.mj_header = header;
    
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadUserMoreData)];
    footer.automaticallyHidden = YES;
    _userTableView.mj_footer = footer;
    
}

//请求左边数据
-(void)loadCategoryData
{
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"a"] = @"category";
    dict[@"c"] = @"subscribe";
    [self.manager GET:LDCBaseUrl parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary*  _Nullable responseObject) {
        
//        NSLog(@"%@",responseObject);
        [responseObject writeToFile:@"/Users/liudongcheng/Desktop/程序/OC项目百思不得姐/项目资料/recommand.plist" atomically:YES];
        self.categoryArray = [LDCCategoryItem mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        [_categoryView reloadData];
        
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [_categoryView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
        [self tableView:_categoryView didSelectRowAtIndexPath:indexPath];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
    }];
}

//请求右边数据
-(void)loadUserData
{
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"a"] = @"list";
    dict[@"c"] = @"subscribe";
    dict[@"category_id"] = _selectedCategory.id;
    
    _selectedCategory.page = 1;
    [self.manager GET:LDCBaseUrl parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary*  _Nullable responseObject) {
        
        _selectedCategory.total_page = [responseObject[@"total_page"] integerValue];
        
        [_userTableView.mj_header endRefreshing];
        [_userTableView.mj_footer endRefreshing];
        
        _selectedCategory.page ++;
        
        
        _selectedCategory.user = [LDCRecommandItem mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [_userTableView reloadData];
        
        _userTableView.mj_footer.hidden = _selectedCategory.page > _selectedCategory.total_page;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
    }];
}
-(void)loadUserMoreData
{
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"a"] = @"list";
    dict[@"c"] = @"subscribe";
    dict[@"category_id"] = _selectedCategory.id;
    dict[@"page"] = @(_selectedCategory.page);
    
    [self.manager GET:LDCBaseUrl parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary*  _Nullable responseObject) {
        
        [_userTableView.mj_footer endRefreshing];
        [_userTableView.mj_header endRefreshing];
        
        _selectedCategory.page ++;
        
        
        NSArray *array = [LDCRecommandItem mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [_selectedCategory.user addObjectsFromArray:array];
        
        
        [_userTableView reloadData];
        
        _userTableView.mj_footer.hidden = _selectedCategory.page > _selectedCategory.total_page;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
    }];
}

#pragma mark - TableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _categoryView) {
        return self.categoryArray.count;
    } else {
        return _selectedCategory.user.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _categoryView) {
        LDCCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:ID1];
        cell.categoryItem = self.categoryArray[indexPath.row];
        return cell;
    }
    
        LDCRecommandCell *cell = [tableView dequeueReusableCellWithIdentifier:ID2];

    cell.recommandItem = _selectedCategory.user[indexPath.row];
    
        return cell;
    
    
}

#pragma mark - tableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _categoryView) {
        
        _selectedCategory = self.categoryArray[indexPath.row];
        
        [_userTableView reloadData];
        
        _userTableView.mj_footer.hidden = _selectedCategory.page > _selectedCategory.total_page;
        
        if (_selectedCategory.user.count == 0) {
            
            _userTableView.mj_footer.hidden = YES;
            [_userTableView.mj_header beginRefreshing];
        }
        
        
        
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _categoryView) {
        return 44;
    }else {
        return 70;
    }
}

-(void)dealloc
{
    NSLog(@"%s",__func__);
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
