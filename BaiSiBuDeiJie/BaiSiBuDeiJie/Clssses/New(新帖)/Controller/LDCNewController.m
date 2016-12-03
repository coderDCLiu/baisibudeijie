//
//  LDCNewController.m
//  BaiSiBuDeiJie
//
//  Created by 刘冬城 on 16/10/15.
//  Copyright © 2016年 刘冬城. All rights reserved.
//

#import "LDCNewController.h"
#import "LDCSubTagController.h"

#import "LDCAllController.h"
#import "LDCPictureController.h"
#import "LDCVideoController.h"
#import "LDCVoiceController.h"
#import "LDCTextController.h"


@interface LDCNewController ()

@end

@implementation LDCNewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor blueColor];
    
    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"MainTagSubIcon"] hightLightImage:[UIImage imageNamed:@"MainTagSubIconClick"] target:self action:@selector(subClick)];
    
    //为控制器添加子控制器
    [self setUpChildController];
    
}

//为控制器添加子控制器
-(void)setUpChildController
{
    //全部
    LDCAllController *ldcAllC = [[LDCAllController alloc]init];
    ldcAllC.title = @"全部";
    [self addChildViewController:ldcAllC];
    
    //视频
    LDCVideoController *ldcVideoC = [[LDCVideoController alloc]init];
    ldcVideoC.title = @"视频";
    [self addChildViewController:ldcVideoC];
    
    //声音
    LDCVoiceController *ldcVoiceC = [[LDCVoiceController alloc]init];
    ldcVoiceC.title = @"声音";
    [self addChildViewController:ldcVoiceC];
    
    //图片
    LDCPictureController *ldcPictureC = [[LDCPictureController alloc]init];
    ldcPictureC.title = @"图片";
    [self addChildViewController:ldcPictureC];
    
    //段子
    LDCTextController *ldcTextC = [[LDCTextController alloc]init];
    ldcTextC.title = @"段子";
    [self addChildViewController:ldcTextC];
    
}

-(void)subClick
{
    NSLog(@"subClick");
    
    LDCSubTagController *vc = [[LDCSubTagController alloc]init];
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
