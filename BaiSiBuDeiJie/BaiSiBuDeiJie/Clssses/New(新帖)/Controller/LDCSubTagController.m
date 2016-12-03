//
//  LDCSubTagController.m
//  BaiSiBuDeiJie
//
//  Created by 刘冬城 on 16/10/18.
//  Copyright © 2016年 刘冬城. All rights reserved.
//

#import "LDCSubTagController.h"
#import "LDCSubTagItem.h"
#import "LDCSubTagTableViewCell.h"

#import <AFNetworking.h>
#import <MJExtension.h>
#import <SVProgressHUD.h>

#define SystemVersion [[UIDevice currentDevice].systemVersion floatValue]

@interface LDCSubTagController ()

@property (strong, nonatomic) NSArray *subTagArray;

@property (weak, nonatomic) AFURLSessionManager *manager;

@end

@implementation LDCSubTagController

static NSString * const ID = @"SubTag";

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self downLoadData];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"LDCSubTagTableViewCell" bundle:nil] forCellReuseIdentifier:ID];
    
//    self.tableView.separatorInset = UIEdgeInsetsZero;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.backgroundColor = [UIColor lightGrayColor];
}

//发送请求获取数据
-(void)downLoadData
{
    [SVProgressHUD showWithStatus:@"正在加载数据"];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager ldc_manager];
    self.manager = manager;
    
    NSDictionary *dict = @{
                           @"a":@"tag_recommend",
                           @"c":@"topic",
                           @"action":@"sub"
                           };
    
    [manager GET:@"http://api.budejie.com/api/api_open.php" parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSArray*  _Nullable responseObject) {
        
        [SVProgressHUD dismiss];
        
        self.subTagArray = [LDCSubTagItem mj_objectArrayWithKeyValuesArray:responseObject];
        
        [self.tableView reloadData];
        
//        NSLog(@"%@",responseObject);
//        [responseObject writeToFile:@"/Users/liudongcheng/Desktop/subTag.plist" atomically:YES];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
        
        [SVProgressHUD dismiss];
        
    }];
}
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.subTagArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LDCSubTagTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
//    if (SystemVersion > 8.0) {
//        cell.layoutMargins = UIEdgeInsetsZero;
//    }
    
    cell.ldcSubTagItem = self.subTagArray[indexPath.row];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70 + 1;
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [SVProgressHUD dismiss];
    
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
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
