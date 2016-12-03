//
//  LDCFreindTrendController.m
//  BaiSiBuDeiJie
//
//  Created by 刘冬城 on 16/10/15.
//  Copyright © 2016年 刘冬城. All rights reserved.
//

#import "LDCFreindTrendController.h"
#import "LDCLoginRegisterController.h"
#import "LDCRecommandController.h"


@interface LDCFreindTrendController ()

@end

@implementation LDCFreindTrendController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    
    self.navigationItem.title = @"我的关注";
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"friendsRecommentIcon"] hightLightImage:[UIImage imageNamed:@"friendsRecommentIcon-click"] target:self action:@selector(recommentClick)];
}

//登录注册按钮的点击
- (IBAction)loginRegisterClick:(id)sender {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"LDCLoginRegisterController" bundle:nil];
    
    UIViewController *vc = [storyboard instantiateInitialViewController];
    
    [self presentViewController:vc animated:YES completion:nil];
}

//导航条关注按钮的点击
-(void)recommentClick
{
    
    LDCRecommandController *vc = [[LDCRecommandController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
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
