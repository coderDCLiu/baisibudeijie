//
//  LDCSettingController.m
//  BaiSiBuDeiJie
//
//  Created by 刘冬城 on 16/10/17.
//  Copyright © 2016年 刘冬城. All rights reserved.
//

#import "LDCSettingController.h"
#import "LDCFileManager.h"

#import <SVProgressHUD.h>
#import <SDImageCache.h>

static NSString *const ID = @"cell";


@interface LDCSettingController ()

@property (strong, nonatomic) NSString *str;

@end

@implementation LDCSettingController

- (void)viewDidLoad {
    [super viewDidLoad];

    [SVProgressHUD showWithStatus:@"正在计算缓存"];
    
    [LDCFileManager getFileSizeStringWithDirectory:cachePath completion:^(NSString *fileStr) {
        
        [SVProgressHUD dismiss];
        
        self.str = fileStr;
        
        [self.tableView reloadData];
        
    }];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];

    
    cell.textLabel.text = [NSString stringWithFormat:@"清除缓存%@",self.str];
        


    return cell;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [LDCFileManager removeDirectoryFileWithDirectory:cachePath];
    
    self.str = @"";
    
    [self.tableView reloadData];
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
